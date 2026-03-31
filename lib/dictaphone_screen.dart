import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'recording_screen.dart';
import 'dart:io'; // Pour manipuler les fichiers

class DictaphoneScreen extends StatefulWidget {
  final Function? onRecordingSaved; // Callback pour notifier l'autre écran
  const DictaphoneScreen({super.key, this.onRecordingSaved});

  @override
  _DictaphoneScreenState createState() => _DictaphoneScreenState();
}

class _DictaphoneScreenState extends State<DictaphoneScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _recorderFilePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    var micPermission = await Permission.microphone.request();
    if (micPermission.isGranted) {
      await _recorder.openRecorder();
    } else {
      print("Microphone permission denied");
    }
  }


  void _startRecording() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      _recorderFilePath = '${directory.path}/recording_$timestamp.aac';

      await _recorder.startRecorder(
        toFile: _recorderFilePath,
        codec: Codec.aacADTS,
      );

      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      //print("Error starting recording: $e");
    }
  }



  void _stopRecording() async {
    if (!_recorder.isRecording) {
      //print("Aucun enregistrement en cours.");
      return;
    }

    try {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      //print("Enregistrement arrêté !");
      _showSaveDialog();
    } catch (e) {
      //print("Erreur lors de l'arrêt de l'enregistrement: $e");
    }
  }


  void _showSaveDialog() {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Nommer l'enregistrement",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 25,
            ),
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nom de l\'enregistrement'),
          ),
          actions: [
            TextButton(
              child: Text(
                'Annuler',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                      'Enregistrer',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
              onPressed: () async {
                String newName = _controller.text.trim();
                if (newName.isNotEmpty && _recorderFilePath != null) {
                  final oldFile = File(_recorderFilePath!);
                  final directory = await getApplicationDocumentsDirectory();
                  final newFilePath = '${directory.path}/$newName.aac';

                  await oldFile.rename(newFilePath);

                  setState(() {
                    _recorderFilePath = newFilePath;
                  });

                  if (widget.onRecordingSaved != null) {
                    widget.onRecordingSaved!(); // Appelle le callback pour recharger la liste
                  }
                }
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
    _recorder.closeRecorder();
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
              'DICTAPHONE',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/dictaphone_logo.png',
              width: 50,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 110),
            Image.asset(
              'assets/dictaphone_image.png',
              width: 300,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Arrêter' : 'Enregistrer', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordingsPage()),
                );
              },
              child: Text('Voir les enregistrements', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}