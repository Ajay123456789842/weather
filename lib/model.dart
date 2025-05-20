class WeatherModel {
  List<double> temp;
  List<String> weathertype;
  int pressure;
  int humidity;
  double windspeed;
  List time;

  WeatherModel({
    required this.temp,
    required this.weathertype,
    required this.pressure,
    required this.humidity,
    required this.windspeed,
    required this.time,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    temp: json["temp"],
    weathertype: json["weathertype"],
    pressure: json["pressure"],
    humidity: json["humidity"],
    windspeed: json["windspeed"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "weathertype": weathertype,
    "pressure": pressure,
    "humidity": humidity,
    "windspeed": windspeed,
    "time": time,
  };
}
