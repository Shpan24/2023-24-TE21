import 'package:flutter/material.dart';

class VoiceInstruction extends StatelessWidget {
  final String title;
  final List<String> instructions;
  final VoidCallback onPressed;

  VoiceInstruction({
    required this.title,
    required this.instructions,
    required this.onPressed,
    required ButtonStyle style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          trailing: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromRGBO(75, 57, 239, 0.911), // Text color
            ),
            child: Text("View"),
          ),
        ),
      ],
    );
  }
}
