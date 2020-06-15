import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
//import 'question.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: QuizPage(),
              ),
            )));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> ScoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctans = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        ScoreKeeper = [];
      } else {
        if (userPickedAnswer == correctans) {
          print("user got it right");
          ScoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          print("user got it wrong");
          ScoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }

        quizBrain.nextQuestion();
      }
    });
  }

//  List <String> questions=[
//    'You can Lead A cow downstair but not upstair',
//    'Approximately one quater of juman bones are in the feet',
//    'A slug\'s blood is green'
//  ];
//

//
//  List <bool> answers=[false,true,true];
//
//  Question q1=Question(q:'You can Lead A cow downstair but not upstair',a:true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //true
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO:ADD A ROW AS A SCORE KEEPER//
        Row(
          children: ScoreKeeper,
        )
      ],
    );
  }
}
