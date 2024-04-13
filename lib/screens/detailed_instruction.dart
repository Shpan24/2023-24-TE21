// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailedInstructionPage extends StatelessWidget {
  final String title;
  final List<String> instructions;
  final String youtubeVideoId;

  DetailedInstructionPage({
    required this.title,
    required this.instructions,
    required this.youtubeVideoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 57, 239, 0.911),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Title(
            color: Colors.white,
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(instructions[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: youtubeVideoId,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _speakInstructions(instructions);
        },
        child: Icon(Icons.volume_up),
      ),
    );
  }

  Future<void> _speakInstructions(List<String> instructions) async {
    FlutterTts flutterTts = FlutterTts();

    // Set the language to English
    await flutterTts.setLanguage("en-US");

    // Set the voice gender to female
    await flutterTts.setVoice({"gender": "female"});

    for (var instruction in instructions) {
      await flutterTts
          .awaitSpeakCompletion(true); // Wait for previous speech to finish
      await flutterTts.speak(instruction);
      await Future.delayed(
          Duration(seconds: 1)); // Pause for 1 second after each instruction
    }
  }
}
