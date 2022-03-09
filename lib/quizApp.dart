import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/quizBody.dart';


class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const QuizBody(),
    );
  }
}
