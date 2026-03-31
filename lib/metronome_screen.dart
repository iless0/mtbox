import 'dart:async'; // Pour Timer
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  _MetronomeScreenState createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> {
  TextEditingController bpmController = TextEditingController();
  double bpm = 120.0; // Valeur par défaut
  Timer? metronomeTimer;
  bool isPlaying = false;
  late AudioPlayer audioPlayer;

  Future<void> loadAudio() async {
    await audioPlayer.setAsset('assets/click.wav');
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    loadAudio();
  }

  void startMetronome() {
    if (bpm <= 0) return;

    setState(() {
      isPlaying = true;
    });

    double interval = 60000 / bpm; // Intervalle en millisecondes
    metronomeTimer?.cancel();

    metronomeTimer = Timer.periodic(Duration(milliseconds: interval.toInt()), (timer) async {
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.play();
    });
  }


  void stopMetronome() {
    setState(() {
      isPlaying = false;
    });
    metronomeTimer?.cancel();
  }

  @override
  void dispose() {
    metronomeTimer?.cancel();
    audioPlayer.dispose();
    super.dispose();
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
              'MÉTRONOME',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/metronome_logo.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset(
              'assets/metronome_image.png',
              width: 350,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80), // Agrandir la zone
              child: TextField(
                controller: bpmController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'), // Texte plus grand
                decoration: InputDecoration(
                  labelText: 'Entrer un BPM',
                  labelStyle: TextStyle(fontSize: 20, fontFamily: 'Montserrat'), // Texte du label plus grand
                  hintText: '120', // Valeur par défaut affichée tant que l'utilisateur n'a rien entré
                  hintStyle: TextStyle(fontSize: 24, color: Colors.grey, fontFamily: 'Montserrat'), // Style du texte d’attente
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Coins arrondis
                    borderSide: BorderSide(width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Espace intérieur plus large
                ),
                onChanged: (value) {
                  setState(() {
                    bpm = double.tryParse(value) ?? 120.0;
                  });
                },
              ),
            ),

            SizedBox(height: 20), // Espacement

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isPlaying ? null : startMetronome,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40), // Agrandir les boutons
                    textStyle: TextStyle(fontSize: 22, fontFamily: 'Montserrat'), // Texte plus grand

                  ),
                  child: Text('Play', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: isPlaying ? stopMetronome : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 33),
                    textStyle: TextStyle(fontSize: 22, fontFamily: 'Montserrat'),
                  ),
                  child: Text('Pause', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
