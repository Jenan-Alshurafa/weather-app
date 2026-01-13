class WeatherModel {
  final String location;
  final int temperature;
  final String condition;
  final int highTemp;
  final int lowTemp;
  final String weatherIcon;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.highTemp,
    required this.lowTemp,
    required this.weatherIcon,
  });
}

class HourlyWeather {
  final String time;
  final int temperature;
  final String weatherIcon;
  final bool isNow;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherIcon,
    this.isNow = false,
  });
}

