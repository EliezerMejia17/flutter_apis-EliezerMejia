import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AgePredictorScreen extends StatefulWidget {
  @override
  _AgePredictorScreenState createState() => _AgePredictorScreenState();
}

class _AgePredictorScreenState extends State<AgePredictorScreen> {
  String name = '';
  int age = 0;
  String category = '';
  String imageAsset = 'assets/personas.png'; 

  Future<void> predictAge(String name) async {
    final response = await http.get(
        Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        age = data['age'] ?? 0;
        _setCategoryAndImage(age);
      });
    } else {
      throw Exception('Error al obtener la edad');
    }
  }

  void _setCategoryAndImage(int age) {
    if (age <= 18) {
      category = 'Joven';
      imageAsset = 'assets/joven.jpg'; 
    } else if (age > 18 && age <= 60) {
      category = 'Adulto';
      imageAsset = 'assets/adulto.jpg'; 
    } else {
      category = 'Anciano';
      imageAsset = 'assets/anciano.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                predictAge(name);
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            Text(
              'Edad: $age',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Categoría: $category',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (imageAsset.isNotEmpty) Image.asset(imageAsset), // Muestra la imagen según la categoría
          ],
        ),
      ),
    );
  }
}