import 'package:flutter/material.dart';

/// Widget that displays the cart summary including totals and clear button
class CartSummary extends StatelessWidget {
  final int totalItems;
  final double subtotal;
  final double totalDiscount;
  final double totalAmount;
  final VoidCallback onClearCart;

  const CartSummary({
    super.key,
    required this.totalItems,
    required this.subtotal,
    required this.totalDiscount,
    required this.totalAmount,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Items: $totalItems'),
              ElevatedButton(
                onPressed: onClearCart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Clear Cart'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
          Text('Total Discount: \$${totalDiscount.toStringAsFixed(2)}'),
          const Divider(),
          Text(
            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
