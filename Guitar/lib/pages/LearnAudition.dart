import 'package:flutter/material.dart';
import 'package:guitar/models/Question.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:guitar/utils/alert.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';
import 'package:guitar/models/BackendModels.dart';

import '../models/QuestionType.dart';

class LearnAudition extends StatefulWidget {
  final List<Question> questions;
  final int level;

  const LearnAudition({required this.questions, required this.level, Key? key})
      : super(key: key);

  @override
  State<LearnAudition> createState() => _LearnAuditionState();
}

class _LearnAuditionState extends State<LearnAudition> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List<int> values = [];
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    setState(() {
      values = widget.questions.map((e) => -1).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Memoria Auditiva nivel : " + widget.level.toString()),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: const Icon(
                    Icons.home,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stepper(
          steps: buildSteps(),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: [
                TextButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep < widget.questions.length - 1
                      ? 'Continuar'
                      : 'Finalizar'),
                ),
                _currentStep > 0
                    ? TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Regresar'),
                      )
                    : Container(),
              ],
            );
          },
          type: stepperType,
          physics: const ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue: () {continued(context);},
          onStepCancel: cancel,
        ));
  }

  List<Step> buildSteps() {
    return widget.questions.map((q) {
      int listIndex =
          widget.questions.indexWhere((element) => element.name == q.name);
      return Step(
          content: Column(
            children: [
              Text(q.name),
              q.type == QuestionType.image
                  ? Image(
                      image: AssetImage('assets/exam/${q.asset}.png'),
                      height: 250,
                    )
                  : MaterialButton(
                      onPressed: () async {
                        await playLocal(q.asset);
                      },
                      color: Colors.indigo,
                      textColor: Colors.white,
                      child: const Icon(Icons.play_arrow, size: 50),
                      shape: const CircleBorder(),
                    ),
              ...q.answers.map((a) {
                int nestedListIndex =
                    q.answers.indexWhere((element) => element.name == a.name);
                return ListTile(
                  title: Text(a.name),
                  leading: Radio(
                    value: nestedListIndex,
                    groupValue: values[listIndex],
                    onChanged: (value) {
                      setState(() {
                        values[listIndex] = value as int;
                      });
                    },
                  ),
                );
              })
            ],
          ),
          title: const Text(""));
    }).toList();
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued(BuildContext context) {
    _currentStep < widget.questions.length - 1
        ? setState(() => _currentStep += 1)
        : sendForm(context);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  playLocal(String path) async {
    await audioCache.play('exam/${path}.wav');
  }

  sendForm(BuildContext context) {
    UserInfo _userInfo = Provider.of<BackendProvider>(context,listen: false).userInfo!;

    final totals = {
      1 : 4,
      2 : 4,
      3 : 2
    };

    final mapper = ['one','two','three'];

    if(values.contains(-1)){
      Utils.showMyDialog(context, "Oopss", "Marque todas las opciones antes de continuar!");
      return;
    }

    int count = 0;
    int asserts = 0;
    List<int> errors = [];
    for(var val in values){
      final index = widget.questions[count].answers.indexWhere((element) => element.ok);

      if(index == val){
        asserts++;
      }else{
        errors.add(count + 1);
      }

      count++;
    }

    final score = (asserts * 100) / totals[widget.level]!;

    if(score < 75){
      Utils.showMyDialog(context, "Oopss", "Intentalo de nuevo, Errores => " + errors.toString());
      return;
    }
    else if(score < 100){
      Utils.showMyDialogSoundTest(context, score, '/examen', "Resolviste casi todo, Errores => "+ errors.toString());
    }
    else{
      Utils.showMyDialogSoundTest(context, score, '/examen', "Resolviste todo correctamente");
    }

    List<Test> tests = _userInfo.tests.map((e) {
      if(e.level == mapper[widget.level - 1]){
        e.score = score;
      }
      return e;
    }).toList();

    Provider.of<BackendProvider>(context,listen: false).updateTests(tests);

  }
}
