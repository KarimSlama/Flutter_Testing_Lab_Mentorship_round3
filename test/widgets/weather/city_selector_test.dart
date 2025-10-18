import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/city_selector.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('CitySelector', () {
    late String selectedCity;
    late List<String> availableCities;
    late bool cityChangedCalled;
    late bool refreshCalled;
    late String changedCity;

    setUp(() {
      selectedCity = 'New York';
      availableCities = ['New York', 'London', 'Tokyo', 'Invalid City'];
      cityChangedCalled = false;
      refreshCalled = false;
      changedCity = '';
    });

    Widget createWidget() {
      return createTestWidget(
        CitySelector(
          selectedCity: selectedCity,
          availableCities: availableCities,
          onCityChanged: (city) {
            cityChangedCalled = true;
            changedCity = city;
          },
          onRefresh: () {
            refreshCalled = true;
          },
        ),
      );
    }

    testWidgets('should display city dropdown and refresh button', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('City: '), findsOneWidget);
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('should show selected city in dropdown', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('New York'), findsOneWidget);
    });

    testWidgets('should call onCityChanged when city is selected', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('London'));
      await tester.pump();

      expect(cityChangedCalled, isTrue);
      expect(changedCity, equals('London'));
    });

    testWidgets('should call onRefresh when refresh button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Refresh'));
      await tester.pump();

      expect(refreshCalled, isTrue);
    });

    testWidgets('should display all available cities in dropdown', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Check that all cities are available in the dropdown
      expect(find.text('London'), findsOneWidget);
      expect(find.text('Tokyo'), findsOneWidget);
      expect(find.text('Invalid City'), findsOneWidget);
      expect(find.text('New York'), findsNWidgets(2));
    });

    testWidgets('should update when selectedCity changes', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('New York'), findsOneWidget);

      // Update the widget with new selected city
      selectedCity = 'London';
      await tester.pumpWidget(createWidget());

      expect(find.text('London'), findsOneWidget);
    });
  });
}
