import 'package:flutter/material.dart';

class ToolBoxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de Herramientas'),
      ),


       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Image.asset('assets/caja.jpg'), 
            SizedBox(height: 20), // Espacio entre la imagen y el texto
            Text(
              'Caja de Herramientas',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}