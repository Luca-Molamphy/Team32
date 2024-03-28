import java.util.ArrayList;

Table data; // CSV data table

String[] questions = {
  "Most Busy Routes",
  "What's the longest route",
  "Total flights from the airport"
};

int selectedQuestionIndex = -1;
String airport, date, route;
String answer = "";

void setup() {
  size(400, 300);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  // Load CSV file
  data = loadTable("Flights2k.csv", "header");
  
  // Display the list of questions
  background(255);
  fill(0);
  text("Choose a question:", width/2, height/4);
  for (int i = 0; i < questions.length; i++) {
    text((i+1) + ". " + questions[i], width/2, height/4 + (i+1)*30);
  }
}

void draw() {
  if (selectedQuestionIndex != -1) {
    background(255);
    fill(0);
    text("You selected:", width/2, height/4);
    text(questions[selectedQuestionIndex], width/2, height/4 + 30);
    
    if (answer.length() > 0) {
      text("Answer:", width/2, height/2);
      text(answer, width/2, height/2 + 30);
    }
  }
}

void mousePressed() {
  // we are checking if user clicked on a question
  for (int i = 0; i < questions.length; i++) {
    if (mouseY > height/4 + (i+1)*30 - 15 && mouseY < height/4 + (i+1)*30 + 15) {
      selectedQuestionIndex = i;
      break;
    }
  }
  
  // If a question is selected, we will prompt the user for additional details
  if (selectedQuestionIndex != -1) {
    if (selectedQuestionIndex == 0 || selectedQuestionIndex == 1) {
      airport = input("Enter the airport:");
      date = input("Enter the date (YYYY-MM-DD):");
      route = input("Enter the route:");
    } else if (selectedQuestionIndex == 2) {
      airport = input("Enter the airport:");
    }
    
    // Then we'll generate answer based on user input
    generateAnswer();
  }
}

String input(String prompt) {
  return javax.swing.JOptionPane.showInputDialog(prompt);
}

void generateAnswer() {
  answer = ""; // Reset answer
  
  // Now we should find answer based on selected question
  switch (selectedQuestionIndex) {
    case 0:
      answer = "Most Busy Routes answer for airport: " + airport + ", date: " + date + ", route: " + route;
      break;
    case 1:
      answer = "Longest Route answer for airport: " + airport + ", date: " + date + ", route: " + route;
      break;
    case 2:
      answer = "Total flights from the airport answer for airport: " + airport;
      break;
    default:
      answer = "Unknown question";
  }
}
