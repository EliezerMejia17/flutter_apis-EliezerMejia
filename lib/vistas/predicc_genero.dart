import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredictorScreen extends StatefulWidget {
  @override
  _GenderPredictorScreenState createState() => _GenderPredictorScreenState();
}

class _GenderPredictorScreenState extends State<GenderPredictorScreen> {
  String name = '';
  String gender = '';
  Color screenColor = Colors.white;

  Future<void> predictGender(String name) async {
    final response = await http.get(
        Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gender = data['gender'] ?? 'unknown';
        if (gender == 'male') {
          screenColor = Colors.blue;
        } else if (gender == 'female') {
          screenColor = Colors.pink;
        } else {
          screenColor = Colors.grey;
        }
      });
    } else {
      throw Exception('Error al obtener el género');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      
      body: Container(
        color: screenColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                name = text;
              },
              decoration: InputDecoration(labelText: 'Ingresa tu nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictGender(name);
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            Text(
              'Género: $gender',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}