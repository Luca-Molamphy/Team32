class CompareFlightDate implements Comparator<Flight> {
  public int compare(Flight l, Flight r) {
    return l.flightDate.compare(r.flightDate);
  }
}

//
// screen for selecting date range to filter data
//
class CalendarScreen extends Screen {
  PImage backgroundPlane;
  Calendar calendar = new Calendar(1, 2024);
  Date fromDate, toDate;
 
  CalendarScreen() {
    backgroundPlane = loadImage("turningPlane.jpg");
    fromDate = new Date(1, 1, 1900);
    toDate = new Date(1, 1, 1900);
    add(new Widget(520, CELL_SIZE * 5 + CELL_SIZE / 2 + 1, 160, 80, "Show Data", stdFont, EVENT_SHOW_DATA));
    add(new Widget(520, CELL_SIZE * 5 + + CELL_SIZE / 2 + 1 + 120, 160, 80, "Extract to CSV", stdFont, EVENT_EXTRACT_TO_CSV));
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
  }

  void updateDate(Date date) {
    fromDate = toDate;
    toDate = date;
  }

  void filter() {
    filteredData.clear();
    for (int i = 0; i < inputData.size(); ++i) {
      if (fromDate.compare(inputData.get(i).flightDate) < 1 &&
          inputData.get(i).flightDate.compare(toDate) < 1) {
        filteredData.add(inputData.get(i));
      }
    }
    filteredData.sort(new CompareFlightDate());
    dataScreen.setData(filteredData);
  }

  void draw() {
    image(backgroundPlane, 0, 0);
    calendar.draw();
    textSize(30);
    fill(178, 34, 52);
    text("CHOOSE DATE RANGE", 450, 30);
    fill(128, 0, 128);
    textSize(18);
    text("From: " + fromDate.toString(), 600, CELL_SIZE  + CELL_SIZE / 2 + 1);
    text("To: " + toDate.toString(), 600, CELL_SIZE * 3 + CELL_SIZE / 2 + 1);
    super.draw();
  }

  void mouseMoved(int mouseX, int mouseY) {
    calendar.highlight(mouseX, mouseY);

    super.mouseMoved(mouseX, mouseY);
  }

  int mousePressed(int mouseX, int mouseY) {
    int event = calendar.getEvent(mouseX, mouseY);
    if (event == EVENT_DATE_SELECTED)
      updateDate(calendar.getDate());

    return super.mousePressed(mouseX, mouseY);
  }
}
