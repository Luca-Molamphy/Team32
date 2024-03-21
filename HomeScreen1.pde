// HomeScreen class
class HomeScreen {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, strokeColor;
  PFont widgetFont;

  // Constructor
  HomeScreen(int x, int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event;
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    labelColor = color(255); // White label color for all widgets
    strokeColor= color(0);
  }

  // Draw the widget
  void draw(boolean isHovered){
    fill(widgetColor);
    stroke(strokeColor);
    strokeWeight(2.5);
    if (isHovered) {
      rect(x - 5, y - 5, width + 10, height + 10, 10); // Rounded corners for hovered widget
    } else {
      rect(x, y, width, height, 10); // Rounded corners for regular widget
    }
    fill(labelColor);
    textFont(widgetFont);
    textAlign(CENTER, CENTER);
    text(label, x + width / 2, y + height / 2);
  }

  // Check if the widget is clicked
  boolean isClicked(int mX, int mY){
    return (mX > x && mX < x + width && mY > y && mY < y + height);
  }
}

PFont stdFont;
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
