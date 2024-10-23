import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _posts = [];

  Future<void> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://www.sonymusic.com/wp-json/wp/v2/posts'), 
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _posts = data.take(3).toList(); // Obtener las 3 últimas noticias
      });
    } else {
      throw Exception('Error al cargar las noticias');
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de Sony Music'),
      ),
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [

                  // Mostrar logo de Sony Music cargado localmente
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/pnglogo.png',  height: 100,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title']['rendered'], // Título de la noticia
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),

                              SizedBox(height: 10),
                              Text(
                                post['excerpt']['rendered'] // Resumen de la noticia
                                    .replaceAll(RegExp(r'<[^>]*>'), ''), // Eliminar etiquetas HTML
                                style: TextStyle(fontSize: 16),
                              ),

                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  _launchURL(post['link']); // Enlace a la noticia original
                                },
                                child: Text('Leer más'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}