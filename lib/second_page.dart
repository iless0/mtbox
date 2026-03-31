import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importe la page principale pour la navigation
import 'scale_liste_screen.dart'; // Importe la page de la liste des gammes'
import 'settings_screen.dart'; // Importe la page des paramètres'
import 'mixtip_screen.dart'; // Importe la page des tips de mixage'

// Nouvelle Page (Page 2)
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white, // Couleur de fond de l'AppBar
        toolbarHeight: 100, // Hauteur de l'AppBar
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image.asset(
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
            child: IconButton(
              icon: Image.asset(
                'assets/settings_logo.png',
                width: 24,
                height: 24,
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
              'assets/scale_logo.png',
              'SCALE LIST',
              Color(0xFFFFFFFF),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScaleListScreen()),
                    );
              },
            ),
            SizedBox(height: 10), // Espacement entre les boutons
            buildFeatureButton(
              context,
              'assets/mixtip_logo.png',
              'MIX TIPS',
              Color(0xFFFFFFFF),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MixTipPage()),
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
            left: 0,
            bottom: 25, // Positionnement de la fleche de navigation
            child: IconButton(
                icon: Image.asset(
                  'assets/navarrow_left.png',
                  width: 70,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          final tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      )
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