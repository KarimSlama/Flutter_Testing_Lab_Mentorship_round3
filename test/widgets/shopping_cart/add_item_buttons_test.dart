import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/add_item_buttons.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('AddItemButtons', () {
    late List<Map<String, dynamic>> addItemCalls;

    setUp(() {
      addItemCalls = [];
    });

    Widget createWidget() {
      return createTestWidget(
        AddItemButtons(
          onAddItem:
              (String id, String name, double price, {double discount = 0.0}) {
                addItemCalls.add({
                  'id': id,
                  'name': name,
                  'price': price,
                  'discount': discount,
                });
              },
        ),
      );
    }

    testWidgets('should display all add item buttons', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Add iPhone'), findsOneWidget);
      expect(find.text('Add Galaxy'), findsOneWidget);
      expect(find.text('Add iPad'), findsOneWidget);
      expect(find.text('Add iPhone Again'), findsOneWidget);
    });

    testWidgets('should call onAddItem with correct parameters for iPhone', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(addItemCalls.length, equals(1));
      expect(addItemCalls[0]['id'], equals('1'));
      expect(addItemCalls[0]['name'], equals('Apple iPhone'));
      expect(addItemCalls[0]['price'], equals(999.99));
      expect(addItemCalls[0]['discount'], equals(0.1));
    });

    testWidgets('should call onAddItem with correct parameters for Galaxy', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Add Galaxy'));
      await tester.pump();

      expect(addItemCalls.length, equals(1));
      expect(addItemCalls[0]['id'], equals('2'));
      expect(addItemCalls[0]['name'], equals('Samsung Galaxy'));
      expect(addItemCalls[0]['price'], equals(899.99));
      expect(addItemCalls[0]['discount'], equals(0.15));
    });

    testWidgets('should call onAddItem with correct parameters for iPad', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Add iPad'));
      await tester.pump();

      expect(addItemCalls.length, equals(1));
      expect(addItemCalls[0]['id'], equals('3'));
      expect(addItemCalls[0]['name'], equals('iPad Pro'));
      expect(addItemCalls[0]['price'], equals(1099.99));
      expect(addItemCalls[0]['discount'], equals(0.0));
    });

    testWidgets(
      'should call onAddItem with correct parameters for iPhone Again',
      (tester) async {
        await tester.pumpWidget(createWidget());

        await tester.tap(find.text('Add iPhone Again'));
        await tester.pump();

        expect(addItemCalls.length, equals(1));
        expect(addItemCalls[0]['id'], equals('1'));
        expect(addItemCalls[0]['name'], equals('Apple iPhone'));
        expect(addItemCalls[0]['price'], equals(999.99));
        expect(addItemCalls[0]['discount'], equals(0.1));
      },
    );

    testWidgets('should allow multiple button presses', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Add iPhone'));
      await tester.tap(find.text('Add Galaxy'));
      await tester.tap(find.text('Add iPad'));
      await tester.pump();

      expect(addItemCalls.length, equals(3));
      expect(addItemCalls[0]['name'], equals('Apple iPhone'));
      expect(addItemCalls[1]['name'], equals('Samsung Galaxy'));
      expect(addItemCalls[2]['name'], equals('iPad Pro'));
    });
  });
}
