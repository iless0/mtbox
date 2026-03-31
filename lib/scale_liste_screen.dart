import 'package:flutter/material.dart';

class ScaleListScreen extends StatefulWidget {
  const ScaleListScreen({super.key});

  @override
  _ScaleListScreenState createState() => _ScaleListScreenState();
}

class _ScaleListScreenState extends State<ScaleListScreen> {
  // Variables pour stocker la note et la gamme sélectionnées
  String? selectedNote = 'E'; // Par défaut E
  String? selectedScale = 'Mineure mélodique (montée)'; // Par défaut Mineur Mélodique (Montée)
  String notesDisplay = ''; // Affichage des notes

  // Listes des options pour les notes et les gammes
  final List<String> notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
  final List<String> scales = [
    'Majeure',
    'Mineure (Naturelle)',
    'Mineure harmonique',
    'Mineure mélodique (montée)',
    'Pentatonique majeure',
    'Pentatonique mineure',
    'Gamme arabe (Maqam Hijaz)',
  ];

  // Les notes pour chaque combinaison de note et de gamme
  Map<String, Map<String, List<String>>> scaleNotes = {
    'C': {
      'Majeure': ['C', 'D', 'E', 'F', 'G', 'A', 'B'],
      'Mineure (Naturelle)': ['C', 'D', 'Eb', 'F', 'G', 'Ab', 'Bb'],
      'Mineure harmonique': ['C', 'D', 'Eb', 'F', 'G', 'Ab', 'B'],
      'Mineure mélodique (montée)': ['C', 'D', 'Eb', 'F', 'G', 'A', 'B'],
      'Pentatonique majeure': ['C', 'D', 'E', 'G', 'A'],
      'Pentatonique mineure': ['C', 'Eb', 'F', 'G', 'Bb'],
      'Gamme arabe (Maqam Hijaz)': ['C', 'Db', 'E', 'F', 'G', 'Ab', 'Bb'],
    },
    'C#': {
      'Majeure': ['C#', 'D#', 'F', 'F#', 'G#', 'A#', 'B'],
      'Mineure (Naturelle)': ['C#', 'D#', 'E', 'F#', 'G#', 'A', 'B'],
      'Mineure harmonique': ['C#', 'D#', 'E', 'F#', 'G#', 'A', 'B#'],
      'Mineure mélodique (montée)': ['C#', 'D#', 'E', 'F#', 'G#', 'A#', 'B#'],
      'Pentatonique majeure': ['C#', 'D#', 'F', 'G#', 'A#'],
      'Pentatonique mineure': ['C#', 'E', 'F#', 'G#', 'B'],
      'Gamme arabe (Maqam Hijaz)': ['C#', 'D', 'F', 'F#', 'G#', 'A', 'B'],
    },
    'D': {
      'Majeure': ['D', 'E', 'F#', 'G', 'A', 'B', 'C#'],
      'Mineure (Naturelle)': ['D', 'E', 'F', 'G', 'A', 'Bb', 'C'],
      'Mineure harmonique': ['D', 'E', 'F', 'G', 'A', 'Bb', 'C#'],
      'Mineure mélodique (montée)': ['D', 'E', 'F', 'G', 'A', 'B', 'C#'],
      'Pentatonique majeure': ['D', 'E', 'F#', 'A', 'B'],
      'Pentatonique mineure': ['D', 'F', 'G', 'A', 'C'],
      'Gamme arabe (Maqam Hijaz)': ['D', 'Eb', 'F#', 'G', 'A', 'Bb', 'C'],
    },
    'D#': {
      'Majeure': ['D#', 'F', 'G', 'G#', 'A#', 'C', 'C#'],
      'Mineure (Naturelle)': ['D#', 'F', 'F#', 'G#', 'A#', 'B', 'C'],
      'Mineure harmonique': ['D#', 'F', 'F#', 'G#', 'A#', 'B', 'C#'],
      'Mineure mélodique (montée)': ['D#', 'F', 'F#', 'G#', 'A#', 'C', 'D'],
      'Pentatonique majeure': ['D#', 'F', 'G', 'A#', 'C'],
      'Pentatonique mineure': ['D#', 'F#', 'G#', 'A#', 'C#'],
      'Gamme arabe (Maqam Hijaz)': ['D#', 'E', 'G', 'G#', 'A#', 'B', 'C'],
    },
    'E': {
      'Majeure': ['E', 'F#', 'G#', 'A', 'B', 'C#', 'D#'],
      'Mineure (Naturelle)': ['E', 'F#', 'G', 'A', 'B', 'C', 'D'],
      'Mineure harmonique': ['E', 'F#', 'G', 'A', 'B', 'C', 'D#'],
      'Mineure mélodique (montée)': ['E', 'F#', 'G', 'A', 'B', 'C#', 'D#'],
      'Pentatonique majeure': ['E', 'F#', 'G#', 'B', 'C#'],
      'Pentatonique mineure': ['E', 'G', 'A', 'B', 'D'],
      'Gamme arabe (Maqam Hijaz)': ['E', 'F', 'G#', 'A', 'B', 'C', 'D'],
    },
    'F': {
      'Majeure': ['F', 'G', 'A', 'Bb', 'C', 'D', 'E'],
      'Mineure (Naturelle)': ['F', 'G', 'Ab', 'Bb', 'C', 'Db', 'Eb'],
      'Mineure harmonique': ['F', 'G', 'Ab', 'Bb', 'C', 'Db', 'E'],
      'Mineure mélodique (montée)': ['F', 'G', 'Ab', 'Bb', 'C', 'D', 'E'],
      'Pentatonique majeure': ['F', 'G', 'A', 'C', 'D'],
      'Pentatonique mineure': ['F', 'Ab', 'Bb', 'C', 'Eb'],
      'Gamme arabe (Maqam Hijaz)': ['F', 'Gb', 'A', 'Bb', 'C', 'Db', 'Eb'],
    },
    'F#': {
      'Majeure': ['F#', 'G#', 'A#', 'B', 'C#', 'D#', 'E'],
      'Mineure (Naturelle)': ['F#', 'G#', 'A', 'B', 'C#', 'D', 'E'],
      'Mineure harmonique': ['F#', 'G#', 'A', 'B', 'C#', 'D', 'E#'],
      'Mineure mélodique (montée)': ['F#', 'G#', 'A', 'B', 'C#', 'D#', 'E#'],
      'Pentatonique majeure': ['F#', 'G#', 'A#', 'C#', 'D#'],
      'Pentatonique mineure': ['F#', 'A', 'B', 'C#', 'D'],
      'Gamme arabe (Maqam Hijaz)': ['F#', 'G', 'A#', 'B', 'C#', 'D', 'E'],
    },
    'G': {
      'Majeure': ['G', 'A', 'B', 'C', 'D', 'E', 'F#'],
      'Mineure (Naturelle)': ['G', 'A', 'Bb', 'C', 'D', 'Eb', 'F'],
      'Mineure harmonique': ['G', 'A', 'Bb', 'C', 'D', 'Eb', 'F#'],
      'Mineure mélodique (montée)': ['G', 'A', 'Bb', 'C', 'D', 'E', 'F#'],
      'Pentatonique majeure': ['G', 'A', 'B', 'D', 'E'],
      'Pentatonique mineure': ['G', 'Bb', 'C', 'D', 'F'],
      'Gamme arabe (Maqam Hijaz)': ['G', 'Ab', 'B', 'C', 'D', 'Eb', 'F'],
    },
    'G#': {
      'Majeure': ['G#', 'A#', 'C', 'C#', 'D#', 'F', 'F#'],
      'Mineure (Naturelle)': ['G#', 'A#', 'B', 'C#', 'D#', 'E', 'F#'],
      'Mineure harmonique': ['G#', 'A#', 'B', 'C#', 'D#', 'E', 'F##'],
      'Mineure mélodique (montée)': ['G#', 'A#', 'B', 'C#', 'D#', 'E#', 'F##'],
      'Pentatonique majeure': ['G#', 'A#', 'C', 'D#', 'F'],
      'Pentatonique mineure': ['G#', 'B', 'C#', 'D#', 'E'],
      'Gamme arabe (Maqam Hijaz)': ['G#', 'A', 'C', 'C#', 'D#', 'E', 'F'],
    },
    'A': {
      'Majeure': ['A', 'B', 'C#', 'D', 'E', 'F#', 'G#'],
      'Mineure (Naturelle)': ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
      'Mineure harmonique': ['A', 'B', 'C', 'D', 'E', 'F', 'G#'],
      'Mineure mélodique (montée)': ['A', 'B', 'C', 'D', 'E', 'F#', 'G#'],
      'Pentatonique majeure': ['A', 'B', 'C#', 'E', 'F#'],
      'Pentatonique mineure': ['A', 'C', 'D', 'E', 'G'],
      'Gamme arabe (Maqam Hijaz)': ['A', 'Bb', 'C#', 'D', 'E', 'F', 'G'],
    },
    'A#': {
      'Majeure': ['A#', 'C', 'D', 'D#', 'F', 'G', 'G#'],
      'Mineure (Naturelle)': ['A#', 'C', 'C#', 'D#', 'F', 'F#', 'G#'],
      'Mineure harmonique': ['A#', 'C', 'C#', 'D#', 'F', 'F#', 'G'],
      'Mineure mélodique (montée)': ['A#', 'C', 'C#', 'D#', 'F', 'G', 'A'],
      'Pentatonique majeure': ['A#', 'C', 'D', 'F', 'G'],
      'Pentatonique mineure': ['A#', 'C#', 'D#', 'F', 'G#'],
      'Gamme arabe (Maqam Hijaz)': ['A#', 'B', 'D', 'D#', 'F', 'G', 'A'],
    },
    'B': {
      'Majeure': ['B', 'C#', 'D#', 'E', 'F#', 'G#', 'A#'],
      'Mineure (Naturelle)': ['B', 'C#', 'D', 'E', 'F#', 'G', 'A'],
      'Mineure harmonique': ['B', 'C#', 'D', 'E', 'F#', 'G', 'A#'],
      'Mineure mélodique (montée)': ['B', 'C#', 'D', 'E', 'F#', 'G#', 'A#'],
      'Pentatonique majeure': ['B', 'C#', 'D#', 'F#', 'G#'],
      'Pentatonique mineure': ['B', 'D', 'E', 'F#', 'A'],
      'Gamme arabe (Maqam Hijaz)': ['B', 'C', 'D#', 'E', 'F#', 'G', 'A'],
    },
  };

