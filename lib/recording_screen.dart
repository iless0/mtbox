import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';


class Recording {
  String filePath;
  String description;

  Recording({required this.filePath, this.description = ''});

  void setDescription(String newDescription) {
    description = newDescription;
  }
}

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({super.key});

  @override
  _RecordingsPageState createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Recording> _recordings = [];
  String? _playingFilePath;

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  // Charger les enregistrements
  Future<void> _loadRecordings() async {
    final directory = await getApplicationDocumentsDirectory();
    print('Dossier des enregistrements: ${directory.path}');
    final files = directory.listSync().whereType<File>().toList();

    setState(() {
      _recordings = files
          .where((file) => file.path.endsWith('.aac'))
          .map((file) => Recording(filePath: file.path, description: ''))
          .toList();
    });
  }

  // Jouer l'enregistrement
  Future<void> _playRecording(String filePath) async {
    if (_playingFilePath == filePath) {
      await _audioPlayer.stop();
      setState(() {
        _playingFilePath = null;
      });
    } else {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
      setState(() {
        _playingFilePath = filePath;
      });

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            _playingFilePath = null;
          });
        }
      });
    }
  }

  // Modifier la description d'un enregistrement
  void _editDescription(Recording recording) {
    TextEditingController _controller = TextEditingController(text: recording.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier la description', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Ajouter une description'),
          ),
          actions: [
            TextButton(
              child: Text('Annuler', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Enregistrer', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  recording.setDescription(_controller.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Renommer un enregistrement et mettre à jour la description
  void _renameRecording(Recording recording) {
    TextEditingController _controller = TextEditingController(text: recording.filePath.split('/').last.replaceAll('.aac', ''));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Renommer l'enregistrement", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nouveau nom'),
          ),
          actions: [
            TextButton(
              child: Text('Annuler', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Renommer', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final newFilePath = '${directory.path}/${_controller.text}.aac';
                await File(recording.filePath).rename(newFilePath);
                setState(() {
                  recording.filePath = newFilePath;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Supprimer un enregistrement
  void _deleteRecording(Recording recording) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Supprimer l'enregistrement ?", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Colors.black, fontFamily: 'Montserrat',)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Colors.red, fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
              onPressed: () async {
                await File(recording.filePath).delete();
                _loadRecordings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
              'RECORDS LISTE',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/dictaphone_image.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _recordings.length,
        itemBuilder: (context, index) {
          final recording = _recordings[index];
          final fileName = recording.filePath.split('/').last;

          return ListTile(
            title: Text(fileName, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            subtitle: Text(recording.description.isEmpty ? 'Pas de description' : recording.description, style: TextStyle(fontFamily: 'Montserrat', fontStyle: FontStyle.italic,)),
            leading: IconButton(
              icon: Icon(_playingFilePath == recording.filePath ? Icons.stop : Icons.play_arrow),
              onPressed: () => _playRecording(recording.filePath),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue), // Icône de modification du nom
                  onPressed: () => _renameRecording(recording),
                ),
                IconButton(
                  icon: Icon(Icons.description, color: Colors.orange), // Icône de description
                  onPressed: () => _editDescription(recording),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red), // Icône de suppression
                  onPressed: () => _deleteRecording(recording),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


