import java.util.*;

final int CELL_SIZE = 49;

class Date {
  int year;
  int month;
  int day;
  Date(int day, int month, int year) {
    this.year = year;
    this.month = month;
    this.day = day;
  }
  int compare(Date other) {
    if (year < other.year) {
      return -1;
    } else if (year > other.year) {
      return +1;
    }
    if (month < other.month) {
      return -1;
    } else if (month > other.month) {
      return +1;
    }
    if (day < other.day) {
      return -1;
    } else if (day > other.day) {
      return +1;
    }
    return 0;
  }
  String toString() {
    return day + "/" + month + "/" + year;
  }
}

Date parseDate(String str) {
  int day = Integer.parseInt(str.substring(0, 2));
  int month = Integer.parseInt(str.substring(3, 5));
  int year = Integer.parseInt(str.substring(6, 10));
  return new Date(day, month, year);
}

class CalendarCell {
  int rowNumber;
  int columnNumber;
  int value;
  boolean highlighted = false;

  CalendarCell(int rowNumber_, int columnNumber_, int value_) {
    rowNumber = rowNumber_;
    columnNumber = columnNumber_;
    value = value_;
  }

  void highlight(boolean hightlight) {
    highlighted = hightlight;
  }

  boolean getEvent(int mX, int mY) {
    if ((mX > CELL_SIZE * columnNumber) && mX < (CELL_SIZE * (columnNumber + 1)) &&
             mY > CELL_SIZE * (5 + rowNumber) && mY < CELL_SIZE * (6 + rowNumber)) {
      highlight(true);
      return true;
    }
    highlight(false);
    return false;
  }

  void draw() {
    if (highlighted) {
      fill(255);
      stroke(0);
      rect(CELL_SIZE * columnNumber, CELL_SIZE * (5 + rowNumber), CELL_SIZE, CELL_SIZE);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(value, CELL_SIZE * columnNumber + CELL_SIZE / 2 + 1, CELL_SIZE * (5 + rowNumber) + CELL_SIZE / 2 + 1);
  }
}

class Calendar {
  int year;
  int month;
  int startDayOfMonth;
  Date selectedDate;
  int cellToHighlightX = -CELL_SIZE;
  int cellToHighlightY = -CELL_SIZE;
  String[] months = { "", "January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December" };
  String[] daysOfTheWeek = { "", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su" };
  int[] days = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
  int[] monthKey = { -1, 1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6 };
  List<CalendarCell> cellList = new ArrayList<CalendarCell>();

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
    cellList.clear();
    int row = 1, column = startDayOfMonth;
    for (int i = 1; i < days[month] + 1; ++i) {
      if (column > 7) {
        ++row;
        column = 1;
      }
      cellList.add(new CalendarCell(row, column++, i));
    }
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

  Date getDate() {
    return selectedDate;
  }

  void highlight(int mX, int mY) {
    if ((mX > CELL_SIZE) && mX < (CELL_SIZE * 2) && (mY > CELL_SIZE) && mY < (CELL_SIZE * 2)) {
      cellToHighlightX = CELL_SIZE;
      cellToHighlightY = CELL_SIZE;
    } else if ((mX > CELL_SIZE * 7) && mX < (CELL_SIZE * 8) && (mY > CELL_SIZE) && mY < (CELL_SIZE * 2)) {
       cellToHighlightX = CELL_SIZE * 7;
       cellToHighlightY = CELL_SIZE;
    } else if ((mX > CELL_SIZE) && mX < (CELL_SIZE * 2) && (mY > CELL_SIZE * 3) && mY < (CELL_SIZE * 4)) {
      cellToHighlightX = CELL_SIZE;
      cellToHighlightY = CELL_SIZE * 3;
    } else if ((mX > CELL_SIZE * 7) && mX < (CELL_SIZE * 8) && (mY > CELL_SIZE * 3) && mY < (CELL_SIZE * 4)) {
      cellToHighlightX = CELL_SIZE * 7;
      cellToHighlightY = CELL_SIZE * 3;
    } else {
      cellToHighlightX = -CELL_SIZE;
      cellToHighlightY = -CELL_SIZE;
    }
    for (int i = 0; i < cellList.size(); ++i) {
      cellList.get(i).getEvent(mX, mY);
    }
  }

  int getEvent(int mX, int mY) {
    if ((mX > CELL_SIZE) && mX < (CELL_SIZE * 2) && (mY > CELL_SIZE) && mY < (CELL_SIZE * 2)) {
      prevYear();
    }
    if ((mX > CELL_SIZE * 7) && mX < (CELL_SIZE * 8) && (mY > CELL_SIZE) && mY < (CELL_SIZE * 2)) {
      nextYear();
    }
    if ((mX > CELL_SIZE) && mX < (CELL_SIZE * 2) && (mY > CELL_SIZE * 3) && mY < (CELL_SIZE * 4)) {
      prevMonth();
    }
    if ((mX > CELL_SIZE * 7) && mX < (CELL_SIZE * 8) && (mY > CELL_SIZE * 3) && mY < (CELL_SIZE * 4)) {
      nextMonth();
    }
    for (int i = 0; i < cellList.size(); ++i) {
      if (cellList.get(i).getEvent(mX, mY)) {
        selectedDate = new Date(cellList.get(i).value, month, year);
        println(cellList.get(i).value);
        return EVENT_DATE_SELECTED;
      }
    }
    return EVENT_NULL;
  }
  
  void draw() {
    background(255);
    fill(255);
    stroke(0);
    rect(cellToHighlightX, cellToHighlightY, CELL_SIZE, CELL_SIZE);
    textAlign(CENTER, CENTER);
    fill(0);
    text("<", CELL_SIZE + CELL_SIZE / 2 + 1, CELL_SIZE  + CELL_SIZE / 2 + 1);
    text(">", CELL_SIZE * 7 + CELL_SIZE / 2 + 1, CELL_SIZE + CELL_SIZE / 2 + 1);
    text("<", CELL_SIZE + CELL_SIZE / 2 + 1, CELL_SIZE * 3 + CELL_SIZE / 2 + 1);
    text(">", CELL_SIZE * 7 + CELL_SIZE / 2 + 1, CELL_SIZE * 3 + CELL_SIZE / 2 + 1);
    text(year, CELL_SIZE * 4 + CELL_SIZE / 2 + 1, CELL_SIZE + CELL_SIZE / 2 + 1);
    text(months[month], CELL_SIZE * 4 + CELL_SIZE / 2 + 1, CELL_SIZE * 3 + CELL_SIZE / 2 + 1);
    for (int i = 1; i < 8; ++i) {
      text(daysOfTheWeek[i], CELL_SIZE * (i) + CELL_SIZE / 2 + 1, CELL_SIZE * 5 + CELL_SIZE / 2 + 1);
    }
    for (int i = 0; i < cellList.size(); ++i) {
      cellList.get(i).draw();
    }
  }
}
