import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String selectedDate;
  final String selectedTime;

  WeatherDetailsPage({
    required this.weatherData,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    var forecast = weatherData["forecast"]["forecastday"][0];
    var hourlyData = forecast["hour"];

    var selectedHourWeather = hourlyData.firstWhere(
      (hour) => hour["time"].toString().contains(selectedTime.split(":")[0]),
      orElse: () => hourlyData[0],
    );

    return Scaffold(
      appBar: AppBar(title: Text("Weather Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weather for: $selectedDate at $selectedTime",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Temperature: ${selectedHourWeather["temp_c"]}°C"),
            Text("Feels Like: ${selectedHourWeather["feelslike_c"]}°C"),
            Text("Humidity: ${selectedHourWeather["humidity"]}%"),
            Text("Pressure: ${selectedHourWeather["pressure_mb"]} hPa"),
            Text("Sunrise: ${forecast["astro"]["sunrise"]}"),
            Text("Sunset: ${forecast["astro"]["sunset"]}"),
            Text("Moonrise: ${forecast["astro"]["moonrise"]}"),
            Text("Moonset: ${forecast["astro"]["moonset"]}"),
            Text("UV Index: ${selectedHourWeather["uv"]}"),
            Text("Wind Speed: ${selectedHourWeather["wind_kph"]} km/h"),
            Text("Wind Direction: ${selectedHourWeather["wind_dir"]}"),
          ],
        ),
      ),
    );
  }
}
