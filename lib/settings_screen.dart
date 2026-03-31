import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Variable pour gérer l'état du dark mode
  bool _darkModeActivated = false; // Pour vérifier si le dark mode est activé

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkModeActivated ? Colors.black : Colors.white, // Change la couleur de fond en fonction de l'état
      appBar: _darkModeActivated
          ? null // Si Dark Mode activé, pas d'AppBar
          : AppBar(
        automaticallyImplyLeading: false, // Pas de retour automatique
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/navarrow_leave.png',
                  width: 40,
                ),
              ),
            ),
            Spacer(),
            Text(
              'SETTINGS',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                launchUrl(Uri.parse("https://github.com/iless0"));
              },
              icon: Image.asset(
              'assets/rocket_link_github.png',
              width: 35,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // Texte affiché ou message de fonctionnalité en mode sombre
            _darkModeActivated
                ? SizedBox(height: 222) // Taille plus grande si Dark Mode activé
                : SizedBox(height: 200),
            _darkModeActivated
                ? Image.asset(
              'assets/eyes_darkmod.gif',
              height: 150, // Ajustez la taille du GIF si nécessaire
            )
                : Text(''),
            _darkModeActivated
                ? Text(
              "Pas encore dispo pour l'instant :(",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            )
                : Text(
              'Créé par Boudib Iliès\n en Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),

            // Le bouton Dark Mode reste fixe ici
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 25, fontFamily: 'Montserrat', color: Color(0XFF0000FF)),
                ),
                Switch(
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                      _darkModeActivated = _isDarkMode;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
