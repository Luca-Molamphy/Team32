PImage usaMap;
HashMap<String, Integer> flightDensity = new HashMap<String, Integer>();
HashMap<String, PVector> airportLocations = new HashMap<String, PVector>();
Set<String> excludedIATACodes = Set.of("ADQ", "ANC", "BET", "BRW", "CDV", "FAI", "JNU", "KTN", "PSG", "SCC", "SIT", "WRG", "YAK");

void drawHeatmap() {
  int maxDensity = 0;
  try {
    for (Integer density : flightDensity.values()) {
      if (density > maxDensity) {
        maxDensity = density;
        max = maxDensity;
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
        ellipse(screen.x, screen.y, 5 + ((density/maxDensity)*1000), 5 + ((density/maxDensity)*1000));
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
  for (Flight flight : Data) {
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
