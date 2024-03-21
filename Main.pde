PFont stdFont;
final int EVENT_AIRPORT=1;
final int EVENT_DATE=2;
final int EVENT_FLIGHT=3;
final int EVENT_HOME=4;
final int EVENT_DATA=5;
final int EVENT_RETURN=6;
final int EVENT_NULL=0;
PImage planeImage, flagImage;
Screen currentScreen, homeScreen, airportScreen, dateScreen, flightScreen, dataScreen;

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  Widget filter1, filter2, filter3, data, returnButton;
  PFont flightFont = loadFont("Arial-Black-14.vlw");
  PFont stdFont = loadFont("GillSans-Bold-48.vlw");
  filter1=new Widget(90, 450, 210, 40, "Airport", stdFont, EVENT_AIRPORT);
  filter2=new Widget(345, 450, 210, 40, "Date", stdFont, EVENT_DATE);
  filter3=new Widget(600, 450, 210, 40, "Flight", stdFont, EVENT_FLIGHT);
  data=new Widget(840, 58, 50, 20, "Data", stdFont, EVENT_DATA);
  returnButton =new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN);
  size(900, 600);
  planeImage = loadImage("plane.jpg");
  flagImage = loadImage("usa.png");
  homeScreen = new Screen();
  airportScreen = new Screen();
  dateScreen = new Screen();
  flightScreen = new Screen();
  dataScreen = new Screen();
  homeScreen.add(filter1);
  homeScreen.add(filter2);
  homeScreen.add(filter3);
  homeScreen.add(data);
  airportScreen.add(returnButton);
  dateScreen.add(returnButton);
  flightScreen.add(returnButton);
  dataScreen.add(returnButton);
  currentScreen = homeScreen;
}
void draw() {
  if (currentScreen == homeScreen) {
    image(planeImage, 0, 0, 900, 600);
    
    fill(255);
    textSize(18);
    textAlign(RIGHT, TOP);
    text("Flights loaded", 900 - 10, 10);
    text(": " + getDataSize(), 900 - 10, 34);
    fill(178, 34, 52);
    text("Filter by:", 172, 424);
    currentScreen.draw();
    fill(255);
    pushMatrix();
    rotate(radians(-3));
    textSize(48);
    text("  FLIGHT", 190, 300);
    image(flagImage, 52, 266, 50, 34);
    rotate(radians(-9));
    text("TRACKER", 615, 365);
    popMatrix();
  } else if (currentScreen == dataScreen) {
    drawData();
  }
  currentScreen.draw();
}
int getDataSize() {
  flightsLoaded =  Data.isEmpty() ? 0 : Data.size()+1;
  return flightsLoaded;
}
