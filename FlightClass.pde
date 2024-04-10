// splits input csv data string, handles quoted strings
String[] splitStr(String src, char delim) {
  String[] res = new String[18];
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

// reprsents flight data
class Flight {
  Date flightDate;
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
  int distance;

  Flight(String[] data) {
    flightDate = parseDate(data[0]);
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
    distance = (int)Double.parseDouble(data[17].equals("") ? "0": data[17]);
  }
  String toString() {
    return flightDate.toString() + "," + IATACodeMarketingAirline + "," + flightNumberMarketingAirline + "," +
      origin + "," + originCityName + "," + originState + "," + originWac + "," + dest + "," + destCityName + "," +
      destState + "," + destWac + "," + CRSDepTime + "," + depTime + "," + CRSArrTime + "," + arrTime + "," +
      cancelled + "," + diverted + "," + distance;
  }
  void print() {
    println(toString());
  }
}
