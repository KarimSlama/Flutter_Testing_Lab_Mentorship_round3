import 'package:flutter/material.dart';

class TemperatureToggle extends StatelessWidget {
  final bool useFahrenheit;
  final ValueChanged<bool> onToggle;

  const TemperatureToggle({
    super.key,
    required this.useFahrenheit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Temperature Unit:'),
        const SizedBox(width: 10),
        Switch(value: useFahrenheit, onChanged: onToggle),
        Text(useFahrenheit ? 'Fahrenheit' : 'Celsius'),
      ],
    );
  }
}
