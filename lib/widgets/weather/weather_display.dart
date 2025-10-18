import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/weather/model/weather_data.dart';
import 'package:flutter_testing_lab/widgets/weather/weather_manager.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/city_selector.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/temperature_toggle.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/weather_card.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  final WeatherManager _weatherManager = WeatherManager();
  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;
  bool _useFahrenheit = false;
  String _selectedCity = 'New York';

  Future<void> _loadWeather() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    final weatherData = await _weatherManager.loadWeatherData(_selectedCity);

    if (mounted) {
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
        if (weatherData == null) {
          _error = 'Failed to load weather data';
        }
      });
    }
  }

  void _onCityChanged(String city) {
    setState(() {
      _selectedCity = city;
    });
    _loadWeather();
  }

  void _onTemperatureToggle(bool useFahrenheit) {
    setState(() {
      _useFahrenheit = useFahrenheit;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CitySelector(
            selectedCity: _selectedCity,
            availableCities: _weatherManager.availableCities,
            onCityChanged: _onCityChanged,
            onRefresh: _loadWeather,
          ),
          const SizedBox(height: 16),

          TemperatureToggle(
            useFahrenheit: _useFahrenheit,
            onToggle: _onTemperatureToggle,
          ),
          const SizedBox(height: 16),

          if (_isLoading && _error == null)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            )
          else if (_weatherData != null)
            WeatherCard(
              weatherData: _weatherData!,
              useFahrenheit: _useFahrenheit,
              temperatureConverter: _weatherManager.celsiusToFahrenheit,
            ),
        ],
      ),
    );
  }
}
