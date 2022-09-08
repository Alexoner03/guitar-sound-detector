import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/AuthProvider.dart';
import 'package:tflite_audio/tflite_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String _sound = "Presiona para grabar";
    bool _recording = false;
    late Stream<Map<dynamic, dynamic>> result;

    @override
    void initState() {
      super.initState();
      TfliteAudio.loadModel(
          model: 'assets/soundclassifier_with_metadata.tflite',
          label: 'assets/labels.txt',
          numThreads: 1,
          isAsset: true,           inputType: 'rawAudio',

      );
    }

    void _recorder() {
      String recognition = "";
      if (!_recording) {
        setState(() => _recording = true);

        result = TfliteAudio.startAudioRecognition(
          numOfInferences: 1,
          sampleRate: 44100,
          audioLength: 44032,
          bufferSize: 22016,
        );
        result.listen((event) {
          print(event.toString());
        }).onDone(() => {
          _stop()
        });
      }
    }

    void _stop() {
      TfliteAudio.stopAudioRecognition();
      setState(() => _recording = false);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Reconocer si / no",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: _recorder,
                color: _recording ? Colors.grey : Colors.pink,
                textColor: Colors.white,
                child: const Icon(Icons.mic, size: 60),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(25),
              ),
              Text(
                _sound,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      );
    }
}
