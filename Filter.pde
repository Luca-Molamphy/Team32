class Filter
{
  public List filterByOriginAirport(List<Flight> data, String airport)
  {
    List<Flight> s = data.stream().filter(abc -> abc.origin.equals(airport)).collect(Collectors.toList());
    return s;
  }
  public List filterByDestAirport(List<Flight> data, String airport)
  {
    List<Flight> s = data.stream().filter(abc -> abc.dest.equals(airport)).collect(Collectors.toList());
    return s;
  }
  public List filterByDestAirportDate(List<Flight> data, String airport, String date)
  {
    List<Flight> s = data.stream().filter(abc -> abc.dest.equals(airport)).collect(Collectors.toList());
    List b = s.stream().filter(abc -> abc.flightDate.equals(date)).collect(Collectors.toList());
    return b;
  }
  public List filterByOriginAirportDate(List<Flight> data, String airport, String date)
  {
    List<Flight> s = data.stream().filter(abc -> abc.origin.equals(airport)).collect(Collectors.toList());
    List b = s.stream().filter(abc -> abc.flightDate.equals(date)).collect(Collectors.toList());
    return b;
  }
  public List filterByDate(List<Flight> data, String date)
  {
    List s = data.stream().filter(abc -> abc.flightDate.equals(date)).collect(Collectors.toList());
    return s;
  }
    public List filterByFlight(List<Flight> data, String flightNumber)
  {
    List s = data.stream().filter(abc -> abc.flightNumberMarketingAirline.equals(flightNumber)).collect(Collectors.toList());
    return s;
  }
}
