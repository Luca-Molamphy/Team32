class AlaskaHeatScreen extends Screen {
  PImage alaskaImage;
  HashMap<String, Integer> flightDensity = new HashMap<String, Integer>();
  HashMap<String, PVector> airportLocations = new HashMap<String, PVector>();
  HashMap<String, PVector> alaskaLocations = new HashMap<String, PVector>();

  Set<String> alaskaIATACodes = Set.of("ADQ", "ANC", "BET", "BRW", "CDV", "FAI", "JNU", "KTN", "PSG", "SCC", "SIT", "WRG", "YAK");
  int maxDensity = 0;

  AlaskaHeatScreen() {
    alaskaImage = loadImage("alaska.jpg");
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
    add(new Widget(765, 525, 65, 30, "Back", stdFont, EVENT_HEAT));
  }

  void addFlight(Flight flight) {
    flightDensity.put(flight.origin, flightDensity.getOrDefault(flight.origin, 0) + 1);
    flightDensity.put(flight.dest, flightDensity.getOrDefault(flight.dest, 0) + 1);
  }

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
      if (flightIATACodes.contains(iataCode) && !alaskaIATACodes.contains(iataCode)) {
        float latitude = float(label[5].trim().replace("\"", ""));
        float longitude = float(label[6].trim().replace("\"", ""));
        airportLocations.put(iataCode, new PVector(latitude, longitude));
      }
      if (alaskaIATACodes.contains(iataCode)) {
        float latitude = float(label[5].trim().replace("\"", ""));
        float longitude = float(label[6].trim().replace("\"", ""));
        alaskaLocations.put(iataCode, new PVector(latitude, longitude));
      }
    }
  }

  void draw() {
    background(255);
    image(alaskaImage, 50, 32, 800, 381);
    drawAlaskaHeatMap();
  }

  void drawAlaskaHeatMap() {
    try {
      for (Integer density : flightDensity.values()) {
        if (density > maxDensity) {
          maxDensity = density;
        }
        colorMode(HSB, 255);
        for (String key : flightDensity.keySet()) {
          PVector location = alaskaLocations.get(key);
          if (location != null) {
            PVector screen = geoToScreen(location.x, location.y);
            float sqrtDensity = sqrt(flightDensity.get(key));
            float hue = map(sqrtDensity, 0, sqrt(maxDensity), 120, 0);
            noStroke();
            fill(hue, 255, 255);
            ellipse(screen.x, screen.y, 10, 10);
          }
        }
        colorMode(RGB, 255);
      }
    }
    catch(Exception e) {
      System.out.print(e);
    }
  }


  PVector geoToScreen(float lat, float lon) {
    float x = map(lon, -161.838, -131.714, 0, alaskaImage.width-130);
    float y = map(lat, 71.2854, 55.3556, 0, alaskaImage.height);
    x += 130;
    y += 93;
    return new PVector(x, y);
  }
}
