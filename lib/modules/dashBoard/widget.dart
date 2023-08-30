import 'package:flutter/material.dart';

class YesNoWidget extends StatelessWidget {
  final String question;
  final Function(bool) onAnswered;

  YesNoWidget({required this.question, required this.onAnswered});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => onAnswered(true),
              child: Text('Yes'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => onAnswered(false),
              child: Text('No'),
            ),
          ],
        ),
      ],
    );
  }
}
