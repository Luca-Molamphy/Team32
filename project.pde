import java.util.*;

String[] splitStr(String src, char delim) {
  String[] res = new String[18]; //<>//
  Arrays.fill(res, "");
  int i = 0;
  int prevDel = -1;
  for (int j = 0; j < src.length(); ++j) {
    if (src.charAt(j) == delim && ((j - 1 < 0) || src.charAt(j - 1) != ' ') && (j + 1 >= src.length() || src.charAt(j + 1) != ' ')) {
      res[i++] = src.substring(prevDel + 1, j);
      prevDel = j;
    }
  }
  res[i] = src.substring(prevDel + 1, src.length());
  return res;
}

class Flight {
  String flightDate;
  String IATACodeMarketingAirline;
  String flightNumberMarketingAirline;
  String origin;
  String originCityName;
  String originState;
  String originWac;
  String dest;
  String destCityName;
  String destState;
  String destWac;
  String CRSDepTime;
  String depTime;
  String CRSArrTime;
  String arrTime;
  String cancelled;
  String diverted;
  String distance;

  Flight(String[] data) {
    flightDate = data[0];
    IATACodeMarketingAirline = data[1];
    flightNumberMarketingAirline = data[2];
    origin = data[3];
    originCityName = data[4];
    originState = data[5];
    originWac = data[6];
    dest = data[7];
    destCityName = data[8];
    destState = data[9];
    destWac = data[10];
    CRSDepTime = data[11];
    depTime = data[12];
    CRSArrTime = data[13];
    arrTime = data[14];
    cancelled = data[15];
    diverted = data[16];
    distance = data[17];
  }

  void print() {
    println(flightDate + "," + IATACodeMarketingAirline + "," + flightNumberMarketingAirline + "," +
            origin + "," + originCityName + "," + originState + "," + originWac + "," + dest + "," + destCityName + "," +
            destState + "," + destWac + "," + CRSDepTime + "," + depTime + "," + CRSArrTime + "," + arrTime + "," +
            cancelled + "," + diverted + "," + distance);
  }
}

List<Flight> Data = new ArrayList<Flight>();

void setup() {
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String[] lines = loadStrings(selection);
    for (int i = 1; i < lines.length; i++) {
      Data.add(new Flight(splitStr(lines[i], ',')));
    }
    for (int i = 0; i < Data.size(); i++) {
      Data.get(i).print();
    }
  }
}