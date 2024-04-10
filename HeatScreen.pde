class HeatScreen extends Screen {
  PImage usaMap, indexImage;
  HashMap<String, Integer> flightDensity = new HashMap<String, Integer>();
  HashMap<String, PVector> airportLocations = new HashMap<String, PVector>();
  Set<String> excludedIATACodes = Set.of("ADQ", "ANC", "BET", "BRW", "CDV", "FAI", "JNU", "KTN", "PSG", "SCC", "SIT", "WRG", "YAK");
  int maxDensity = 0;

// Constructor which initialises the heat map with the images used and adds widgets for navigation between screens
  HeatScreen() {
    usaMap = loadImage("americaMap.jpg");
    indexImage = loadImage("index.png");
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
    add(new Widget(50, 30, 70, 30, "Alaska", stdFont, EVENT_ALASKA));
  }

// Adds the origin and destination of a flight to the flight density HashMap of the airport
  void addFlight(Flight flight) {
      flightDensity.put(flight.origin, flightDensity.getOrDefault(flight.origin, 0) + 1);
      flightDensity.put(flight.dest, flightDensity.getOrDefault(flight.dest, 0) + 1);
  }

// Draws heatmap on the screen using the data from the flight density and airport location HashMaps
  void drawHeatmap() {
    try {
      for (Integer density : flightDensity.values()) {
        if (density > maxDensity) {
          maxDensity = density;
        }
      }
      colorMode(HSB, 255);
      for (String key : flightDensity.keySet()) {
        PVector location = airportLocations.get(key);
        if (location != null) {
          PVector screen = geoToScreen(location.x, location.y);
          float density = sqrt(flightDensity.get(key));
          float hue = map(density, 0, sqrt(maxDensity), 120, 0);
          noStroke();
          fill(hue, 255, 255);
          ellipse(screen.x, screen.y, 10, 10);
        }
      }
      colorMode(RGB, 255);
    }
    catch(Exception e) {
      System.out.print(e);
    }
  }

// Draw function which sets the background, draws the map and calls the function to draw the heatmap
  void draw() {
    background(255);
    image(usaMap, 20, 65, 770, 435.9);
    drawHeatmap();
    textSize(18);
    fill(0);
    text(airportLocations.size(), 213, 560);
    image(indexImage, 10, 440, 300, 61.5);
    text(0, 10, 520.5);
    text(maxDensity, 310, 520.5);
    textSize(14);
    text("<-Number of flights at airport->", 160, 518.5);
    textSize(30);
    fill(178, 34, 52);
    text("HEAT MAP", 450, 40);
    fill(128, 0, 128);
    textSize(18);
    text("Index:", 40, 430);
    text("Airports Displayed: ", 103, 560);
    fill(0);
    triangle(20, 10, 20, 20, 30, 10);
    stroke(0);
    strokeWeight(1);
    line(20, 10, 40, 30);
    super.draw();
  }

// Loads airport data and puts data of flights excluding Alaskan airports into a HashMap
  void loadAirportData(String file) {
    Set<String> flightIATACodes = new HashSet<String>();
    for (Flight flight : inputData) {
      flightIATACodes.add(flight.origin);
      flightIATACodes.add(flight.dest);
    }
    String[] lines = loadStrings(file);
    for (int i = 1; i < lines.length; i++) {
      String[] label = split(lines[i], ',');
      String iataCode = label[2].trim().replace("\"", "");
      if (iataCode != null && !iataCode.isEmpty() && flightIATACodes.contains(iataCode) && !excludedIATACodes.contains(iataCode)) {
        float latitude = float(label[5].trim().replace("\"", ""));
        float longitude = float(label[6].trim().replace("\"", ""));
        airportLocations.put(iataCode, new PVector(latitude, longitude));
      }
    }
  }

// Converts latitude and longitude co-ordinates to screen co-ordinates the fit the USA map for data visualisation
  PVector geoToScreen(float lat, float lon) {
    float x = map(lon, -125, -66, 0, usaMap.width);
    float y = map(lat, 49, 24, 0, usaMap.height-18);
    x += 19;
    y += 79;
    if (y>580) {
      return new PVector(-100, -100);
    } else
      return new PVector(x, y);
  }
}
