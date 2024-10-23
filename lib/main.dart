import 'package:flutter/material.dart';
import 'vistas/caja_herramientas.dart'; // Importa la pantalla de la caja de herramientas
import 'vistas/predicc_genero.dart';
import 'vistas/edad.dart'; 
import 'vistas/universidades.dart'; 
import 'vistas/clima.dart'; 
import 'vistas/wordpress.dart';
import 'vistas/acercade.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable para controlar la pantalla seleccionada
  Widget _currentScreen = ToolBoxScreen(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de Herramientas App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 203, 177, 236),
              ),
              child: Center(
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            ),

            ListTile(
              title: Text('Caja de Herramientas'),
              onTap: () {
                setState(() {
                  _currentScreen = ToolBoxScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Predicción de Género'),
              onTap: () {
                setState(() {
                  _currentScreen = GenderPredictorScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Edad'),
              onTap: () {
                setState(() {
                  _currentScreen = AgePredictorScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Universidades'),
              onTap: () {
                setState(() {
                  _currentScreen = UniversitiesScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Clima RD'),
              onTap: () {
                setState(() {
                  _currentScreen = WeatherScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Noticias WordPress'),
              onTap: () {
                setState(() {
                  _currentScreen = NewsScreen(); 
                });
                Navigator.pop(context); 
              },
            ),

            ListTile(
              title: Text('Acerca de'),
              onTap: () {
                setState(() {
                  _currentScreen = AboutMeScreen(); 
                });
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),

      body: _currentScreen,
    );
  }
}