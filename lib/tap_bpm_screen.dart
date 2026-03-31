import 'dart:async'; // Pour Timer
import 'dart:ui'; // Pour BackdropFilter
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TapBpmScreen extends StatefulWidget {
  const TapBpmScreen({super.key});

  @override
  _TapBpmScreenState createState() => _TapBpmScreenState();
}

class _TapBpmScreenState extends State<TapBpmScreen> {
  List<int> tapTimes = [];
  List<double> bpms = [];
  double averageBpm = 0;
  int tapCount = 0;
  int updateInterval = 4; // Nombre de taps avant la mise à jour
  bool isPressed = false; // État pour gérer l'animation
  late AudioPlayer audioPlayer; // Déclaration du player audio

// Fonction pour charger l'audio (Mise en place d'un bruit pour chaque click mais ne fonctionne pas.)
  Future<void> _loadAudio() async {
    try {
      await audioPlayer.setAsset('assets/click.wav'); // Chargement du son
    } catch (e) {
      print("Erreur de chargement du son : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _loadAudio();
  }


  void onTap() {
    setState(() {
      isPressed = true; // Change l'état pour déclencher l'animation
    });



    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isPressed = false; // Réinitialise l'état après un court délai
      });

      int now = DateTime.now().millisecondsSinceEpoch;
      tapTimes.add(now);
      tapCount++;

      if (tapTimes.length > 1) {
        int timeDifference = tapTimes.last - tapTimes[tapTimes.length - 2];
        double secondsPerBeat = timeDifference / 1000;
        double beatsPerMinute = 60 / secondsPerBeat;
        bpms.add(beatsPerMinute);

        if (tapCount >= updateInterval) {
          double sum = bpms.reduce((a, b) => a + b);
          double newAverageBpm = sum / bpms.length;
          setState(() {
            averageBpm = newAverageBpm;
          });
          // Réinitialise les listes pour le prochain cycle
          tapTimes.clear();
          bpms.clear();
          tapCount = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              'TAP BPM',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/tap_bpm_logo.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            AnimatedOpacity(
              opacity: isPressed ? 0.5 : 1.0, // Change l'opacité lorsque le bouton est pressé
              duration: Duration(milliseconds: 200), // Durée de l'animation
              child: GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/tap_ici_button.png',
                  width: 300,
                ),
              ),
            ),
            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Bords arrondis
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${averageBpm.toStringAsFixed(1)} BPM',
                      style: TextStyle(fontSize: 40, fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
