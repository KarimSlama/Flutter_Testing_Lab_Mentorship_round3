import 'package:flutter_testing_lab/widgets/shopping_cart/model/cart_item.dart';

/// Manages the shopping cart logic and state
class CartManager {
  final List<CartItem> _items = [];

  /// Get all items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  /// Add an item to the cart or increase quantity if it already exists
  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final index = _items.indexWhere((item) => item.id == id);

    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(
        CartItem(id: id, name: name, price: price, discount: discount),
      );
    }
  }

  /// Remove an item from the cart
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  /// Update the quantity of an item
  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
    }
  }

  /// Clear all items from the cart
  void clearCart() {
    _items.clear();
  }

  /// Calculate subtotal (price * quantity for all items)
  double get subtotal {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  /// Calculate total discount amount
  double get totalDiscount {
    return _items.fold(0.0, (sum, item) => sum + item.totalDiscountAmount);
  }

  /// Calculate total amount after discount
  double get totalAmount {
    return subtotal - totalDiscount;
  }

  /// Get total number of items in cart
  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  /// Get item by ID
  CartItem? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
