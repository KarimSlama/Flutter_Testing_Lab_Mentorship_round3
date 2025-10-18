import 'package:flutter/material.dart';

/// Widget for selecting a city and refreshing weather data
class CitySelector extends StatelessWidget {
  final String selectedCity;
  final List<String> availableCities;
  final ValueChanged<String> onCityChanged;
  final VoidCallback onRefresh;

  const CitySelector({
    super.key,
    required this.selectedCity,
    required this.availableCities,
    required this.onCityChanged,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('City: '),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButton<String>(
            value: selectedCity,
            isExpanded: true,
            items: availableCities.map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onCityChanged(value);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(onPressed: onRefresh, child: const Text('Refresh')),
      ],
    );
  }
}
