import 'model/weather_data.dart';

class WeatherManager {
  final List<String> _availableCities = [
    'New York',
    'London',
    'Tokyo',
    'Invalid City',
  ];

  List<String> get availableCities => List.unmodifiable(_availableCities);

  /// Convert Celsius to Fahrenheit
  double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  /// Convert Fahrenheit to Celsius 
  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  Future<Map<String, dynamic>?> _fetchWeatherData(String city) async {
    await Future.delayed(const Duration(seconds: 2));

    if (city == 'Invalid City') {
      return null;
    }

    if (DateTime.now().millisecond % 4 == 0) {
      return {'city': city, 'temperature': 22.5};
    }

    return {
      'city': city,
      'temperature': city == 'London' ? 15.0 : (city == 'Tokyo' ? 25.0 : 22.5),
      'description': city == 'London'
          ? 'Rainy'
          : (city == 'Tokyo' ? 'Cloudy' : 'Sunny'),
      'humidity': city == 'London' ? 85 : (city == 'Tokyo' ? 70 : 65),
      'windSpeed': city == 'London' ? 8.5 : (city == 'Tokyo' ? 5.2 : 12.3),
      'icon': city == 'London' ? '🌧️' : (city == 'Tokyo' ? '☁️' : '☀️'),
    };
  }

  Future<WeatherData?> loadWeatherData(String city) async {
    final data = await _fetchWeatherData(city);
    if (data == null) {
      return null;
    }

    try {
      return WeatherData.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  bool isValidCity(String city) {
    return _availableCities.contains(city) && city != 'Invalid City';
  }

  String get defaultCity => 'New York';
}
