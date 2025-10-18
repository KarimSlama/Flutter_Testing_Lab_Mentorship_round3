import 'package:flutter/material.dart';

/// Widget that displays buttons for adding items to the cart
class AddItemButtons extends StatelessWidget {
  final Function(String id, String name, double price, {double discount})
  onAddItem;

  const AddItemButtons({super.key, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ElevatedButton(
          onPressed: () =>
              onAddItem('1', 'Apple iPhone', 999.99, discount: 0.1),
          child: const Text('Add iPhone'),
        ),
        ElevatedButton(
          onPressed: () =>
              onAddItem('2', 'Samsung Galaxy', 899.99, discount: 0.15),
          child: const Text('Add Galaxy'),
        ),
        ElevatedButton(
          onPressed: () => onAddItem('3', 'iPad Pro', 1099.99),
          child: const Text('Add iPad'),
        ),
        ElevatedButton(
          onPressed: () =>
              onAddItem('1', 'Apple iPhone', 999.99, discount: 0.1),
          child: const Text('Add iPhone Again'),
        ),
      ],
    );
  }
}
