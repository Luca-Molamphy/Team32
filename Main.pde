import java.util.*; //<>// //<>// //<>//

// event constants
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
final int EVENT_ALASKA = 16;
final int EVENT_BAR_CHART = 17;
final int EVENT_BAR_CHART_DATE = 19;
final int EVENT_BAR_CHART_ORIGIN = 20;
final int EVENT_BAR_CHART_DESTINATION = 21;
final int EVENT_BAR_CHART_DISTANCE = 22;
final int EVENT_NULL=0;

PFont stdFont;

// screen declarations
Screen currentScreen, previousScreen;
HomeScreen homeScreen;
DataScreen dataScreen;
HeatScreen heatScreen;
CalendarScreen dateScreen;
OrderingScreen orderingScreen;
AlaskaHeatScreen alaskaScreen;
RouteScreen routeScreen;
BarScreen barScreen;

// screen initialization and input selection
void setup() {
  stdFont = loadFont("GillSans-Bold-48.vlw");
  size(900, 600);
  homeScreen = new HomeScreen();
  routeScreen = new RouteScreen();
  dateScreen = new CalendarScreen();
  dataScreen = new DataScreen();
  heatScreen = new HeatScreen();
  orderingScreen = new OrderingScreen();
  alaskaScreen = new AlaskaHeatScreen();
  barScreen = new BarScreen();

  currentScreen = homeScreen;
  previousScreen = currentScreen;

  selectInput("Select a file to process:", "inputSelected");
}

// containers to store input data and filtered data
ArrayList<Flight> inputData = new ArrayList<Flight>();
ArrayList<Flight> filteredData = new ArrayList<Flight>();

// input file selection callback 
void inputSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    // reading input as separate lines
    String[] lines = loadStrings(selection);
    for (int i = 1; i < lines.length; i++) {
      Flight flight = new Flight(splitStr(lines[i], ','));
      inputData.add(flight);
      heatScreen.addFlight(flight);
      alaskaScreen.addFlight(flight);
    }
  }
  // airports info
  heatScreen.loadAirportData("iatalatlong.csv");
  dataScreen.setData(inputData);
  barScreen.init();
  // collect airports from data set
  Set<String> airports = new HashSet();;
  for (int i = 0; i < inputData.size(); ++i) {
    airports.add(inputData.get(i).origin);
    airports.add(inputData.get(i).dest);
  }
  routeScreen.setAirports(airports);
}

// csv file selection callback
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

//
// forward callbacks to currentScreen
//
void draw() {
  currentScreen.draw();
}

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
  case EVENT_ALASKA:
    println("Alaska heatmap selected!");
    changeScreen(alaskaScreen);
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
  case EVENT_BAR_CHART:
    println("Barchart Selected!");
    barScreen.init();
    changeScreen(barScreen);
    break;
   case EVENT_BAR_CHART_DATE:
    println("Date Selected!");
    barScreen.init();
    changeScreen(barScreen);
    barScreen.dateBars();
    break;
   case EVENT_BAR_CHART_DISTANCE:
    println("Distance Selected!");
    barScreen.init();
    changeScreen(barScreen);
    barScreen.distanceBars();
    break;
      case EVENT_BAR_CHART_ORIGIN:
    println("Origin Selected!");
    barScreen.init();
    changeScreen(barScreen);
    barScreen.originBars();
    break;
     case EVENT_BAR_CHART_DESTINATION:
    println("Destination Selected!");
    barScreen.init();
    changeScreen(barScreen);
    barScreen.destinationBars();
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
void keyTyped() {
  currentScreen.keyTyped();
}

int getDataSize() {
  return inputData.isEmpty() ? 0 : inputData.size() + 1;
}
