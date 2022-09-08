import 'package:flutter/material.dart';
import 'package:guitar/models/BackendModels.dart';
import 'LearnAudition.dart';
import 'package:guitar/models/QAS.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';

class SelectLevelAudition extends StatefulWidget {
  const SelectLevelAudition(
      {
        Key? key
      }
      ) : super(key: key);

  @override
  State<SelectLevelAudition> createState() => _SelectLevelAuditionState();
}

class _SelectLevelAuditionState extends State<SelectLevelAudition> {
  late UserInfo _userInfo;

  @override
  Widget build(BuildContext context) {

    _userInfo = Provider.of<BackendProvider>(context).userInfo!;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Selecciona un nivel"),
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

    final niveles = [
      "1",
      "2",
      "3",
    ];

    return ListView.builder(
        itemCount: niveles.length,
        itemBuilder: (context, i) {

          final result = getScore(int.parse(niveles[i]));

          return ListTile(
            trailing: Icon(
              result >= 75 ? Icons.check : Icons.close,
              color: result >= 75  ? Colors.green : Colors.red,
            ),
            title: Text("Nivel " + niveles[i]),
            subtitle: Text("Ultima puntuación: " + result.toStringAsPrecision(3) + "%"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LearnAudition(
                          questions : QAS.getQuestions(i+1),
                          level: i + 1,
                      )
                  )
              );
            },
          );
        }
    );
  }

  double getScore(int level){
    final total = {
      1 : 4,
      2 : 4,
      3 : 2
    };

    final mapper = ['one','two','three'];

    final test = _userInfo.tests.firstWhere((element) => element.level == mapper[level - 1]);

    return test.score;
  }
}

