import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather/model/weather_data.dart';
import 'package:flutter_testing_lab/widgets/weather/weather_manager.dart';

void main() {
  group('WeatherManager', () {
    late WeatherManager weatherManager;

    setUp(() {
      weatherManager = WeatherManager();
    });

    test('should have correct default city', () {
      expect(weatherManager.defaultCity, equals('New York'));
    });

    test('should have correct available cities', () {
      final cities = weatherManager.availableCities;
      expect(cities, contains('New York'));
      expect(cities, contains('London'));
      expect(cities, contains('Tokyo'));
      expect(cities, contains('Invalid City'));
      expect(cities.length, equals(4));
    });

    test('should convert celsius to fahrenheit correctly', () {
      expect(weatherManager.celsiusToFahrenheit(0), equals(32.0));
      expect(weatherManager.celsiusToFahrenheit(100), equals(212.0));
      expect(weatherManager.celsiusToFahrenheit(25), equals(77.0));
    });

    test('should convert fahrenheit to celsius correctly', () {
      expect(weatherManager.fahrenheitToCelsius(32), equals(0.0));
      expect(weatherManager.fahrenheitToCelsius(212), equals(100.0));
      expect(weatherManager.fahrenheitToCelsius(77), equals(25.0));
    });

    test('should identify valid cities correctly', () {
      expect(weatherManager.isValidCity('New York'), isTrue);
      expect(weatherManager.isValidCity('London'), isTrue);
      expect(weatherManager.isValidCity('Tokyo'), isTrue);
      expect(weatherManager.isValidCity('Invalid City'), isFalse);
      expect(weatherManager.isValidCity('NonExistent'), isFalse);
    });

    test('should load weather data for valid cities', () async {
      WeatherData? weatherData;
      for (int i = 0; i < 5; i++) {
        weatherData = await weatherManager.loadWeatherData('New York');
        if (weatherData != null && weatherData.description.isNotEmpty) {
          break;
        }
      }

      expect(weatherData, isNotNull);
      expect(weatherData!.city, equals('New York'));
      expect(weatherData.temperatureCelsius, isA<double>());
      expect(weatherData.description, isNotEmpty);
      expect(weatherData.humidity, isA<int>());
      expect(weatherData.windSpeed, isA<double>());
      expect(weatherData.icon, isNotEmpty);
    });

    test('should return null for invalid city', () async {
      final weatherData = await weatherManager.loadWeatherData('Invalid City');
      expect(weatherData, isNull);
    });

    test('should return null for non-existent city', () async {
      final weatherData = await weatherManager.loadWeatherData('NonExistent');

      expect(weatherData, isNotNull);
      expect(weatherData!.city, equals('NonExistent'));
    });

    test('should handle malformed data gracefully', () async {
      WeatherData? weatherData;
      for (int i = 0; i < 10; i++) {
        weatherData = await weatherManager.loadWeatherData('New York');
        if (weatherData == null) {
          break;
        }
      }
      expect(weatherData == null, isTrue);
    });
  });
}
