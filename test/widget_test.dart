import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/main.dart';

void main() {
  testWidgets('Vérifie la présence des éléments principaux', (WidgetTester tester) async {
    // Monte l'application
    await tester.pumpWidget(const MTBoxApp());

    // Vérifie la présence du titre de l'application
    expect(find.text('MT BOX'), findsOneWidget);

    // Vérifie la présence du logo principal
    expect(find.byType(Image), findsWidgets);

    // Vérifie la présence des boutons de fonctionnalités
    expect(find.text('DICTAPHONE'), findsOneWidget);
    expect(find.text('TAP BPM'), findsOneWidget);
    expect(find.text('MÉTRONOME'), findsOneWidget);

    // Vérifie la présence du bouton des paramètres
    expect(find.byType(IconButton), findsWidgets);
  });
}
