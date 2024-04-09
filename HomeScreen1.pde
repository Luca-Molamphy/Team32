class HomeScreen extends Screen {
  PImage planeImage, flagImage;

// Constructor which initialises the necessary images and adds widgets to enable screen navigation
  HomeScreen() {
    planeImage = loadImage("plane.jpg");
    flagImage = loadImage("usa.png");
    add(new Widget(90, 450, 150, 40, "Route", stdFont, EVENT_ROUTE));
    add(new Widget(280, 450, 150, 40, "Date", stdFont, EVENT_DATE));
    add(new Widget(470, 450, 150, 40, "Bar Chart", stdFont, EVENT_FLIGHT));
    add(new Widget(660, 450, 150, 40, "Heat Map", stdFont, EVENT_HEAT));
    add(new Widget(840, 58, 50, 20, "Data", stdFont, EVENT_DATA));
    add(new Widget(90, 510, 150, 40, "Ordering", stdFont, EVENT_ORDERING));
  }

// Draw function which draws background image, displays flights loaded, and draws the "Flight Tracker" project title in stylish manner
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
    text("  FLIGHT", 190, 310);
    image(flagImage, 52, 266, 50, 34);
    rotate(radians(-9));
    text("TRACKER", 615, 375);
    popMatrix();
    
    super.draw();
  }
}

/*
HomeScreen flightWidget, dateWidget, airportWidget;
color bgColor;

void setup(){
  size(800, 600);
  stdFont = createFont("Arial", 32);
  textFont(stdFont);

  // Define background color
  bgColor = color(240);

  // Flight widget
  flightWidget = new HomeScreen(100, 350, 150, 50, "FLIGHT", color(50, 168, 82), stdFont, 1);
  
  // Date widget
  dateWidget = new HomeScreen(300, 350, 150, 50, "DATE", color(50, 148, 168), stdFont, 2);
  
  // Airport widget
  airportWidget = new HomeScreen(500, 350, 150, 50, "AIRPORT", color(168, 50, 50), stdFont, 3);
}

void draw(){
  background(bgColor);
  
  // Display title
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("Flight Tracker", width / 2, 100); // Adjusted y-coordinate to move it lower
  
  // Check if any widget is hovered
  boolean isFlightWidgetHovered = flightWidget.isClicked(mouseX, mouseY);
  boolean isDateWidgetHovered = dateWidget.isClicked(mouseX, mouseY);
  boolean isAirportWidgetHovered = airportWidget.isClicked(mouseX, mouseY);
  
  // Draw widgets
  flightWidget.draw(isFlightWidgetHovered);
  dateWidget.draw(isDateWidgetHovered);
  airportWidget.draw(isAirportWidgetHovered);
}

void mouseClicked(){
  // Check if any widget is clicked
  if(flightWidget.isClicked(mouseX, mouseY)){
    println("Flight widget clicked");
    // Implement action for flight widget click
  }
  else if(dateWidget.isClicked(mouseX, mouseY)){
    println("Date widget clicked");
    // Implement action for date widget click
  }
  else if(airportWidget.isClicked(mouseX, mouseY)){
    println("Airport widget clicked");
    // Implement action for airport widget click
  }
}
*/
