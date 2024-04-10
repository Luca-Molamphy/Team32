class Bar {
  String label;
  int value;
  Bar(String label, int value) {
    this.label = label;
    this.value = value;
  }
}

class BarScreen extends Screen {
  int[] values;
  String[] labels;
  Bar[] currentBarChart;
  Bar[] originBarChart = new Bar[5];
  Bar[] destinationBarChart = new Bar[5];
  Bar[] dateBarChart = new Bar[5];
  Bar[] distanceBarChart = new Bar[5];
  float barHeight;
  float barWidth;
  float x;
  float y;
  PImage bargraphBg;
  
void init() {
  bargraphBg = loadImage("barchart-bg.jpg");
  FlightOrigin[] origins = prevailingOrigins(5);
  FlightOrigin[] destinations = prevailingDestinations(5);
  Date[] dateRanges = dateRanges(5);
  int[] flightsPerDateRanges = flightsPerDateRange(dateRanges);
  int[] distanceRanges = distanceRanges(5);
  int[] flightsPerDistanceRanges = flightsPerDistanceRange(distanceRanges);

  for (int i = 0; i < 5; ++i) {
    originBarChart[i] = new Bar(origins[i].origin, origins[i].count);
    destinationBarChart[i] = new Bar(destinations[i].origin, destinations[i].count);
    dateBarChart[i] = new Bar(dateRanges[i].toString() + " - " + dateRanges[i + 1].toString(), flightsPerDateRanges[i]);
    distanceBarChart[i] = new Bar(distanceRanges[i] + "", flightsPerDistanceRanges[i]);
  }

  }
void fillValuesAndLabelsArrays() {
  // Convert bar instances to arrays of labels and values
  if (currentBarChart == null) {
    return;
  }

  values = new int[currentBarChart.length];
  labels = new String[currentBarChart.length];
  for (int i = 0; i < currentBarChart.length; i++) {
    values[i] = currentBarChart[i].value;
    labels[i] = currentBarChart[i].label;
  }

}

  void originBars() {
    currentBarChart = originBarChart;
    fillValuesAndLabelsArrays(); 
  }

  void destinationBars() {
    currentBarChart = destinationBarChart;
    fillValuesAndLabelsArrays(); 
  }

  void dateBars() {
    currentBarChart = dateBarChart;
    fillValuesAndLabelsArrays(); 
  }

  void distanceBars() {
    currentBarChart = distanceBarChart;
    fillValuesAndLabelsArrays(); 
  }
void drawBars() {
  if (currentBarChart == null) {
    return; // Don't run if currentBarChart isn't chosen yet
  }

  float barWidth = width / currentBarChart.length; // Width of each bar

  // Find the maximum value among all bars
  int maxValue = 0;
  for (int i = 0; i < currentBarChart.length; i++) {
    if (currentBarChart[i].value > maxValue) {
      maxValue = currentBarChart[i].value;
    }
  }

  for (int i = 0; i < currentBarChart.length; i++) {
    float x = i * barWidth; // X position of the bar
    float barHeight = map(currentBarChart[i].value, 0, maxValue, 0, height - 150); // Height of the bar
    float y = height - barHeight; // Y position of the top of the bar

    // Draw the bar
    fill(255,0,0,127);
    rect(x, y, barWidth, barHeight);

    // Draw the label
    textSize(12); 
    fill(255);
    textAlign(CENTER);
    text(currentBarChart[i].label, x + barWidth / 2, height - 5);
    text(currentBarChart[i].value + " Flights", x + barWidth / 2, height - (barHeight + 40));
  }
}
  
  void draw() {
   
   background(bargraphBg);
   add(new Widget(180, 50, 120, 40, "Date Range", stdFont, EVENT_BAR_CHART_DATE));
   add(new Widget(300, 50, 150, 40, "Distance Range", stdFont, EVENT_BAR_CHART_DISTANCE));
   add(new Widget(450, 50, 150, 40, "Popular Origin", stdFont, EVENT_BAR_CHART_ORIGIN));
   add(new Widget(600, 50, 200, 40, "Popular Destination", stdFont, EVENT_BAR_CHART_DESTINATION));
   add(new Widget(800, 50, 80, 40, "Return", stdFont, EVENT_RETURN));
    drawBars();
    super.draw();
  }
}
