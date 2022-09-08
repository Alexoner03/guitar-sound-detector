import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Utils {
  static Future<void> showMyDialog(BuildContext context,String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showMyDialogSound(BuildContext context,double score, String pageBack) async {
    AudioCache audioCache = AudioCache();
    audioCache.play('clap.wav');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excelente!", style: TextStyle(fontSize: 25)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Countup(
                begin: 0,
                separator: ".",
                end: ((score * 100) / 1),
                precision: 2,
                suffix: "%",
                duration: const Duration(seconds: 1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 70,
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Regresar a la Lista'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, pageBack, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showMyDialogSoundTest(BuildContext context,double score, String pageBack, String message) async {
    AudioCache audioCache = AudioCache();
    audioCache.play('clap.wav');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          title: const Text("Excelente!", style: TextStyle(fontSize: 25)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(message),
              Countup(
                begin: 0,
                separator: ".",
                end: score,
                precision: 2,
                suffix: "%",
                duration: const Duration(seconds: 1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 70,
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Regresar a la Lista'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, pageBack, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

}