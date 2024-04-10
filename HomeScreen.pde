// application main menu screen
class HomeScreen extends Screen {
  PImage planeImage, flagImage;

// Constructor which initialises the necessary images and adds widgets to enable screen navigation
  HomeScreen() {
    planeImage = loadImage("plane.jpg");
    flagImage = loadImage("usa.png");
    add(new Widget(90, 450, 150, 40, "Route", stdFont, EVENT_ROUTE));
    add(new Widget(280, 450, 150, 40, "Date", stdFont, EVENT_DATE));
    add(new Widget(470, 450, 150, 40, "Bar Chart", stdFont, EVENT_BAR_CHART));
    add(new Widget(660, 450, 150, 40, "Heat Map", stdFont, EVENT_HEAT));
    add(new Widget(840, 58, 50, 20, "Data", stdFont, EVENT_DATA));
    add(new Widget(90, 510, 150, 40, "Ordering", stdFont, EVENT_ORDERING));
  }

// Draw function which draws background image, displays flights loaded, and draws the "Flight Tracker" project title in a stylish manner
  void draw() {
    image(planeImage, 0, 0, 900, 600);
    fill(255);
    textSize(18);
    textAlign(RIGHT, TOP);
    text("Flights loaded", 900 - 10, 10);
    text(": " + getDataSize(), 900 - 10, 34);
    fill(178, 34, 52);
    text("Filter by:", 172, 424);
    fill(255);
    pushMatrix();
    rotate(radians(-3));
    textSize(48);
    textAlign(CENTER, BOTTOM);
    text("  FLIGHT", 190, 300);
    image(flagImage, 52, 266, 50, 34);
    rotate(radians(-9));
    text("TRACKER", 615, 365);
    popMatrix();
    
    super.draw();
  }
}
