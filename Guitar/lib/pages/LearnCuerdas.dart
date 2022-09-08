import 'package:flutter/material.dart';
import 'package:guitar/models/BackendModels.dart';
import 'package:guitar/pages/TestAudio.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';

class LearnCuerdas extends StatefulWidget {
  const LearnCuerdas({Key? key}) : super(key: key);

  @override
  State<LearnCuerdas> createState() => _LearnCuerdasState();
}

class _LearnCuerdasState extends State<LearnCuerdas> {
  late UserInfo _userInfo;

  @override
  Widget build(BuildContext context) {

    _userInfo = Provider.of<BackendProvider>(context).userInfo!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Cuerdas"),
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

  Widget _lista() {

    final cuerdas = [
      "A",
      "B",
      "D",
      "E",
      "Egrave",
      "G",
    ];

    return ListView.builder(
        itemCount: cuerdas.length,
        itemBuilder: (context, i) {

          Sound sound = getSound(cuerdas[i]);

          return ListTile(
            trailing: Icon(
              sound.passed ? Icons.check : Icons.close,
              color: sound.passed ? Colors.green : Colors.red,
            ),
            title: Text("Tocar " + cuerdas[i]),
            subtitle: Text("Ultima puntuación: " + ((sound.score * 100) / 1).toStringAsPrecision(3) + "%"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestAudio(1,cuerdas[i])));
            },
          );
        }
    );
  }
  
  Sound getSound(String note){
    return _userInfo
        .notes
        .firstWhere((element) => element.name == note);
  }
}

