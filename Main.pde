import java.util.*; //<>//

final int EVENT_ROUTE=1;
final int EVENT_DATE=2;
final int EVENT_FLIGHT=3;
final int EVENT_HOME=4;
final int EVENT_DATA=5;
final int EVENT_RETURN=6;
final int EVENT_HEAT=7;
final int EVENT_SHOW_DATA = 8;
final int EVENT_EXTRACT_TO_CSV = 9;
final int EVENT_DATE_SELECTED = 10;
final int EVENT_ORDER_BY_DATE = 11;
final int EVENT_ORDER_BY_ORIGIN = 12;
final int EVENT_ORDER_BY_DESTINATION = 13;
final int EVENT_ORDER_BY_DISTANCE = 14;
final int EVENT_ORDERING = 15;
final int EVENT_NULL=0;

PFont stdFont;
Screen currentScreen, previousScreen;
HomeScreen homeScreen;
DataScreen dataScreen;
HeatScreen heatScreen;
Screen routeScreen, flightScreen;
CalendarScreen dateScreen;
OrderingScreen orderingScreen;

void setup() {
  stdFont = loadFont("GillSans-Bold-48.vlw"); //<>//
  Widget returnButton =new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN);
  size(900, 600);
  homeScreen = new HomeScreen();
  routeScreen = new Screen();
  dateScreen = new CalendarScreen();
  flightScreen = new Screen();
  dataScreen = new DataScreen();
  heatScreen = new HeatScreen();
  orderingScreen = new OrderingScreen();

  currentScreen = homeScreen;
  previousScreen = currentScreen;
 
  routeScreen.add(returnButton);
  flightScreen.add(returnButton);

  selectInput("Select a file to process:", "inputSelected");
}

ArrayList<Flight> inputData = new ArrayList<Flight>();
ArrayList<Flight> filteredData = new ArrayList<Flight>();

void inputSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String[] lines = loadStrings(selection);
    for (int i = 1; i < lines.length; i++) {
      Flight flight = new Flight(splitStr(lines[i], ','));
      inputData.add(flight);
      heatScreen.addFlight(flight);
    }
  }
  heatScreen.loadAirportData("iatalatlong.csv");
  dataScreen.setData(inputData);
  FlightOrigin[] origins = prevailingOrigins(5);
  for (int i = 0; i < 5; ++i) {
    println(origins[i].origin + ": " + origins[i].count);
  }
}

void outputSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String[] lines = new String[filteredData.size()];
    for (int i = 0; i < lines.length; ++i) {
      lines[i] = filteredData.get(i).toString();
    }
    saveStrings(selection, lines);
  }
}

void draw() {
  currentScreen.draw();
} //<>//

void mouseMoved() {
  currentScreen.mouseMoved(mouseX, mouseY);
}

void mousePressed() {
  int event = currentScreen.mousePressed(mouseX, mouseY);
  switch (event) {
  case EVENT_ROUTE:
    println("Airport filter selected!");
    changeScreen(routeScreen);
    break;
  case EVENT_DATE:
    println("Date filter selected!");
    changeScreen(dateScreen);
    break;
  case EVENT_FLIGHT:
    println("Flight filter selected!");
    changeScreen(flightScreen);
    break;
  case EVENT_DATA:
    println("Data selected!");
    changeScreen(dataScreen);
    break;
  case EVENT_RETURN:
    println("Return selected!");
    changeScreen(previousScreen);
    previousScreen = homeScreen;
    break;
  case EVENT_HEAT:
    println("Heat Map selected!");
    changeScreen(heatScreen);
    break;
  case EVENT_ORDERING:
    println("Heat Ordering selected!");
    changeScreen(orderingScreen);
    break;
  case EVENT_SHOW_DATA:
    println("Show data selected!");
    currentScreen.filter();
    previousScreen = currentScreen;
    changeScreen(dataScreen);
    break;
  case EVENT_EXTRACT_TO_CSV:
    currentScreen.filter();
    selectOutput("Save to CSV", "outputSelected");
    break;
  }
}

void changeScreen(Screen screen) {
  currentScreen = screen;
  currentScreen.refresh();
}

void mouseWheel(MouseEvent event) {
  currentScreen.mouseWheel(event);
}

int getDataSize() {
  return inputData.isEmpty() ? 0 : inputData.size() + 1;
}
