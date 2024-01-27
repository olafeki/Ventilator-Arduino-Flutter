#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_AHTX0.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "Viki's Galaxy A321D06"   // define wifi name and password
#define WIFI_PASSWORD "NeorangNaranhi_8"

#define API_KEY "AIzaSyB6gXcrJJTvQLTfifbLMIdo6F2Y6MvLKqs" // Define the project api key
#define DATABASE_URL "https://session5-179dc-default-rtdb.firebaseio.com/" // Define the RTDB URL

#define USER_EMAIL "verinamichelk@gmail.com"  // Insert Authorized Email and Corresponding Password
#define USER_PASSWORD "123456"

// Define Firebase objects
FirebaseData stream;
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
FirebaseJson json;

// Variables to save database paths
String databasePath;
String parent_path;
String temperature_path = "/temperature";
String humidity_path = "/humidity";
String pressure_path = "/pressure";
String time_path = "/epoch_time";


const char* ntpServer = "pool.ntp.org";   // Define Network Time Protocl Server Client to get time

// I2C sensors
Adafruit_BME280 bme;
Adafruit_AHTX0 aht;
//#define SEALEVELPRESSURE_HPA (1013.25)

// Variable to save database data
String uid;
int timestamp;
float humidity;
float pressure;
float temperature;

// Serial communication pins
#define RXp2 16
#define TXp2 17

// motor driver pins
# define enA 14
# define in1 27
# define in2 26

// variables for dc motor calculations
const double VELOCITY = 240.0/4100; // velocity in mm/ms
int bpm_input = -1;
int breath_ms;
int first_delay;
boolean flag = false;

// Function that gets current epoch time
unsigned long getTime() {
  time_t now;
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    // Serial.println("Failed to obtain time");
    return (0);
  }
  time(&now);
  return now;
}

// Initialize WiFi
void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(1000);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}

// Initialize BME280
void initBME(){
  if (!bme.begin(0x76)) {
    Serial.println("Could not find a valid BME280 sensor, check wiring!");
    while (1);
  }
  else {
    Serial.println("BME280 iniialized");
  }
}

// Initialize AHT21B
void initAHT(){
  if (!aht.begin(&Wire, 0, 0x38)) {
    Serial.println("Could not find a valid AHT21B sensor, check wiring!");
    while (1);
  }
  else {
    Serial.println("AHT21B iniialized");
  }
}

// function to get the time the motor should move at the beginning
int getFirstDelay() {
 // since the path the handle has to move to squeeze the ambu is too big,
 // by setting the velocity to the known max velocity, and calculating the breath time from bpm
 // the distance required can be calculated.. then we calculate the extra distance
 // and calculate the time required to move that distance
 // so we can position the handle at the required distance before calling the breatheOnce() function
 
 double breath_dist = (VELOCITY*breath_ms)/2.0; // distance required to breathe = V*t
 double remaining_dist = 240 - breath_dist;   
 int delay_time = remaining_dist/VELOCITY;   // time = 
 Serial.print("First Delay: ");
 Serial.print(delay_time);
 Serial.print("\n");
 return (delay_time+1);
}

// function to squeeze the ambu bag once
void breatheOnce(int breath_time) {
  // go forward
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);

  delay(breath_time/2);
  // if bpm is 12, breath_time is 6.. so the handle should move forward 3 seconds, then backwards 3 seconds
  
  // go backward
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);

  delay(breath_time/2);
  
}

// function to adjust vent handle position
void setupVent() {
  
  // return to start line
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  delay(4100);

  // wait 2 seconds
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  delay(2000);

  // calculate breath time from bpm (if 12 beats in 60 seconds.. 1 beat in ??? seconds)
  breath_ms = 60000/bpm_input;
  Serial.print("Breath Time: ");
  Serial.print(breath_ms);
  Serial.print("\n");

  // calculate first delay and position the handle at the required distance
  first_delay = getFirstDelay();
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  delay(first_delay);

  // wait 2 seconds
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  delay(2000);
}

