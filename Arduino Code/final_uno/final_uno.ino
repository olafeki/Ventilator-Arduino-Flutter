#include <LiquidCrystal.h>
#include <ArduinoJson.h>

// create lcd object
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// json object to hold dat
JsonObject obj;

void setup() {
  lcd.begin(16, 2);
  lcd.clear();
  Serial.begin(9600);
}

void loop() {
  // create static json document
  StaticJsonDocument<1024> doc;

  if (Serial.available()) {
    // get first string in serial
    String msg = Serial.readStringUntil('\n');
    // convert string to json
    deserializeJson(doc, msg);
    Serial.println(msg);
    //serializeJsonPretty(doc, Serial);
    //Serial.println();
    //received_json.setJsonData(msg);
  }

  // get pressure and temperature from json
  float pressure = doc["pressure"];
  float temperature = doc["temperature"];

  // if pressure and temperature values are found, clear lcd and display values
  if(pressure!=0 && temperature !=0) {
    lcd.clear();
  }
  if(pressure != 0) {
    lcd.setCursor(0,0);
    lcd.print("P: ");
    lcd.print(pressure);
    lcd.print(" hPa");
  }
  if(temperature != 0) {
    lcd.setCursor(0,1);
    lcd.print("T: ");
    lcd.print(temperature);
    lcd.print(" *C");
  }
  
  delay(1000);
}
