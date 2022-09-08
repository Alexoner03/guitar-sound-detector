import 'package:flutter/material.dart';
import 'package:guitar/models/BackendModels.dart';
import 'package:guitar/pages/TestAudio.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';

class LearnAcordes extends StatefulWidget {
  const LearnAcordes({Key? key}) : super(key: key);

  @override
  State<LearnAcordes> createState() => _LearnAcordesState();
}

class _LearnAcordesState extends State<LearnAcordes> {
  late UserInfo _userInfo;

  @override
  Widget build(BuildContext context) {
    _userInfo = Provider.of<BackendProvider>(context).userInfo!;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Acordes"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: const Icon(
                    Icons.home,
                    size: 26.0,
                  ),
                )
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _lista()
    );
  }

  Widget _lista(){

    final acordes = [
      "Do",
      "Re",
      "Mi",
      "Fa",
      "Sol",
      "La",
      "Si",
    ];

    return ListView.builder(
        itemCount: acordes.length,
        itemBuilder: (context, i) {

          Sound sound = getSound(acordes[i]);

          return ListTile(
            trailing: Icon(
              sound.passed ? Icons.check : Icons.close,
              color: sound.passed ? Colors.green : Colors.red,
            ),
            title: Text("Tocar " + acordes[i]),
            subtitle: Text("Ultima puntuación: " + ((sound.score * 100) / 1).toStringAsPrecision(3) + "%"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestAudio(2,acordes[i])));
            },
          );
        }
    );
  }

  Sound getSound(String chord){
    return _userInfo
        .chords
        .firstWhere((element) => element.name == chord);
  }
}