  Map<String, String> scaleDescriptions = {
    'Majeure': 'Mood: Joyeux, lumineux, optimiste.\nStyle: Pop classique ou hymnes (ex. "Sweet Caroline").',
    'Mineure (Naturelle)': 'Mood: Triste, mélancolique, introspectif.\nStyle: Ballades pop/rock (ex. "Hallelujah" de Leonard Cohen).',
    'Mineure harmonique': 'Mood: Dramatique, tendu, légèrement exotique.\nStyle: Musique classique baroque (ex. Bach) ou metal néoclassique.',
    'Mineure mélodique (montée)': 'Mood: Émotionnel, fluide, sophistiqué.\nStyle: Jazz (ex. improvisations bebop) ou romantisme classique (Chopin).',
    'Pentatonique majeure': 'Mood: Simple, ouvert, chaleureux.\nStyle: Folk ou rock (ex. "Sweet Home Alabama").',
    'Pentatonique mineure': 'Mood: Sombre, groovy, expressif.\nStyle: Blues ou rock (ex. solos de Jimi Hendrix).',
    'Gamme arabe (Maqam Hijaz)': 'Mood: Mystérieux, oriental, envoûtant.\nStyle: Musique moyen-orientale ou flamenco (ex. "Misirlou").',
  };

  // Met à jour les notes à afficher
  void updateNotes() {
    if (selectedNote != null && selectedScale != null) {
      setState(() {
        notesDisplay = scaleNotes[selectedNote]?[selectedScale]?.join(', ') ?? '';
      });
    }
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
              'SCALE LIST',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/scale_logo.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Image en haut
            Image.asset(
              'assets/scale_list_image.png',
              height: 300,
            ),

            // Choix de la note
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedNote,
                  isExpanded: false, // ne pas forcer l'expansion
                  onChanged: (String? newNote) {
                    setState(() {
                      selectedNote = newNote;
                    });
                  },
                  dropdownColor: Colors.orange, // Couleur de fond du menu déroulant
                  style: TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.bold), // Couleur du texte des éléments du menu
                  items: ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
                      .map((note) => DropdownMenuItem<String>(
                    value: note,
                    child: Text(note),
                  ))
                      .toList(),
                ),

                // Choix de la gamme
                DropdownButton<String>(
                  value: selectedScale,
                  isExpanded: false, // ne pas forcer l'expansion
                  onChanged: (String? newScale) {
                    setState(() {
                      selectedScale = newScale;
                    });
                  },
                  dropdownColor: Colors.orange, // Couleur de fond du menu déroulant
                  style: TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.bold), // Couleur du texte des éléments du menu
                  items: [
                    'Majeure',
                    'Mineure (Naturelle)',
                    'Mineure harmonique',
                    'Mineure mélodique (montée)',
                    'Pentatonique majeure',
                    'Pentatonique mineure',
                    'Gamme arabe (Maqam Hijaz)',
                  ]
                      .map((scale) => DropdownMenuItem<String>(
                    value: scale,
                    child: Text(scale),
                  ))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 20), // Espacement entre les Dropdowns et le bouton

            // Bouton "Voir les notes"
            Align(
              alignment: Alignment.center,
              child : ElevatedButton(
                onPressed: (selectedNote != null && selectedScale != null)
                    ? updateNotes
                    : null,
                child: Text('Voir les notes', style: TextStyle(fontFamily: 'Montserrat', fontSize: 30, color: Colors.orange)),
              ),
            ),
            SizedBox(height: 20),

            // Affichage des notes de la gamme après appui sur le bouton
            if (notesDisplay.isNotEmpty)
              Text(
                  '$notesDisplay',
                  style: TextStyle(fontSize: 25, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 30),

            // Zone de texte dynamique qui changera en fonction du choix
            if (selectedScale != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child : Text(
                  '${scaleDescriptions[selectedScale]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}