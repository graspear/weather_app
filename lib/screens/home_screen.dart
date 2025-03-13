import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_service.dart';
import 'weather_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cityController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now(); //

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _fetchWeather() async {
    if (cityController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a city name")));
      return;
    }

    String dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    String timeStr = selectedTime.format(context);

    var weatherData = await WeatherService.getWeather(
      cityController.text,
      dateStr,
    );

    if (weatherData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => WeatherDetailsPage(
                weatherData: weatherData,
                selectedDate: dateStr,
                selectedTime: timeStr,
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to fetch weather data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text("Choose Date"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Selected Time: ${selectedTime.format(context)}",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text("Choose Time"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: _fetchWeather,
                child: Text("Get Weather"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
