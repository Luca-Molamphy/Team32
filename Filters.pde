// basic type to build bar charts by origin or destination
class FlightOrigin {
  String origin;
  int count;
  FlightOrigin(String origin, int count) {
    this.origin = origin;
    this.count = count;
  }
};

// split full date range into rangeCount subranges 
Date[] dateRanges(int rangeCount) {
  Date min = inputData.get(0).flightDate;
  Date max = min;
  for (int i = 1; i < inputData.size(); ++i) {
    if (inputData.get(i).flightDate.compare(min) < 0) {
      min = inputData.get(i).flightDate;
    }
    if (inputData.get(i).flightDate.compare(max) > 0) {
      max = inputData.get(i).flightDate;
    }
  }
  Date diff = max.subtract(min);
  int months = diff.year * 12 + diff.month;
  int days = diff.day + (diff.month % rangeCount) * 30;
  months /= rangeCount;
  days /= rangeCount;
  Date[] ranges = new Date[rangeCount + 1];
  ranges[0] = min;
  println("min: " + min.toString() + " max: " + max.toString() + " days: " + days + " months: " + months + " diff: " + diff.toString());
  for (int i = 1; i < rangeCount; ++i) {
    ranges[i] = new Date(ranges[i - 1].day, ranges[i - 1].month, ranges[i - 1].year);
    ranges[i].day += days;
    if (ranges[i].day > daysInMonth(ranges[i].month, ranges[i].year)) {
      ranges[i].increaseMonth();
    }
    if (ranges[i].day > daysInMonth(ranges[i].month, ranges[i].year)) {
      ranges[i].increaseMonth();
    }
    int month = ranges[i].month - 1 + months;
    ranges[i].year += month / 12;
    ranges[i].month = month % 12 + 1;
    println(i + ": " + ranges[i].toString());
  }
  ranges[rangeCount] = max; 
  return ranges;
}

// count flights for each date range given
int[] flightsPerDateRange(Date[] range) {
  int[] res = new int[range.length - 1];
  Arrays.fill(res, 0);
  outer: for (int i = 0; i < inputData.size(); ++i) {
    for (int j = 1; j < res.length; ++j) {
      if (inputData.get(i).flightDate.compare(range[j]) < 0) {
        ++res[j - 1];
        continue outer;
      }
    }
    ++res[res.length - 1];
  }
  return res;
}

// split full distance range into rangeCount subranges
int[] distanceRanges(int rangeCount) {
  int[] ranges = new int[rangeCount + 1];
  int min = inputData.get(0).distance;
  int max = min;
  for (int i = 1; i < inputData.size(); ++i) {
    if (inputData.get(i).distance < min) {
      min = inputData.get(i).distance;
    }
    if (inputData.get(i).distance > max) {
      max = inputData.get(i).distance;
    }
  }
  int step = (max - min) / rangeCount;
  for (int i = 0; i < rangeCount; ++i) {
    ranges[i] = min + step * i;
  }
  ranges[rangeCount] = max;
  return ranges;
}

// count flights for each distance range given
int[] flightsPerDistanceRange(int[] range) {
  int[] res = new int[range.length - 1];
  Arrays.fill(res, 0);
  outer: for (int i = 0; i < inputData.size(); ++i) {
    for (int j = 1; j < res.length; ++j) {
      if (inputData.get(i).distance < range[j]) {
        ++res[j - 1];
        continue outer;
      }
    }
    ++res[res.length - 1];
  }
  return res;
}


class CompareOriginByCount implements Comparator<FlightOrigin> {
  public int compare(FlightOrigin l, FlightOrigin r) {
    if (l.count < r.count)
      return +1;
    if (l.count > r.count)
      return -1;
    return -l.origin.compareTo(r.origin);
  }
}

// returns count most popular origins and number of flights in each
FlightOrigin[] prevailingOrigins(int count) {
  Map<String, FlightOrigin> origins = new HashMap<String, FlightOrigin>();
  for (int i = 0; i < inputData.size(); ++i) {
    String origin = inputData.get(i).origin;
    FlightOrigin fo = origins.get(origin);
    if (fo == null) {
      fo = new FlightOrigin(origin, 1);
      origins.put(origin, fo);
    } else {
      fo.count++;
    }
  }
  ArrayList<FlightOrigin> sorted = new ArrayList<FlightOrigin>(origins.values());
  sorted.sort(new CompareOriginByCount());
  if (sorted.size() < count) {
    count = sorted.size();
  }
  FlightOrigin[] res = new FlightOrigin[count];
  for (int i = 0 ; i < count; ++i) {
    res[i] = sorted.get(i);
  }
  return res;
}

// returns count most popular destinations and number of flights in each
FlightOrigin[] prevailingDestinations(int count) {
  Map<String, FlightOrigin> origins = new HashMap<String, FlightOrigin>();
  for (int i = 0; i < inputData.size(); ++i) {
    String origin = inputData.get(i).dest;
    FlightOrigin fo = origins.get(origin);
    if (fo == null) {
      fo = new FlightOrigin(origin, 1);
      origins.put(origin, fo);
    } else {
      fo.count++;
    }
  }
  ArrayList<FlightOrigin> sorted = new ArrayList<FlightOrigin>(origins.values());
  sorted.sort(new CompareOriginByCount());
  if (sorted.size() < count) {
    count = sorted.size();
  }
  FlightOrigin[] res = new FlightOrigin[count];
  for (int i = 0 ; i < count; ++i) {
    res[i] = sorted.get(i);
  }
  return res;
}
