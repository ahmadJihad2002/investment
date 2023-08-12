import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

Widget defaultButton(
    {required function,
    required String text,
    double width = double.infinity,
    Color backgroundColor = Colors.blue,
    double radius = 3.0}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green, // Button background color
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Handle button press
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesome.whatsapp,
              // WhatsApp icon
              color: Colors.white, // Icon color
            ),
            SizedBox(width: 8),
            Text(
              'Chat on WhatsApp', // Button text
              style: TextStyle(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  // child: Container(
  //   width: width,
  //   decoration: BoxDecoration(
  //     color: backgroundColor,
  //     borderRadius: BorderRadius.circular(radius),
  //   ),
  //   alignment: Alignment.center,
  //   padding: const EdgeInsets.all(15),
  //   child: Text(
  //     text,
  //     style: TextStyle(color: Colors.white),
  //   ),
  // ),
  // );
}
