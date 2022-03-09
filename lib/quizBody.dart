import 'package:flutter/material.dart';

import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

class QuizBody extends StatefulWidget {
  const QuizBody({Key? key}) : super(key: key);

  @override
  _QuizBodyState createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  List<Icon> scoreKeeper = [];

  int questionNumber = 0;
  int correct = 0, wrong = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        correct++;
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        wrong++;
      }

      quizBrain.nextQuestion();
    });
  }

  void scoreBoard() {
    if (quizBrain.questionNumber == quizBrain.questionBankLength() - 1) {
      Alert(
        context: context,
        title:
            'Correct Answers : $correct\nWrong Answers : $wrong\nScore:$correct/ ${quizBrain.questionBankLength() - 1}',
      ).show();
      quizBrain.questionNumber = 0;
      scoreKeeper.clear();
      correct = 0;
      wrong = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  checkAnswer(true);
                  scoreBoard();
                },
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.green,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  checkAnswer(false);
                  scoreBoard();
                },
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.red,
              ),
            ),
          ),
          Flexible(
            flex: 0,
            child: Center(
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
