import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String weatherDescription = '';
  String temperature = '';
  String cityName = 'Santo Domingo'; 
  String apiKey = '3cc42d4afe183cdafc7239bc37004cba'; 

  Future<void> fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,do&appid=$apiKey&units=metric&lang=es'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherDescription = data['weather'][0]['description'];
        temperature = data['main']['temp'].toString();
        cityName = data['name'];
      });
    } else {
      throw Exception('Error al obtener el clima');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: weatherDescription.isEmpty
            ? CircularProgressIndicator() 
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$cityName',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '$temperature°C',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 10),
                  Text(
                    weatherDescription,
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.wb_sunny,
                    size: 100,
                    color: Colors.orange,
                  ),
                ],
              ),
      ),
    );
  }
}