PImage AmericaImg;
// Variables to store selected airports
int departureAirport = -1;
int arrivalAirport = -1;
String inputText = "";
boolean isFocused = false;

void setup() {
  size(900, 600);
  textSize(25);
  AmericaImg = loadImage("UsMap.png");
  AmericaImg.resize(900, 600);
}

void draw() {
  background(255);

  // Draw the map of the USA
  drawMap(AmericaImg, x, y);

  // Draw airports
  drawAirport(LAX_X, LAX_Y, "LAX", 0);
  drawAirport(JFK_X, JFK_Y, "JFK", 1);
  drawAirport(SFO_X, SFO_Y, "SFO", 2);
  drawAirport(DFW_X, DFW_Y, "DFW", 3);
  drawAirport(BOS_X, BOS_Y, "BOS", 4);
  drawAirport(SEA_X, SEA_Y, "SEA", 5);
  drawAirport(DEN_X, DEN_Y, "DEN", 6);
  drawAirport(DCA_X, DCA_Y, "DCA", 7);
  drawAirport(FLL_X, FLL_Y, "FLL", 8);
  drawAirport(LAS_X, LAS_Y, "LAS", 9);
  drawAirport(HNL_X, HNL_Y, "HNL", 10);
  drawAirport(ORD_X, ORD_Y, "ORD", 11);
  drawAirport(DAL_X, DAL_Y, "DAL", 12);
  drawAirport(HOU_X, HOU_Y, "HOU", 13);
  drawAirport(MCI_X, MCI_Y, "MCI", 14);
  drawAirport(ATW_X, ATW_Y, "ATW", 15);

  // Display prompt based on the selected airports
  displayPrompt();
  drawSearchBar();
 
  
}

void drawMap(PImage AmericaImg, int x, int y) {

  fill(200);
  noStroke();
  image(AmericaImg, 0, 0);
  fill(0);
}

void drawAirport(int x, int y, String label, int airportId) {
  // Draw airport circle
  stroke(0);
  fill(255, 0, 0);
  ellipse(x, y, 15, 15);

  // Draw airport label
  fill(0);
  textAlign(CENTER, CENTER);
  text(label, x, y - 25);

  // Draw selection marker if the airport is selected
  if (airportId == departureAirport || airportId == arrivalAirport) {
    noFill();
    stroke(0);
    ellipse(x, y, 30, 30);
  }
}

void displayPrompt() {
  String prompt;

  if (departureAirport == -1) {
    prompt = "Please select a departure airport.";
  } else if (arrivalAirport == -1) {
    prompt = "Please select an arrival airport.";
  } else {
    prompt = "Departure: " + getAirportName(departureAirport) + ", Arrival: " + getAirportName(arrivalAirport);
  }

  textAlign(CENTER, CENTER);
  fill(0);
  text(prompt, width / 2, 20);
}

String getAirportName(int airportId) {
  switch (airportId) {
  case 0:
    return "LAX";
  case 1:
    return "JFK";
  case 2:
    return "SFO";
  case 3:
    return "DFW";
  case 4:
    return "BOS";
  case 5:
    return "SEA";
  case 6:
    return "DEN";
  case 7:
    return "DCA";
  case 8:
    return "FLL";
  case 9:
    return "LAS";
  case 10:
    return "HNL";
  case 11:
    return "ORD";
  case 12:
    return "DAL";
  case 13:
    return "HOU";
  case 14:
    return "MCI";
  case 15:
    return "ATW";
  default:
    return "";
  }
}

