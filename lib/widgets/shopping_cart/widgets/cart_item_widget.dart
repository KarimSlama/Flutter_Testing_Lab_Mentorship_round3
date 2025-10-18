import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart/model/cart_item.dart';

/// Widget that displays a single cart item with quantity controls
class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onIncreaseQuantity;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final itemTotal = item.price * item.quantity;

    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${item.price.toStringAsFixed(2)} each'),
            if (item.discount > 0)
              Text(
                'Discount: ${(item.discount * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.green),
              ),
            Text('Item Total: \$${itemTotal.toStringAsFixed(2)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDecreaseQuantity,
              icon: const Icon(Icons.remove),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('${item.quantity}'),
            ),
            IconButton(
              onPressed: onIncreaseQuantity,
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
