import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/model/cart_item.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/cart_item_widget.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('CartItemWidget', () {
    late CartItem testItem;
    late bool removeCalled;
    late bool decreaseCalled;
    late bool increaseCalled;

    setUp(() {
      testItem = CartItem(
        id: '1',
        name: 'Test Item',
        price: 100.0,
        quantity: 2,
        discount: 0.1,
      );
      removeCalled = false;
      decreaseCalled = false;
      increaseCalled = false;
    });

    Widget createWidget() {
      return createTestWidget(
        CartItemWidget(
          item: testItem,
          onRemove: () => removeCalled = true,
          onDecreaseQuantity: () => decreaseCalled = true,
          onIncreaseQuantity: () => increaseCalled = true,
        ),
      );
    }

    testWidgets('should display item information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('Price: \$100.00 each'), findsOneWidget);
      expect(find.text('Discount: 10%'), findsOneWidget);
      expect(find.text('Item Total: \$200.00'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // quantity
    });

    testWidgets('should not display discount when discount is 0', (
      WidgetTester tester,
    ) async {
      testItem = CartItem(
        id: '1',
        name: 'Test Item',
        price: 100.0,
        quantity: 1,
        discount: 0.0,
      );

      await tester.pumpWidget(createWidget());

      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('Price: \$100.00 each'), findsOneWidget);
      expect(find.text('Discount: 10%'), findsNothing);
      expect(find.text('Item Total: \$100.00'), findsOneWidget);
    });

    testWidgets('should call onRemove when delete button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final deleteButton = find.byIcon(Icons.delete);
      expect(deleteButton, findsOneWidget);

      await tester.tap(deleteButton);
      await tester.pump();

      expect(removeCalled, isTrue);
    });

    testWidgets('should call onDecreaseQuantity when minus button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final minusButton = find.byIcon(Icons.remove);
      expect(minusButton, findsOneWidget);

      await tester.tap(minusButton);
      await tester.pump();

      expect(decreaseCalled, isTrue);
    });

    testWidgets('should call onIncreaseQuantity when plus button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final plusButton = find.byIcon(Icons.add);
      expect(plusButton, findsOneWidget);

      await tester.tap(plusButton);
      await tester.pump();

      expect(increaseCalled, isTrue);
    });

    testWidgets('should display correct item total calculation', (
      WidgetTester tester,
    ) async {
      testItem = CartItem(
        id: '1',
        name: 'Test Item',
        price: 50.0,
        quantity: 3,
        discount: 0.0,
      );

      await tester.pumpWidget(createWidget());

      // Item total should be price * quantity = 50 * 3 = 150
      expect(find.text('Item Total: \$150.00'), findsOneWidget);
    });

    testWidgets('should have red color for delete button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      final deleteButton = find.widgetWithIcon(IconButton, Icons.delete);
      final iconButton = tester.widget<IconButton>(deleteButton);

      expect(iconButton.color, equals(Colors.red));
    });
  });
}