// stream callback.. listening for new input at /bmp node
void streamCallback(FirebaseStream data)
{
  
  if (data.dataTypeEnum() == fb_esp_rtdb_data_type_json)
  {
      FirebaseJson *json = data.to<FirebaseJson *>();
      //Serial.println(json->raw());
      
      FirebaseJsonData result;

      // if breathRate key is found in data..
      // proceed to setup ventilator and set flag = true to start breathing
      json -> get(result,"breathRate");
      if(result.success)
      {
        flag = false;
        bpm_input = (result.to<String>()).toInt();
        Serial.print("BPM: ");
        Serial.print(bpm_input);
        Serial.print("\n");
        setupVent();
        flag = true;
      }
      
  }
     
}

// if stream timeout
void streamTimeoutCallback(bool timeout)
{
  if(timeout){
    // Stream timeout occurred
    Serial.println("timeout: Stream timeout, resume streaming...");
  }  
}


// task handle.. to create a second task that runs in parallel
TaskHandle_t ReadSensors;

void setup() {

  Serial.begin(115200);
  Serial2.begin(9600, SERIAL_8N1, RXp2, TXp2);  // serial communication ith arduino uno

  initBME();
  initAHT();
  initWiFi();
  configTime(0, 0, ntpServer);
  
  // Assign the api key and rtdb url to config object
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  
  // Assign the user sign in credentials
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;  

  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096);

  // Assign the callback function for the long running token generation task
  config.token_status_callback = tokenStatusCallback;
  // Assign the maximum retry of token generation
  config.max_token_generation_retry = 5;

  // Initialize the library with the Firebase authen and config
  Firebase.begin(&config, &auth);

  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  // Print user UID
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  // Update database path
  // databasePath = "/UsersData/" + uid;
  databasePath = "/SensorData/";

  // listen for new input in /bmp node
  Firebase.RTDB.setStreamCallback(&stream, streamCallback, streamTimeoutCallback);
  if (!Firebase.RTDB.beginStream(&stream, "/bmp"))
  {
    // Could not begin stream connection, then print out the error detail
    Serial.println("begin stream: ");
    Serial.println(fbdo.errorReason());
  }

  // dc motor pins pin mode
  pinMode(enA, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  // turn motor off
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  // use maximum speed
  analogWrite(enA, 255); 
  
  //create a task that will be executed in the SensorsCode() function
  xTaskCreatePinnedToCore(
                    SensorsCode,   /* Task function. */
                    "ReadSensors",     /* name of task. */
                    10000,       /* Stack size of task */
                    NULL,        /* parameter of the task */
                    1,           /* priority of the task */
                    &ReadSensors,      /* Task handle to keep track of created task */
                    0);          /* pin task to core 0 */                  
  delay(500); 

}

//Task1: get sensors reading and write then to database..
void SensorsCode( void * pvParameters ){
  Serial.print("Task1 - Get Sensor Readings - running on core ");
  Serial.println(xPortGetCoreID());
  
  // Timer variables (send new readings every five seconds)
  unsigned long sendDataPrevMillis = 0;
  unsigned long timerDelay = 5000;
  
  // loop code
  for(;;){
    
    if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)){
      // get timestamp
      sendDataPrevMillis = millis();
      timestamp =  getTime();
      Serial.print ("time: ");
      Serial.println (timestamp);

      // update database path
      parent_path= databasePath + "/" + String(timestamp);

      // aht events to get sensor readings
      sensors_event_t temp_event, humidity_event;
      aht.getEvent(&humidity_event, &temp_event);

      // write sensor readings to json object
      json.set(temperature_path.c_str(), String(temp_event.temperature));
      json.set(humidity_path.c_str(), String(humidity_event.relative_humidity));
      json.set(pressure_path.c_str(), String(bme.readPressure()/100.0F));
      json.set(time_path, String(timestamp));
      // add node to database
      Serial.printf("Set json...%s\n",Firebase.RTDB.setJSON(&fbdo, parent_path.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
  
        // send json with sensor readings as string to arduino uno
       json.toString(Serial2,false);
       Serial2.print("\n");
       json.clear();  // clear data in json object
   }
  } 
}

void loop() {

  // keep breathing if flag is true
  if(flag == true) {
      Serial.println(flag);
      breatheOnce(breath_ms);
    }
}
