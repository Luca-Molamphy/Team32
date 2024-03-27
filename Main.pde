PFont stdFont, flightFont;
final int EVENT_ROUTE=1;
final int EVENT_DATE=2;
final int EVENT_FLIGHT=3;
final int EVENT_HOME=4;
final int EVENT_DATA=5;
final int EVENT_RETURN=6;
final int EVENT_HEAT=7;
final int EVENT_NULL=0;
public int max;
int flightsLoaded;
PImage planeImage, flagImage, indexImage;
Screen currentScreen, homeScreen, routeScreen, dateScreen, flightScreen, heatScreen, dataScreen;

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  Widget filter1, filter2, filter3, filter4, data, returnButton;
  flightFont = loadFont("Arial-Black-14.vlw");
  PFont stdFont = loadFont("GillSans-Bold-48.vlw");
  filter1=new Widget(90, 450, 150, 40, "Route", stdFont, EVENT_ROUTE);
  filter2=new Widget(280, 450, 150, 40, "Date", stdFont, EVENT_DATE);
  filter3=new Widget(470, 450, 150, 40, "Flight", stdFont, EVENT_FLIGHT);
  filter4=new Widget(660, 450, 150, 40, "Heat Map", stdFont, EVENT_HEAT);
  data=new Widget(840, 58, 50, 20, "Data", stdFont, EVENT_DATA);
  returnButton =new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN);
  size(900, 600);
  planeImage = loadImage("plane.jpg");
  flagImage = loadImage("usa.png");
  usaMap = loadImage("americaMap.jpg");
  indexImage = loadImage("index.png");
  homeScreen = new Screen();
  routeScreen = new Screen();
  dateScreen = new Screen();
  flightScreen = new Screen();
  dataScreen = new Screen();
  heatScreen = new Screen();
  homeScreen.add(filter1);
  homeScreen.add(filter2);
  homeScreen.add(filter3);
  homeScreen.add(filter4);
  homeScreen.add(data);
  routeScreen.add(returnButton);
  dateScreen.add(returnButton);
  flightScreen.add(returnButton);
  dataScreen.add(returnButton);
  heatScreen.add(returnButton);
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
    background(0);
    textFont(flightFont);
    drawData();
  } else if (currentScreen == routeScreen) {
    background(255);
  } else if (currentScreen == dateScreen) {
    background(255);
  } else if (currentScreen == flightScreen) {
    background(255);
  } else if (currentScreen == heatScreen) {
    background(255);
    image(usaMap, 20, 65, 770, 435.9);
    drawHeatmap();
    textSize(18);
    fill(0);
    text(airportLocations.size(), 213, 560);
    image(indexImage, 10, 440, 300, 61.5);
    text(0, 10, 520.5);
    text(max, 310, 520.5);
    textSize(14);
    text("<-Number of flights at airport->", 160, 518.5);
    textSize(30);
    fill(178, 34, 52);
    text("HEAT MAP", 450, 40);
    fill(128, 0, 128);
    textSize(18);
    text("Index:", 40, 430);
    text("Airports Displayed: ", 103, 560);
  }
  currentScreen.draw();
}
int getDataSize() {
  flightsLoaded =  Data.isEmpty() ? 0 : Data.size()+1;
  return flightsLoaded;
}
