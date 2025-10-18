import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/temperature_toggle.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('TemperatureToggle', () {
    late bool useFahrenheit;
    late bool toggleCalled;
    late bool newValue;

    setUp(() {
      useFahrenheit = false;
      toggleCalled = false;
      newValue = false;
    });

    Widget createWidget() {
      return createTestWidget(
        TemperatureToggle(
          useFahrenheit: useFahrenheit,
          onToggle: (value) {
            toggleCalled = true;
            newValue = value;
          },
        ),
      );
    }

    testWidgets('should display temperature unit toggle', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Temperature Unit:'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Celsius'), findsOneWidget);
    });

    testWidgets('should show Fahrenheit when useFahrenheit is true', (
      tester,
    ) async {
      useFahrenheit = true;
      await tester.pumpWidget(createWidget());

      expect(find.text('Fahrenheit'), findsOneWidget);
      expect(find.text('Celsius'), findsNothing);
    });

    testWidgets('should show Celsius when useFahrenheit is false', (
      tester,
    ) async {
      useFahrenheit = false;
      await tester.pumpWidget(createWidget());

      expect(find.text('Celsius'), findsOneWidget);
      expect(find.text('Fahrenheit'), findsNothing);
    });

    testWidgets('should call onToggle when switch is tapped', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(toggleCalled, isTrue);
      expect(newValue, isTrue);
    });

    testWidgets('should toggle from Celsius to Fahrenheit', (tester) async {
      useFahrenheit = false;
      await tester.pumpWidget(createWidget());

      expect(find.text('Celsius'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(toggleCalled, isTrue);
      expect(newValue, isTrue);
    });

    testWidgets('should toggle from Fahrenheit to Celsius', (tester) async {
      useFahrenheit = true;
      await tester.pumpWidget(createWidget());

      expect(find.text('Fahrenheit'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(toggleCalled, isTrue);
      expect(newValue, isFalse);
    });

    testWidgets('should reflect current state in switch', (tester) async {
      useFahrenheit = true;
      await tester.pumpWidget(createWidget());

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
    });
  });
}
