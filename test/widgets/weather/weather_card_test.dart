import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather/model/weather_data.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/weather_card.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('WeatherCard', () {
    late WeatherData testWeatherData;
    late double Function(double) temperatureConverter;

    setUp(() {
      testWeatherData = WeatherData(
        city: 'New York',
        temperatureCelsius: 25.0,
        description: 'Sunny',
        humidity: 65,
        windSpeed: 12.3,
        icon: '☀️',
      );

      temperatureConverter = (celsius) => celsius * 9 / 5 + 32;
    });

    Widget createWidget({bool useFahrenheit = false}) {
      return createTestWidget(
        WeatherCard(
          weatherData: testWeatherData,
          useFahrenheit: useFahrenheit,
          temperatureConverter: temperatureConverter,
        ),
      );
    }

    testWidgets('should display weather information correctly in Celsius', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget(useFahrenheit: false));

      expect(find.text('New York'), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.text('25.0°C'), findsOneWidget);
      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);
      expect(find.text('Wind Speed'), findsOneWidget);
      expect(find.text('12.3 km/h'), findsOneWidget);
      expect(find.text('☀️'), findsOneWidget);
    });

    testWidgets('should display weather information correctly in Fahrenheit', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget(useFahrenheit: true));

      expect(find.text('New York'), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.text('77.0°F'), findsOneWidget); // 25 * 9/5 + 32 = 77
      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);
      expect(find.text('Wind Speed'), findsOneWidget);
      expect(find.text('12.3 km/h'), findsOneWidget);
      expect(find.text('☀️'), findsOneWidget);
    });

    testWidgets('should display weather icon with correct size', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final iconText = tester.widget<Text>(find.text('☀️'));
      expect(iconText.style?.fontSize, equals(48));
    });

    testWidgets('should display city name with correct styling', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final cityText = tester.widget<Text>(find.text('New York'));
      expect(cityText.style?.fontSize, equals(24));
      expect(cityText.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should display description with correct styling', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final descriptionText = tester.widget<Text>(find.text('Sunny'));
      expect(descriptionText.style?.fontSize, equals(18));
      expect(descriptionText.style?.color, equals(Colors.grey));
    });

    testWidgets('should display temperature with correct styling', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final temperatureText = tester.widget<Text>(find.text('25.0°C'));
      expect(temperatureText.style?.fontSize, equals(48));
      expect(temperatureText.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should display weather details correctly', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
      expect(find.byIcon(Icons.air), findsOneWidget);
    });

    testWidgets('should handle different weather data', (tester) async {
      testWeatherData = WeatherData(
        city: 'London',
        temperatureCelsius: 15.0,
        description: 'Rainy',
        humidity: 85,
        windSpeed: 8.5,
        icon: '🌧️',
      );

      await tester.pumpWidget(createWidget());

      expect(find.text('London'), findsOneWidget);
      expect(find.text('Rainy'), findsOneWidget);
      expect(find.text('15.0°C'), findsOneWidget);
      expect(find.text('85%'), findsOneWidget);
      expect(find.text('8.5 km/h'), findsOneWidget);
      expect(find.text('🌧️'), findsOneWidget);
    });

    testWidgets('should be wrapped in a Card widget', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(Card), findsOneWidget);
    });
  });
}
