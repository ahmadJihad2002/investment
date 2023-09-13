 import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class Util {
  static Future<void> whatsapp({required String phoneNumber, required String message }) async {



    var androidUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    var iosUrl =
        "https://wa.me/$phoneNumber?text=${Uri.parse( message)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      // EasyLoading.showError('WhatsApp is not installed.');
    }
  }
}
