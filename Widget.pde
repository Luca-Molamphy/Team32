class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, lineColor, dataButtonColor, switchMapColor;
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
    switchMapColor= color(0);
  }
  void draw() {
    if (label.equalsIgnoreCase("data")) {
      stroke(dataButtonColor);
      strokeWeight(3);
    } else if (label.equalsIgnoreCase("alaska") || label.equalsIgnoreCase("back")) {
      stroke(switchMapColor);
      strokeWeight(5);
    } else {
      stroke(lineColor);
      strokeWeight(5);
    }
    noFill();
    rect(x, y, width, height);


    fill(label.equalsIgnoreCase("data") ? color(255, 255, 0) : labelColor);
    if (label.equalsIgnoreCase("alaska") || label.equalsIgnoreCase("back")) {
      fill(0);
    }
    textFont(widgetFont);
    textAlign(CENTER);
    textSize(label.equalsIgnoreCase("data") ? 15 : 18);
    text(label, width/2 + x, height/2 + y + (label.equalsIgnoreCase("data") ? 5 : 7));
  }

  void mouseOver() {
    lineColor = color(192, 192, 192);
    dataButtonColor = color(192, 192, 192);
    switchMapColor = color(192, 192, 192);
  }
  void mouseNotOver() {
    lineColor = color(178, 34, 52);
    labelColor= color(178, 34, 52);
    dataButtonColor= color(255, 255, 0);
    switchMapColor = color(0);
  }
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }
}
