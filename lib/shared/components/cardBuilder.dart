import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class CardBuilder extends StatelessWidget {
//   const CardBuilder({Key? key, required this.img}) : super(key: key);
//
//   final String img;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Text('nigga'),
//         ],
//       ),
//     );
//   }
// }

Widget cardBuilder() {
  return Card(
    child: Column(
      children: [
        Text('nigga'),
      ],
    ),
  );
}

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
  }

  return color;
}
