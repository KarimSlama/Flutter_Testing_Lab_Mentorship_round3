import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/cart_manager.dart';

void main() {
  group('CartManager', () {
    late CartManager cartManager;

    setUp(() {
      cartManager = CartManager();
    });

    test('should start with empty cart', () {
      expect(cartManager.items, isEmpty);
      expect(cartManager.isEmpty, isTrue);
      expect(cartManager.totalItems, equals(0));
      expect(cartManager.subtotal, equals(0.0));
      expect(cartManager.totalDiscount, equals(0.0));
      expect(cartManager.totalAmount, equals(0.0));
    });

    test('should add new item to cart', () {
      cartManager.addItem('1', 'iPhone', 999.99, discount: 0.1);

      expect(cartManager.items.length, equals(1));
      expect(cartManager.items.first.id, equals('1'));
      expect(cartManager.items.first.name, equals('iPhone'));
      expect(cartManager.items.first.price, equals(999.99));
      expect(cartManager.items.first.quantity, equals(1));
      expect(cartManager.items.first.discount, equals(0.1));
      expect(cartManager.isEmpty, isFalse);
      expect(cartManager.totalItems, equals(1));
    });

    test('should increase quantity when adding existing item', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.addItem('1', 'iPhone', 999.99);

      expect(cartManager.items.length, equals(1));
      expect(cartManager.items.first.quantity, equals(2));
      expect(cartManager.totalItems, equals(2));
    });

    test('should remove item from cart', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.addItem('2', 'Samsung', 899.99);

      expect(cartManager.items.length, equals(2));

      cartManager.removeItem('1');

      expect(cartManager.items.length, equals(1));
      expect(cartManager.items.first.id, equals('2'));
    });

    test('should update item quantity', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.updateQuantity('1', 5);

      expect(cartManager.items.first.quantity, equals(5));
      expect(cartManager.totalItems, equals(5));
    });

    test('should remove item when quantity is set to 0', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.updateQuantity('1', 0);

      expect(cartManager.items, isEmpty);
      expect(cartManager.isEmpty, isTrue);
    });

    test('should clear all items from cart', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.addItem('2', 'Samsung', 899.99);

      expect(cartManager.items.length, equals(2));

      cartManager.clearCart();

      expect(cartManager.items, isEmpty);
      expect(cartManager.isEmpty, isTrue);
    });

    test('should calculate subtotal correctly', () {
      cartManager.addItem('1', 'iPhone', 100.0);
      cartManager.addItem('1', 'iPhone', 100.0); // quantity = 2
      cartManager.addItem('2', 'Samsung', 200.0);

      expect(cartManager.subtotal, equals(400.0)); // (100*2) + (200*1)
    });

    test('should calculate total discount correctly', () {
      cartManager.addItem('1', 'iPhone', 100.0, discount: 0.1);
      cartManager.addItem('1', 'iPhone', 100.0, discount: 0.1); // quantity = 2
      cartManager.addItem('2', 'Samsung', 200.0, discount: 0.2);

      // iPhone: 100 * 0.1 * 2 = 20
      // Samsung: 200 * 0.2 * 1 = 40
      // Total: 60
      expect(cartManager.totalDiscount, equals(60.0));
    });

    test('should calculate total amount correctly', () {
      cartManager.addItem('1', 'iPhone', 100.0, discount: 0.1);
      cartManager.addItem('1', 'iPhone', 100.0, discount: 0.1); // quantity = 2
      cartManager.addItem('2', 'Samsung', 200.0, discount: 0.2);

      // Subtotal: (100*2) + (200*1) = 400
      // Discount: (100*0.1*2) + (200*0.2*1) = 20 + 40 = 60
      // Total: 400 - 60 = 340
      expect(cartManager.totalAmount, equals(340.0));
    });

    test('should get item by ID', () {
      cartManager.addItem('1', 'iPhone', 999.99);
      cartManager.addItem('2', 'Samsung', 899.99);

      final item = cartManager.getItemById('1');
      expect(item, isNotNull);
      expect(item!.id, equals('1'));
      expect(item.name, equals('iPhone'));

      final nonExistentItem = cartManager.getItemById('3');
      expect(nonExistentItem, isNull);
    });
  });
}
