// screen for route-based data filtering
class RouteScreen extends Screen {
  
  final int LAX_X = 70;
  final int LAX_Y = 355;
  final int JFK_X = 820;
  final int JFK_Y = 208;
  final int SFO_X = 39;
  final int SFO_Y = 268;
  final int DFW_X = 442;
  final int DFW_Y = 435;
  final int BOS_X = 850;
  final int BOS_Y = 165;
  final int SEA_X = 95;
  final int SEA_Y = 57;
  final int DEN_X = 335;
  final int DEN_Y = 275;
  final int DCA_X = 762;
  final int DCA_Y = 261;
  final int FLL_X = 770;
  final int FLL_Y = 540;
  final int LAS_X = 140;
  final int LAS_Y = 325;
  final int HNL_X = 32;
  final int HNL_Y = 405;
  final int ORD_X = 590;
  final int ORD_Y = 227;
  final int DAL_X = 475;
  final int DAL_Y = 461;
  final int HOU_X = 475;
  final int HOU_Y = 505;
  final int MCI_X = 500;
  final int MCI_Y = 300;
  final int ATW_X = 580;
  final int ATW_Y = 180;
  final int x = 0;
  final int y = 0;
  
  PImage AmericaImg;
  String departureAirport = "";
  String arrivalAirport = "";
  String inputText = "";
  Set<String> airports;
  
  RouteScreen() {
    AmericaImg = loadImage("UsMap.png");
    AmericaImg.resize(900, 600);
    add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
    add(new Widget(190, 510, 160, 80, "Show Data", stdFont, EVENT_SHOW_DATA));
    add(new Widget(500, 510, 160, 80, "Extract to CSV", stdFont, EVENT_EXTRACT_TO_CSV));
  }

  void setAirports(Set<String> airports) {
    this.airports = airports; 
  }

  void draw() {
    background(255);
    fill(200);
    noStroke();
    image(AmericaImg, 0, 0);
    fill(0);
    
    drawAirport(LAX_X, LAX_Y, "LAX");
    drawAirport(JFK_X, JFK_Y, "JFK");
    drawAirport(SFO_X, SFO_Y, "SFO");
    drawAirport(DFW_X, DFW_Y, "DFW");
    drawAirport(BOS_X, BOS_Y, "BOS");
    drawAirport(SEA_X, SEA_Y, "SEA");
    drawAirport(DEN_X, DEN_Y, "DEN");
    drawAirport(DCA_X, DCA_Y, "DCA");
    drawAirport(FLL_X, FLL_Y, "FLL");
    drawAirport(LAS_X, LAS_Y, "LAS");
    drawAirport(HNL_X, HNL_Y, "HNL");
    drawAirport(ORD_X, ORD_Y, "ORD");
    drawAirport(DAL_X, DAL_Y, "DAL");
    drawAirport(HOU_X, HOU_Y, "HOU");
    drawAirport(MCI_X, MCI_Y, "MCI");
    drawAirport(ATW_X, ATW_Y, "ATW");
  
    // Display prompt based on the selected airports
    displayPrompt();
    drawSearchBar();
    super.draw();
  }
 
  void filter() {
    filteredData.clear();
    String origin = departureAirport;
    String destination = arrivalAirport;
    println(inputData.get(0).origin + ' ' + inputData.get(0).dest);
    for (int i = 0; i < inputData.size(); ++i) {
      if ((inputData.get(i).origin.equals(origin)) && (inputData.get(i).dest.equals(destination))) {
        filteredData.add(inputData.get(i));
        println(inputData.get(i).toString());
      }
    }
    filteredData.sort(new CompareFlightDate());
    dataScreen.setData(filteredData);
  }

  void drawAirport(int x, int y, String label) {
    // Draw airport circle
    stroke(0);
    fill(255, 0, 0);
    ellipse(x, y, 15, 15);
  
    // Draw airport label
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x, y - 25);
  
