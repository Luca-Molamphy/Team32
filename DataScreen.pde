class DataScreen extends Screen {
  final int FLIGHTS_ON_THE_SCREEN = 28;
  PFont flightFont;
  int firstFlightToDisplayIdx = 0;
  ArrayList<Flight> data;
 
  DataScreen() {
    flightFont = loadFont("Arial-Black-14.vlw");
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
  }

  void setData(ArrayList<Flight> data) {
    this.data = data;
    firstFlightToDisplayIdx = 0;
  }

  void draw() {
    background(0);
    textFont(flightFont);

    int curX = 10;
    int curY = 14;
    textAlign(LEFT, TOP);
    for (int i = firstFlightToDisplayIdx; i < min(firstFlightToDisplayIdx + FLIGHTS_ON_THE_SCREEN, data.size()); ++i) {
      fill(255);
      textSize(13);
      text(data.get(i).toString(), curX, curY);
      curY += 23;
    }
    super.draw();
  }

  void mouseWheel(MouseEvent event) {
    int scrolls = event.getCount();
    firstFlightToDisplayIdx += scrolls;
    if (firstFlightToDisplayIdx > data.size() - FLIGHTS_ON_THE_SCREEN) {
      firstFlightToDisplayIdx = data.size() - FLIGHTS_ON_THE_SCREEN;
    }
    if (firstFlightToDisplayIdx < 0) {
      firstFlightToDisplayIdx = 0;
    }
  }
}
