class Bar {
  String label;
  int value;
  Bar(String label, int value) {
    this.label = label;
    this.value = value;
  }
}

class BarScreen extends Screen {
  Bar[] currentBarChart;
  Bar[] originBarChart = new Bar[5];
  Bar[] destinationBarChart = new Bar[5];
  Bar[] dateBarChart = new Bar[5];
  Bar[] distanceBarChart = new Bar[5];
  
  void init() {
    FlightOrigin[] origins = prevailingOrigins(5);
    FlightOrigin[] destinations = prevailingDestinations(5);
    Date[] dateRanges = dateRanges(5);
    int[] flightsPerDateRanges = flightsPerDateRange(dateRanges);
    int[] distanceRanges = distanceRanges(5);
    int[] flightsPerDistanceRange = flightsPerDistanceRange(distanceRanges);
    for (int i = 0; i < 5; ++i) {
      originBarChart[i] = new Bar(origins[i].origin, origins[i].count);
      destinationBarChart[i] = new Bar(destinations[i].origin, destinations[i].count);
      dateBarChart[i] = new Bar(dateRanges[i].toString() + " - " + dateRanges[i + 1].toString(), flightsPerDateRanges[0]);
      distanceBarChart[i] = new Bar(distanceRanges[i] + "", flightsPerDistanceRange[0]);
    }
  }
  void originBars() {
    currentBarChart = originBarChart;
  }
  void destinationBars() {
    currentBarChart = destinationBarChart;
  }
  void dateBars() {
    currentBarChart = dateBarChart;
  }
  void distanceBars() {
    currentBarChart = distanceBarChart;
  }
  
  void draw() {
    super.draw();
  }
}
