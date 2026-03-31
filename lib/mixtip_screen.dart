import 'package:flutter/material.dart';

class MixTipPage extends StatelessWidget {
  const MixTipPage({super.key});

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
            SizedBox(width: 10),
            Text(
              'MIX TIPS',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/mixtip_logo.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Mixtip sur la compression et l\'équalisation :',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                ),
              ),
            ),
            _buildTipCard('Kick',
                'Boost d\'EQ :\n8 kHz : Click\n2.5 ou 4.5 kHz : Attaque\n50 - 80 Hz : Grave\n\nCoupe d\'EQ :\n150 - 350 Hz : Brouillon\n600 - 900 Hz : Carton / Ballon de Basket',
                'Attaque lente\nRelease rapide'),
            _buildTipCard('Snare',
                'Boost d\'EQ :\n8 kHz : Attaque\n2.5 - 3 kHz : "Crack"\n200 Hz : Grave\n\nCoupe d\'EQ :\n600 - 900 Hz : Carton / Nasillard',
                'Attaque lente\nRelease rapide'),
            _buildTipCard('Toms',
                'Boost d\'EQ :\n8 kHz : Attaque\n4.5 kHz : Attaque\n120 - 200 Hz : Grave (Rack Tom)\n70 - 90 Hz : Grave (Floor Tom)\n\nCoupe d\'EQ :\n150 - 350 Hz : Brouillon\n600 - 900 Hz : Carton / Ballon de Basket',
                'Attaque lente\nRelease rapide'),
            _buildTipCard('Overheads',
                'Boost d\'EQ :\nÀ partir de 12 kHz (Shelf) : Brillance\n\nCoupe d\'EQ :\nHPF à partir de 200 Hz ou plus\n400 à 700 Hz : Carton (réduit le son du kit)',
                'Attaque moyenne à lente\nRelease moyen à rapide'),
            _buildTipCard('Room',
                'Boost d\'EQ :\nEntre 5K et 8K Hz : Présence\nÀ partir de 80 Hz : Grave\n\nCoupe d\'EQ :\nEntre 150 et 350 Hz : Brouillon\nÀ partir de 8K Hz ou plus : Agressif',
                'Attaque rapide\nRelease rapide\nFortement compressé pour ramener l\'ambiance'),
            _buildTipCard('Basse',
                'Boost d\'EQ :\nEntre 2K et 2.5K Hz : Bruits de cordes et présence\nÀ partir de 1 kHz : Médium / Sortir du Mix\nEntre 50 et 80 Hz : Sub / Grave\n\nCoupe d\'EQ :\nEntre 350 et 700 Hz : Carton\nLPF au-dessus de 4K Hz',
                'Attaque moyenne\nRelease moyen'),
            _buildTipCard('Guitare (Clean)',
                'Boost d\'EQ :\nEntre 8K et 12K Hz : Brillance / Ouverture\nEntre 1K et 2K Hz : Aide à ressortir du Mix\n\nCoupe d\'EQ :\nEntre 250 et 600 Hz : Carton',
                'Attaque moyenne\nRelease moyen'),
            _buildTipCard('Guitare (Disto)',
                'Boost d\'EQ :\nEntre 5K et 8K Hz : Brillance / Ouverture\nÀ partir de 2.5K Hz : Agressivité\nÀ partir de 1.5K Hz : Aide à ressortir du Mix\n\nCoupe d\'EQ :\nHPF sous les fréquences entre 90 et 120Hz\nLPF au-dessus des fréquences entre 10 et 12KHz\nEntre 250 et 350 Hz : Brouillon',
                'Attaque moyenne\nRelease moyen'),
            _buildTipCard('Guitare acoustique',
                'Boost d\'EQ :\nEntre 5K et 8K Hz : Brillance / Ouverture\nÀ partir de 1 kHz : Médium / Corps\n\nCoupe d\'EQ :\nHPF sous 100Hz\nLPF au-dessus de 12KHz\nEntre 100 et 200 Hz : Brouillon',
                'Attaque rapide\nRelease rapide à moyen\nFortement compressé'),
            _buildTipCard('Voix',
                'Boost d\'EQ :\nEntre 12K et 14K Hz (Shelf) : Pour de l\'air\nÀ partir de 8K Hz : Clarté\nEntre 4K et 4.5K Hz : Intelligibilité\nEntre 1K et 2.5K Hz : Pour passer devant\n\nCoupe d\'EQ :\nHPF entre 80 et 200 Hz\n(80 Hz : Standard)\n(200 Hz : Voix Pop Moderne)',
                'Attaque rapide à moyenne\nRelease rapide\nFortement compressé\nAttaque plus lente : Débuts de mots accentués'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String eq, String compression) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Fréquences :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(eq, style: TextStyle(fontFamily: 'Montserrat')),
            SizedBox(height: 8),
            Text(
              'Compression :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(compression, style: TextStyle(fontFamily: 'Montserrat')),
          ],
        ),
      ),
    );
  }
}
