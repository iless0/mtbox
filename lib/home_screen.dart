import 'package:flutter/material.dart';
import 'package:project/dictaphone_screen.dart';
import 'second_page.dart'; // Importe la deuxième page pour la navigation
import 'tap_bpm_screen.dart'; // Importe la page du tap bpm
import 'metronome_screen.dart'; // Importe la page du metronome
import 'settings_screen.dart'; // Importe la page des paramètres'

// Page principal
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,  // Couleur de fond de l'AppBar
        toolbarHeight: 100, // Hauteur de l'AppBar
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child : Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 50,
              ),
            ),
            Spacer(),
            Text(
              'MT BOX',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),

            ),
            Spacer(),
          ],
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child : IconButton(
              icon: Image.asset(
                'assets/settings_logo.png',
                width: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30), // Espace entre le haut et le premier bouton
            buildFeatureButton(
              context,
              'assets/dictaphone_logo.png',
              'DICTAPHONE',
              Color(0xFFFFFFFF),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DictaphoneScreen()),
                    );
              },
            ),
            SizedBox(height: 10), // Espacement entre les boutons
            buildFeatureButton(
              context,
              'assets/tap_bpm_logo.png',
              'TAP BPM',
              Color(0xFFFFFFFF),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TapBpmScreen()),
                    );
              },
            ),
            SizedBox(height: 10),
            buildFeatureButton(
              context,
              'assets/metronome_logo.png',
              'MÉTRONOME',
              Color(0xFFFFFFFF),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MetronomeScreen()),
                    );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children:[
          Padding(
            padding: EdgeInsets.only(bottom: 50), // Espace sous la barre de navigation
            child: Container(
              width: double.infinity,
              height: 35, // Hauteur de la barre de navigation
              color: Color(0xFFFFFFFF),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 25, // Positionnement de la fleche de navigation
            child: IconButton(
                icon: Image.asset(
                  'assets/navarrow_right.png',
                  width: 70,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour modifier les boutons
  Widget buildFeatureButton(BuildContext context, String imagePath, String label, Color backgroundColor, VoidCallback onPressed) {
    return SizedBox(
      width: 350,
      height: 200,
      child: Card(
        color: backgroundColor,
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath,
                      width: 80,
                    ),
                    SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    'assets/arrow_access.png',
                    width: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}