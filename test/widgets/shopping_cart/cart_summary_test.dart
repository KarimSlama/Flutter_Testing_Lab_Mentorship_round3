import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/cart_summary.dart';

import '../../core/create_test_widget.dart';

void main() {
  group('CartSummary', () {
    testWidgets('should display cart summary information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          CartSummary(
            totalItems: 5,
            subtotal: 100.0,
            totalDiscount: 10.0,
            totalAmount: 90.0,
            onClearCart: () {},
          ),
        ),
      );

      // Check if all text elements are displayed
      expect(find.text('Total Items: 5'), findsOneWidget);
      expect(find.text('Subtotal: \$100.00'), findsOneWidget);
      expect(find.text('Total Discount: \$10.00'), findsOneWidget);
      expect(find.text('Total Amount: \$90.00'), findsOneWidget);
      expect(find.text('Clear Cart'), findsOneWidget);
    });

    testWidgets('should call onClearCart when clear button is pressed', (
      WidgetTester tester,
    ) async {
      bool clearCartCalled = false;

      await tester.pumpWidget(
        createTestWidget(
          CartSummary(
            totalItems: 3,
            subtotal: 50.0,
            totalDiscount: 5.0,
            totalAmount: 45.0,
            onClearCart: () {
              clearCartCalled = true;
            },
          ),
        ),
      );

      // Find and tap the clear cart button
      final clearButton = find.text('Clear Cart');
      expect(clearButton, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump();

      expect(clearCartCalled, isTrue);
    });

    testWidgets('should display correct formatting for currency values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          CartSummary(
            totalItems: 1,
            subtotal: 123.456,
            totalDiscount: 12.345,
            totalAmount: 111.111,
            onClearCart: () {},
          ),
        ),
      );

      // Check currency formatting (should show 2 decimal places)
      expect(find.text('Subtotal: \$123.46'), findsOneWidget);
      expect(find.text('Total Discount: \$12.35'), findsOneWidget);
      expect(find.text('Total Amount: \$111.11'), findsOneWidget);
    });

    testWidgets('should have red background for clear button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          CartSummary(
            totalItems: 1,
            subtotal: 100.0,
            totalDiscount: 0.0,
            totalAmount: 100.0,
            onClearCart: () {},
          ),
        ),
      );

      final clearButton = find.widgetWithText(ElevatedButton, 'Clear Cart');
      expect(clearButton, findsOneWidget);

      final button = tester.widget<ElevatedButton>(clearButton);
      expect(button.style?.backgroundColor?.resolve({}), equals(Colors.red));
    });
  });
}
