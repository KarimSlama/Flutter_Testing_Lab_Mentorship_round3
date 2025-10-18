import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/weather_detail.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('WeatherDetail', () {
    testWidgets('should display weather detail information correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          WeatherDetail(
            label: 'Humidity',
            value: '65%',
            icon: Icons.water_drop,
          ),
        ),
      );

      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('should display wind speed detail correctly', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          WeatherDetail(
            label: 'Wind Speed',
            value: '12.3 km/h',
            icon: Icons.air,
          ),
        ),
      );

      expect(find.text('Wind Speed'), findsOneWidget);
      expect(find.text('12.3 km/h'), findsOneWidget);
      expect(find.byIcon(Icons.air), findsOneWidget);
    });

    testWidgets('should have correct icon styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          WeatherDetail(label: 'Test', value: 'Value', icon: Icons.water_drop),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.water_drop));
      expect(icon.color, equals(Colors.blue));
      expect(icon.size, equals(32));
    });

    testWidgets('should have correct text styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          WeatherDetail(
            label: 'Test Label',
            value: 'Test Value',
            icon: Icons.water_drop,
          ),
        ),
      );

      final labelText = tester.widget<Text>(find.text('Test Label'));
      final valueText = tester.widget<Text>(find.text('Test Value'));

      expect(labelText.style?.fontSize, equals(12));
      expect(labelText.style?.color, equals(Colors.grey));
      expect(valueText.style?.fontSize, equals(16));
      expect(valueText.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should display multiple weather details', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          Column(
            children: [
              WeatherDetail(
                label: 'Humidity',
                value: '65%',
                icon: Icons.water_drop,
              ),
              WeatherDetail(
                label: 'Wind Speed',
                value: '12.3 km/h',
                icon: Icons.air,
              ),
            ],
          ),
        ),
      );

      expect(find.text('Humidity'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);
      expect(find.text('Wind Speed'), findsOneWidget);
      expect(find.text('12.3 km/h'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
      expect(find.byIcon(Icons.air), findsOneWidget);
    });
  });
}
