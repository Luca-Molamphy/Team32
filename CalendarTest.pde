import java.util.*;

final int SCREENX = 900;
final int SCREENY = 480;

class Calendar {
  int year;
  int month;
  int startDayOfMonth;
  String[] months = { "", "January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December" };
  int[] days = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
  int[] monthKey = { -1, 1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6 };
  
  Calendar(int year_, int month_) {
    year = year_;
    month = month_;
    setCalendar();
  }
  void setCalendar() {
    if ((((year % 4 == 0) && (year % 100 != 0)) ||  (Y % 400 == 0))) {
      days[2] = 29;
      monthKey[1] = 0;
      monthKey[2] = 3;
    } else {
      days[2] = 28;
      monthKey[1] = 1;
      monthKey[2] = 4;
    }
    int res;
    int lastTwoDigits = (year % 10) + 10 * ((year / 10) % 10);
    res = (lastTwoDigits + lastTwoDigits / 4 + monthKey[month] - 1) % 7;
    startDayOfMonth = (res == 0? 7: res);      
  }
  void nextYear() {
    year = (year + 1 > 2099? 2000: year + 1);
    setCalendar();
  }
  void prevYear() {
    year = (year - 1 < 2000? 2099: year - 1);
    setCalendar();
  }
  void nextMonth() {
    month = (month + 1 > 12? 1: month + 1);
    setCalendar();
  }
  void prevMonth() {
    month = (month - 1 < 1? 12: month - 1);
    setCalendar();
  }
  void draw() {
  }
}

void setup() {
  PFont flightFont = loadFont("Arial-Black-14.vlw");
  textFont(flightFont);
}

void settings() {
  size(SCREENX, SCREENY);
}

void draw() {
  background(0);
}
