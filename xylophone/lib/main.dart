import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone',
      theme: ThemeData.dark(),
      home: XylophoneScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class XylophoneScreen extends StatefulWidget {
  @override
  _XylophoneScreenState createState() => _XylophoneScreenState();
}

class _XylophoneScreenState extends State<XylophoneScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: 'assets/');
  final List<Note> _notes = [
    Note(color: Colors.red, soundNumber: 1, name: 'C'),
    Note(color: Colors.orange, soundNumber: 2, name: 'D'),
    Note(color: Colors.yellow, soundNumber: 3, name: 'E'),
    Note(color: Colors.green, soundNumber: 4, name: 'F'),
    Note(color: Colors.teal, soundNumber: 5, name: 'G'),
    Note(color: Colors.blue, soundNumber: 6, name: 'A'),
    Note(color: Colors.purple, soundNumber: 7, name: 'B'),
  ];

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _preloadSounds();
  }

  Future<void> _preloadSounds() async {
    for (final note in _notes) {
      await _audioCache.load('note${note.soundNumber}.wav');
    }
  }

  Future<void> _playSound(int soundNumber) async {
    if (_isPlaying) return;
    
    setState(() {
      _isPlaying = true;
    });

    try {
      await _audioCache.play('note$soundNumber.wav');
    } catch (e) {
      print('Error playing sound: $e');
    } finally {
      setState(() {
        _isPlaying = false;
      });
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Xylophone'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.music_note,
                      size: 50,
                      color: Colors.white54,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the keys to play!',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _notes.length; i++)
                    _buildKey(_notes[i], i),
                ],
              ),
            ),
            if (_isPlaying)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
          ],
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