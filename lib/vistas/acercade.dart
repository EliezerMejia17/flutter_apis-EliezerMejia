import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de mí'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/fotomia.jpg'), 
              ),
              SizedBox(height: 20),

              Text(
                'Eliezer Mejía Caba',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '2022-2127',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              Text(
                'Desarrollador de software. Apasionado por la tecnología y los proyectos innovadores. Estoy disponible para trabajos freelance o colaboraciones en desarrollo de aplicaciones web y móviles.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contacto:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 10),
                      Text('eliezermejia161704@gmail.com'), 
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10),
                      Text('+1 849 882 0417'), 
                    ],
                  ),
                  
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}