void drawBarGraph(List<Flight> dataSet, PImage bg) {
  background(bg);
  
  // fixed distance to border
  int distX = 300;
  int distY = 400;
  int barWidth = 50;

  // Test data
  int[] values = {21, 12, 88, 30, 40};
  String[] bars = {"bar1", "bar2", "bar3", "bar4", "bar5"};

  // Find maximum value for scaling
  int maxValue = getMaxValue(values);
  
  // Draw bars and labels
  textAlign(CENTER, CENTER);
  textSize(14);
  fill(0);
  for (int i = 0; i < values.length; i++) {
    int x = distX + (i * (barWidth + 20)) + (barWidth / 2);
    int barHeight = (int) map(values[i], 0, maxValue, 0, 300);
    
    // Draw bars
    stroke(255);
    rect(x, distY - barHeight, barWidth, barHeight);
    
    // Add text label
    fill(0, 408, 612);
    text(bars[i], x+25, distY + 20);
  }
  
  // Draw axes labels
  textSize(16);
  textAlign(RIGHT);
  text("Number of Flights", distX - 10, distY - 150);
  textAlign(CENTER);
  text("Airports", distX + (values.length * (barWidth + 20)) / 2, distY + 50);
  
  // Draw total number of flights
  textSize(14);
  textAlign(LEFT);
  text("Total number of flights loaded is " + dataSet.size(), distX, 40);
}

// Function to find maximum value in an array
int getMaxValue(int[] arr) {
  int maxVal = Integer.MIN_VALUE;
  for (int val : arr) {
    if (val > maxVal) {
      maxVal = val;
    }
  }
  return maxVal;
}
