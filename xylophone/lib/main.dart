import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Note> _notes = [
    Note(color: Colors.red, soundNumber: 1, name: 'C'),
    Note(color: Colors.orange, soundNumber: 2, name: 'D'),
    Note(color: Colors.yellow, soundNumber: 3, name: 'E'),
    Note(color: Colors.green, soundNumber: 4, name: 'F'),
    Note(color: Colors.teal, soundNumber: 5, name: 'G'),
    Note(color: Colors.blue, soundNumber: 6, name: 'A'),
    Note(color: Colors.purple, soundNumber: 7, name: 'B'),
  ];

  Future<void> _playSound(int soundNumber) async {
    try {
      await _audioPlayer.stop(); // Stop any currently playing sound
      await _audioPlayer.play(AssetSource('note$soundNumber.wav'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Widget _buildKey(Note note, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: note.color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => _playSound(note.soundNumber),
            child: Center(
              child: Text(
                note.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Xylophone'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.music_note,
                size: 50,
                color: Colors.white54,
              ),
              SizedBox(height: 10),
              Text(
                'Tap the keys to play!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < _notes.length; i++)
                      _buildKey(_notes[i], i),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Note {
  final Color color;
  final int soundNumber;
  final String name;

  const Note({
    required this.color,
    required this.soundNumber,
    required this.name,
  });
}