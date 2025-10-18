import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/weather/model/weather_data.dart';
import 'package:flutter_testing_lab/widgets/weather/widgets/weather_detail.dart';

/// Widget for displaying weather information in a card format
class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;
  final bool useFahrenheit;
  final double Function(double) temperatureConverter;

  const WeatherCard({
    super.key,
    required this.weatherData,
    required this.useFahrenheit,
    required this.temperatureConverter,
  });

  @override
  Widget build(BuildContext context) {
    final displayTemperature = useFahrenheit
        ? temperatureConverter(weatherData.temperatureCelsius)
        : weatherData.temperatureCelsius;

    final temperatureUnit = useFahrenheit ? '°F' : '°C';

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(weatherData.icon, style: const TextStyle(fontSize: 48)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weatherData.city,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weatherData.description,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${displayTemperature.toStringAsFixed(1)}$temperatureUnit',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherDetail(
                  label: 'Humidity',
                  value: '${weatherData.humidity}%',
                  icon: Icons.water_drop,
                ),
                WeatherDetail(
                  label: 'Wind Speed',
                  value: '${weatherData.windSpeed} km/h',
                  icon: Icons.air,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
