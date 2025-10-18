import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/cart_manager.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/add_item_buttons.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/cart_item_widget.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/widgets/cart_summary.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final CartManager _cartManager = CartManager();

  void _addItem(String id, String name, double price, {double discount = 0.0}) {
    setState(() {
      _cartManager.addItem(id, name, price, discount: discount);
    });
  }

  void _removeItem(String id) {
    setState(() {
      _cartManager.removeItem(id);
    });
  }

  void _updateQuantity(String id, int newQuantity) {
    setState(() {
      _cartManager.updateQuantity(id, newQuantity);
    });
  }

  void _clearCart() {
    setState(() {
      _cartManager.clearCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddItemButtons(onAddItem: _addItem),
        const SizedBox(height: 16),

        CartSummary(
          totalItems: _cartManager.totalItems,
          subtotal: _cartManager.subtotal,
          totalDiscount: _cartManager.totalDiscount,
          totalAmount: _cartManager.totalAmount,
          onClearCart: _clearCart,
        ),
        const SizedBox(height: 16),

        _cartManager.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _cartManager.items.length,
                itemBuilder: (context, index) {
                  final item = _cartManager.items[index];

                  return CartItemWidget(
                    item: item,
                    onRemove: () => _removeItem(item.id),
                    onDecreaseQuantity: () =>
                        _updateQuantity(item.id, item.quantity - 1),
                    onIncreaseQuantity: () =>
                        _updateQuantity(item.id, item.quantity + 1),
                  );
                },
              ),
      ],
    );
  }
}
