PImage AmericaImg;
// Variables to store selected airports
int departureAirport = -1;
int arrivalAirport = -1;

void setup() {
  size(700, 600);
  textSize(16);
  AmericaImg = loadImage("UsMap.gif");
  AmericaImg.resize(600,500);
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
  
    // Display prompt based on the selected airports
  displayPrompt();
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
  fill(255);
  ellipse(x, y, 20, 20);
  
  // Draw airport label
  fill(150);
  textAlign(CENTER, CENTER);
  text(label, x, y - 25);
  
  // Draw selection marker if the airport is selected
  if (airportId == departureAirport || airportId == arrivalAirport) {
    noFill();
    stroke(255, 0, 0);
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
    default:
      return "";
  }
}

void mousePressed() {
  // Check if user clicked on an airport
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
    }
  } else if (arrivalAirport == -1) {
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
    }
  }
}

boolean isAirportClicked(int x, int y) {
  // Check if the mouse click is inside the airport circle
  float distance = dist(x, y, mouseX, mouseY);
  return distance <= 10;
}
