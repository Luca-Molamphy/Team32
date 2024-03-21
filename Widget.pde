class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, lineColor, dataButtonColor;
  PFont widgetFont;

  Widget(int x, int y, int width, int height, String label, PFont widgetFont, int event) {
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetFont=widgetFont;
    labelColor= color(178, 34, 52);
    lineColor= color(178, 34, 52);
    dataButtonColor= color(255, 255, 0);
  }
  void draw() {
    if (label.equalsIgnoreCase("data")) {
      stroke(dataButtonColor);
      strokeWeight(3);
    } else {
      stroke(lineColor);
      strokeWeight(5);
    }
    noFill();
    rect(x, y, width, height);


    fill(label.equalsIgnoreCase("data") ? color(255,255,0) : labelColor);
    textFont(widgetFont);
    textAlign(CENTER);
    textSize(label.equalsIgnoreCase("data") ? 15 : 18);
    text(label, width/2 + x, height/2 + y + (label.equalsIgnoreCase("data") ? 5 : 7));
  }

  void mouseOver() {
    lineColor = color(192, 192, 192);
    dataButtonColor = color(192, 192, 192);
  }
  void mouseNotOver() {
    lineColor = color(178, 34, 52);
    labelColor= color(178, 34, 52);
    dataButtonColor= color(255, 255, 0);
  }
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }
}

void mouseMoved() {
  int event;
  ArrayList widgetList = currentScreen.getWidgets();
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      aWidget.mouseOver();
    } else
      aWidget.mouseNotOver();
  }
}
void mousePressed() {
  switch(currentScreen.getEvent(mouseX, mouseY)) {
  case EVENT_AIRPORT:
    println("Airport filter selected!");
    currentScreen = airportScreen;
   background(255);
    break;
  case EVENT_DATE:
    println("Date filter selected!");
    currentScreen = dateScreen;
    background(255);
    break;
  case EVENT_FLIGHT:
    println("Flight filter selected!");
    currentScreen = flightScreen;
    background(255);
    break;
  case EVENT_DATA:
    println("Data selected!");
    currentScreen = dataScreen;
    break;
  case EVENT_RETURN:
    println("Return selected!");
    currentScreen = homeScreen;
    background(255);
    break;
  }
}
