class CompareFlightOrigin implements Comparator<Flight> {
  public int compare(Flight l, Flight r) {
    return l.origin.compareTo(r.origin);
  }
}

class CompareFlightDestination implements Comparator<Flight> {
  public int compare(Flight l, Flight r) {
    return l.origin.compareTo(r.origin);
  }
}

class CompareFlightDistance implements Comparator<Flight> {
  public int compare(Flight l, Flight r) {
    if (l.distance < r.distance) {
      return -1;
    }
    if (l.distance > r.distance) {
      return +1;
    }
    return 0;
  }
}

class OrderingScreen extends Screen {
  int curFilter = -1;
  int highlighted = 0;
  OrderingScreen() {
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
    add(new Widget(520, CELL_SIZE * 5 + CELL_SIZE / 2 + 1, 160, 80, "Show Data", stdFont, EVENT_SHOW_DATA));
    add(new Widget(520, CELL_SIZE * 5 + + CELL_SIZE / 2 + 1 + 120, 160, 80, "Extract to CSV", stdFont, EVENT_EXTRACT_TO_CSV));
    add(new Widget(200, 80, 160, 80, "By Date", stdFont, EVENT_ORDER_BY_DATE));
    add(new Widget(200, 200, 160, 80, "By Origin", stdFont, EVENT_ORDER_BY_ORIGIN));
    add(new Widget(200, 320, 160, 80, "By Destination", stdFont, EVENT_ORDER_BY_DESTINATION));
    add(new Widget(200, 440, 160, 80, "By Distance", stdFont, EVENT_ORDER_BY_DISTANCE));
  }

  void filter() {
    filteredData.clear();
    for (int i = 0; i < inputData.size(); ++i) {
      filteredData.add(inputData.get(i));
    }
    switch (curFilter) {
      case EVENT_ORDER_BY_DATE:
        filteredData.sort(new CompareFlightDate());
        break;
      case EVENT_ORDER_BY_ORIGIN:
        filteredData.sort(new CompareFlightOrigin());
        break;
      case EVENT_ORDER_BY_DESTINATION:
        filteredData.sort(new CompareFlightDestination());
        break;
      case EVENT_ORDER_BY_DISTANCE:
        filteredData.sort(new CompareFlightDistance());
        break;
    }
    dataScreen.setData(filteredData);
  }
 
  void draw() {
    background(255);
    if (highlighted != 0) {
      fill(255, 200, 200);
      rect(200, highlighted, 160, 80);
    }
    textSize(30);
    fill(178, 34, 52);
    text("CHOOSE ORDERING FILTER", 450, 50);
    super.draw();
  }
  void refresh() {
    for (int i = 0; i < screenWidgets.size(); i++) {
      Widget aWidget = (Widget) screenWidgets.get(i);
      aWidget.mouseNotOver();
    }
    highlighted = 0;
  }
  int mousePressed(int mouseX, int mouseY) {
    int event = super.mousePressed(mouseX, mouseY);
    switch (event) {
      case EVENT_ORDER_BY_DATE:
        curFilter = EVENT_ORDER_BY_DATE;
        highlighted = 80;
        break;
      case EVENT_ORDER_BY_ORIGIN:
        curFilter = EVENT_ORDER_BY_ORIGIN;
        highlighted = 200;
        break;
      case EVENT_ORDER_BY_DESTINATION:
        curFilter = EVENT_ORDER_BY_DESTINATION;
        highlighted = 320;
        break;
      case EVENT_ORDER_BY_DISTANCE:
        curFilter = EVENT_ORDER_BY_DISTANCE;
        highlighted = 440;
        break;
    }
    return event;
  }
}
