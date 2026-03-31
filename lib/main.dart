import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importe la page principale

void main() {
runApp(MTBoxApp());  // Lance l'appli
}

class MTBoxApp extends StatelessWidget {
  const MTBoxApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MT Box', // Nom de l'appli
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF1F1F1) // Fond de l'application
      ),
      home: HomeScreen(), // Définit l'écran principal
    );
  }
}