    // Draw selection marker if the airport is selected
    if (label == departureAirport || label == arrivalAirport) {
      noFill();
      stroke(0);
      ellipse(x, y, 30, 30);
    }
  }
  
  void displayPrompt() {
    String prompt;
  
    if (departureAirport.equals("")) {
      prompt = "Please select a departure airport.";
    } else if (arrivalAirport.equals("")) {
      prompt = "Please select an arrival airport.";
    } else {
      prompt = "Departure: " + departureAirport + ", Arrival: " + arrivalAirport;
    }
  
    textAlign(CENTER, CENTER);
    fill(0);
    text(prompt, width / 2, 20);
  }
  
  int mousePressed(int mouseX, int mouseY) {
    if (departureAirport.equals("")) {
      if (isAirportClicked(LAX_X, LAX_Y)) {
        departureAirport = "LAX";
      } else if (isAirportClicked(JFK_X, JFK_Y)) {
        departureAirport = "JFK";
      } else if (isAirportClicked(SFO_X, SFO_Y)) {
        departureAirport = "SFO";
      } else if (isAirportClicked(DFW_X, DFW_Y)) {
        departureAirport = "DFW";
      } else if (isAirportClicked(BOS_X, BOS_Y)) {
        departureAirport = "BOS";
      } else if (isAirportClicked(SEA_X, SEA_Y)) {
        departureAirport = "SEA";
      } else if (isAirportClicked(DEN_X, DEN_Y)) {
        departureAirport = "DEN";
      } else if (isAirportClicked(DCA_X, DCA_Y)) {
        departureAirport = "DCA";
      } else if (isAirportClicked(FLL_X, FLL_Y)) {
        departureAirport = "FLL";
      } else if (isAirportClicked(LAS_X, LAS_Y)) {
        departureAirport = "LAS";
      } else if (isAirportClicked(HNL_X, HNL_Y)) {
        departureAirport = "HNL";
      } else if (isAirportClicked(ORD_X, ORD_Y)) {
        departureAirport = "ORD";
      } else if (isAirportClicked(DAL_X, DAL_Y)) {
        departureAirport = "DAL";
      } else if (isAirportClicked(HOU_X, HOU_Y)) {
        departureAirport = "HOU";
      } else if (isAirportClicked(MCI_X, MCI_Y)) {
        departureAirport = "MCI";
      } else if (isAirportClicked(ATW_X, ATW_Y)) {
        departureAirport = "ATW";
      } 
    }  else if (arrivalAirport.equals("")) {
        if (isAirportClicked(LAX_X, LAX_Y) && !departureAirport.equals("LAX")) {
          arrivalAirport = "LAX";
        } else if (isAirportClicked(JFK_X, JFK_Y) && !departureAirport.equals("JFK")) {
          arrivalAirport = "JFK";
        } else if (isAirportClicked(SFO_X, SFO_Y) && !departureAirport.equals("SFO")) {
          arrivalAirport = "SFO";
        } else if (isAirportClicked(DFW_X, DFW_Y) && !departureAirport.equals("DFW")) {
          arrivalAirport = "DFW";
        } else if (isAirportClicked(BOS_X, BOS_Y) && !departureAirport.equals("BOS")) {
          arrivalAirport = "BOS";
        } else if (isAirportClicked(SEA_X, SEA_Y) && !departureAirport.equals("SEA")) {
          arrivalAirport = "SEA";
        } else if (isAirportClicked(DEN_X, DEN_Y) && !departureAirport.equals("DEN")) {
          arrivalAirport = "DEN";
        } else if (isAirportClicked(DCA_X, DCA_Y) && !departureAirport.equals("DCA")) {
          arrivalAirport = "DCA";
        } else if (isAirportClicked(FLL_X, FLL_Y) && !departureAirport.equals("FLL")) {
          arrivalAirport = "FLL";
        } else if (isAirportClicked(LAS_X, LAS_Y) && !departureAirport.equals("LAS")) {
          arrivalAirport = "LAS";
        } else if (isAirportClicked(HNL_X, HNL_Y) && !departureAirport.equals("HNL")) {
          arrivalAirport = "HNL";
        } else if (isAirportClicked(ORD_X, ORD_Y) && !departureAirport.equals("ORD")) {
          arrivalAirport = "ORD";
        } else if (isAirportClicked(DAL_X, DAL_Y) && !departureAirport.equals("DAL")) {
          arrivalAirport = "DAL";
        } else if (isAirportClicked(HOU_X, HOU_Y) && !departureAirport.equals("HOU")) {
          arrivalAirport = "HOU";
        } else if (isAirportClicked(MCI_X, MCI_Y) && !departureAirport.equals("MCI")) {
          arrivalAirport = "MCI";
        } else if (isAirportClicked(ATW_X, ATW_Y) && !departureAirport.equals("ATW")) {
          arrivalAirport = "ATW";
        }
      }
      return super.mousePressed(mouseX, mouseY);
    }
  
  void drawSearchBar() {
    fill(255); // White background
    rect(550, 58, 200, 30); // Adjust size and position as needed
    fill(0); // Black text
    textAlign(LEFT, CENTER);
    text(inputText, 560, 75);
  }
  
  void checkInput() {
    if (departureAirport.equals("") && airports.contains(inputText)) {
      departureAirport = inputText;
    } else if (arrivalAirport.equals("") && airports.contains(inputText) && !departureAirport.equals(inputText)) {
      arrivalAirport = inputText;
    }
  }
  
  void keyTyped() {
    if (key == BACKSPACE) {
      if (inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      }
    } else if (key == ENTER) {
      checkInput();
    }
    else if (inputText.length() < 3){
      inputText += key;
    }
  }
  
    boolean isAirportClicked(int x, int y) {
      // Check if the mouse click is inside the airport circle
      float distance = dist(x, y, mouseX, mouseY);
      return distance <= 10;
    }
}
