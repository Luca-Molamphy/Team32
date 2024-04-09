class AlaskaHeatScreen extends Screen {
  PImage alaskaImage, indexImage;
  HashMap<String, Integer> flightDensity = new HashMap<String, Integer>();
  HashMap<String, PVector> airportLocations = new HashMap<String, PVector>();
  HashMap<String, PVector> alaskaLocations = new HashMap<String, PVector>();
  int max;
  Set<String> alaskaIATACodes = Set.of("ADQ", "ANC", "BET", "BRW", "CDV", "FAI", "JNU", "KTN", "PSG", "SCC", "SIT", "WRG", "YAK");

  AlaskaHeatScreen() {
    alaskaImage = loadImage("alaska.jpg");
    indexImage = loadImage("index.png");
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
    add(new Widget(765, 525, 65, 30, "Back", stdFont, EVENT_HEAT));
  }

  void addFlight(Flight flight) {
    flightDensity.put(flight.origin, flightDensity.getOrDefault(flight.origin, 0) + 1);
    flightDensity.put(flight.dest, flightDensity.getOrDefault(flight.dest, 0) + 1);
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
    textSize(18);
    fill(0);
    text(alaskaLocations.size(), 213, 560);
    image(indexImage, 10, 440, 300, 61.5);
    text(0, 10, 520.5);
    text(max, 310, 520.5);
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
    triangle(860, 580, 860, 590, 850, 590);
    stroke(0);
    strokeWeight(1);
    line(860, 590, 840, 570);
    super.draw();
  }

  void drawAlaskaHeatMap() {
    alaskaScreen.loadAirportData("iatalatlong.csv");
    try {
      for (Integer density : flightDensity.values()) {
        if (density > max) {
          max = density;
        }
        colorMode(HSB, 255);
        for (String key : flightDensity.keySet()) {
          PVector location = alaskaLocations.get(key);
          if (location != null) {
            PVector screen = geoToScreen(location.x, location.y);
            float sqrtDensity = sqrt(flightDensity.get(key));
            float hue = map(sqrtDensity, 0, sqrt(max), 120, 0);
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
