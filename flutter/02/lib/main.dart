import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter02/src/ui/random_list.dart';

void main() =>  runApp(MyApp());

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
