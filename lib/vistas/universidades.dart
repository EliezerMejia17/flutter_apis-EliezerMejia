import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String country = '';
  List<dynamic> universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$country'),
    );

    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      throw Exception('Error al obtener universidades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) {
                country = text;
              },
              decoration: InputDecoration(
                labelText: 'Ingresa el nombre del país (en inglés)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchUniversities(country);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Text('Lista de universidades:',  style: TextStyle(fontSize: 24),),
            Expanded(
              child: universities.isNotEmpty
                  ? ListView.builder(
                      itemCount: universities.length,
                      itemBuilder: (context, index) {
                        final university = universities[index];
                        return ListTile(
                          title: Text(university['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dominio: ${university['domains'][0]}'),
                              GestureDetector(
                                onTap: () {
                                  final url = university['web_pages'][0];
                                  if (url != null) {
                                    _launchURL(url);
                                  }
                                },
                                child: Text(
                                  university['web_pages'][0],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Text('No hay universidades disponibles'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
  final uri = Uri.parse(url);  
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'No se pudo abrir $url';
  }
}
}