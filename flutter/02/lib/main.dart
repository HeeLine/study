import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter02/src/bloc/words/words.dart';
import 'package:flutter02/src/model/words.dart';
import 'package:flutter02/src/ui/random_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  return runApp(
      BlocProvider<WordsBloc>(
        create: (context) {
          Words word = Words();
          return WordsBloc(WordsMakeRandom(word,10));
        },
        child: MyApp(),
      ),
  );

}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RandomList()
    );
  }
}
