class Filter
{
  public List filterByAirport(List<Flight> data, String airport)
  {
    List<Flight> s = data.stream().filter(abc -> abc.origin.equals(airport)).collect(Collectors.toList());
    return s;
    //List b = s.stream().filter(abc -> abc.flightDate.equals("01/01/2022 00:00")).collect(Collectors.toList());
    //return b;
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