void mousePressed() {
  // Check if user clicked on an airport
 if (mouseX > 650 && mouseX < 850 && mouseY > 50 && mouseY < 80) {
    isFocused = true;
  } else {
    isFocused = false;
  }
  
  if (departureAirport == -1) {
    if (isAirportClicked(LAX_X, LAX_Y)) {
      departureAirport = 0;
    } else if (isAirportClicked(JFK_X, JFK_Y)) {
      departureAirport = 1;
    } else if (isAirportClicked(SFO_X, SFO_Y)) {
      departureAirport = 2;
    } else if (isAirportClicked(DFW_X, DFW_Y)) {
      departureAirport = 3;
    } else if (isAirportClicked(BOS_X, BOS_Y)) {
      departureAirport = 4;
    } else if (isAirportClicked(SEA_X, SEA_Y)) {
      departureAirport = 5;
    } else if (isAirportClicked(DEN_X, DEN_Y)) {
      departureAirport = 6;
    } else if (isAirportClicked(DCA_X, DCA_Y)) {
      departureAirport = 7;
    } else if (isAirportClicked(FLL_X, FLL_Y)) {
      departureAirport = 8;
    } else if (isAirportClicked(LAS_X, LAS_Y)) {
      departureAirport = 9;
    } else if (isAirportClicked(HNL_X, HNL_Y)) {
      departureAirport = 10;
    } else if (isAirportClicked(ORD_X, ORD_Y)) {
      departureAirport = 11;
    } else if (isAirportClicked(DAL_X, DAL_Y)) {
      departureAirport = 12;
    } else if (isAirportClicked(HOU_X, HOU_Y)) {
      departureAirport = 13;
    } else if (isAirportClicked(MCI_X, MCI_Y)) {
      departureAirport = 14;
    } else if (isAirportClicked(ATW_X, ATW_Y)) {
      departureAirport = 15;
    } 
  }   else if (arrivalAirport == -1) {
      if (isAirportClicked(LAX_X, LAX_Y) && departureAirport != 0) {
        arrivalAirport = 0;
      } else if (isAirportClicked(JFK_X, JFK_Y) && departureAirport != 1) {
        arrivalAirport = 1;
      } else if (isAirportClicked(SFO_X, SFO_Y) && departureAirport != 2) {
        arrivalAirport = 2;
      } else if (isAirportClicked(DFW_X, DFW_Y) && departureAirport != 3) {
        arrivalAirport = 3;
      } else if (isAirportClicked(BOS_X, BOS_Y) && departureAirport != 4) {
        arrivalAirport = 4;
      } else if (isAirportClicked(SEA_X, SEA_Y) && departureAirport != 5) {
        arrivalAirport = 5;
      } else if (isAirportClicked(DEN_X, DEN_Y) && departureAirport != 6) {
        arrivalAirport = 6;
      } else if (isAirportClicked(DCA_X, DCA_Y) && departureAirport != 7) {
        arrivalAirport = 7;
      } else if (isAirportClicked(FLL_X, FLL_Y) && departureAirport != 8) {
        arrivalAirport = 8;
      } else if (isAirportClicked(LAS_X, LAS_Y) && departureAirport != 9) {
        arrivalAirport = 9;
      } else if (isAirportClicked(HNL_X, HNL_Y) && departureAirport != 10) {
        arrivalAirport = 10;
      } else if (isAirportClicked(ORD_X, ORD_Y) && departureAirport != 11) {
        arrivalAirport = 11;
      } else if (isAirportClicked(DAL_X, DAL_Y) && departureAirport != 12) {
        arrivalAirport = 12;
      } else if (isAirportClicked(HOU_X, HOU_Y) && departureAirport != 13) {
        arrivalAirport = 13;
      } else if (isAirportClicked(MCI_X, MCI_Y) && departureAirport != 14) {
        arrivalAirport = 14;
      } else if (isAirportClicked(ATW_X, ATW_Y) && departureAirport != 15) {
        arrivalAirport = 15;
      }
    }
  }

void drawSearchBar() {
  fill(255); // White background
  rect(650, 50, 200, 30); // Adjust size and position as needed
  fill(0); // Black text
  text(inputText, 660, 70);
}

void keyTyped() {
  if (isFocused) {
    if (key == BACKSPACE) {
      if (inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      }
    } else {
      inputText += key;
    }
  }
}

  boolean isAirportClicked(int x, int y) {
    // Check if the mouse click is inside the airport circle
    float distance = dist(x, y, mouseX, mouseY);
    return distance <= 10;
  }
