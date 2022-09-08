import 'package:guitar/models/QuestionType.dart';

import 'Answer.dart';

class Question {
  final String name;
  final String asset;
  final QuestionType type;
  final List<Answer> answers;

  Question(this.name, this.asset, this.type, this.answers);
}