import 'package:guitar/models/Question.dart';
import 'package:guitar/models/QuestionType.dart';

import 'package:guitar/models/Answer.dart';

class QAS {
  static List<Question> questions = [
    Question("Dale play para escuchar el sonido e identifica que acorde es?", "1_1", QuestionType.audio, [
    ])
  ];

  static List<Question> getQuestions(int level) {
    switch(level){
      case 1: 
        return [
          Question("Dale play para escuchar el sonido e identifica que acorde es? 1", "1_1", QuestionType.audio,
              [
                Answer("Do", true),
                Answer("Re", false),
                Answer("Mi", false),
              ]
          ),
          Question("Dale play para escuchar el sonido e identifica que cuerda al aire es? 1", "1_2", QuestionType.audio,
              [
                Answer("Fa", false),
                Answer("Do", false),
                Answer("Sol", true),
              ]
          ),
          Question("Dale play para escuchar el sonido e identifica que acorde es? 2", "1_3", QuestionType.audio,
              [
                Answer("Mi", false),
                Answer("Si", true),
                Answer("Re", false),
              ]
          ),
          Question("Dale play para escuchar el sonido e identifica que cuerda al aire es? 2", "1_4", QuestionType.audio,
              [
                Answer("Mi", false),
                Answer("Si", true),
                Answer("Do", false),
              ]
          ),
        ];
      case 2: 
        return [
          Question("Reconoce qué cuerdas al aire está tocando 1", "2_1", QuestionType.audio,
              [
                Answer("La Si", true),
                Answer("Mi Si", false),
                Answer("Sol Re", false),
              ]
          ),
          Question("Reconoce los acordes 1", "2_2", QuestionType.image,
              [
                Answer("Do Re", false),
                Answer("Mi Fa", false),
                Answer("Sol Si", true),
              ]
          ),
          Question("Reconoce los acordes 2", "2_3", QuestionType.image,
              [
                Answer("Fa Sol", false),
                Answer("Re Do", true),
                Answer("Mi Re", false),
              ]
          ),
          Question("Reconoce qué cuerdas al aire está tocando 2", "2_4", QuestionType.audio,
              [
                Answer("La Si Mi", false),
                Answer("Mi Si Sol", true),
                Answer("Sol Re Sol", false),
              ]
          ),
        ];
      case 3: 
        return [
          Question("Reconoce que acordes y cuerdas al aire está sonando", "3_1", QuestionType.audio,
              [
                Answer("Acorde DO, Cuerda SOL, Acorde LA", true),
                Answer("Acorde RE, Cuerda MI, Acorde SI", false),
                Answer("Acorde SOL, Cuerda LA, Acorde FA", false),
              ]
          ),
          Question("¿Los siguientes acordes son los mismos? ¿Qué acorde(s) son/es?", "3_2", QuestionType.audio,
              [
                Answer("Sí son los mismos, Acorde SOL", false),
                Answer("No son los mismos, Acordes FA y SOL", false),
                Answer("Sí son los mismos, Acorde RE", true),
              ]
          ),
        ];
      default:
        return [];
    }
  }
}