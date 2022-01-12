import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter02/src/model/words.dart';
import 'package:equatable/equatable.dart';

abstract class WordsState extends Equatable {
  WordsState();

  var words;

  @override
  List<Object> get props => [];
}

class WordsLoading extends WordsState {

  @override
  final Words words;

  WordsLoading(this.words);
}

class WordsReload extends WordsState {

  @override
  final Words words;

  WordsReload(this.words);
}


class WordsMakeRandom extends WordsState {

  @override
  final Words words;
  final int count;

  WordsMakeRandom(this.words, this.count) {
    words.makeRandomWord(count);
  }

  @override
  List<Object> get props {
    return [words];
  }

  @override
  String toString() => 'WordsMakeRandom { words: $words , count: $count }';
}

class WordsAddSave extends WordsState {

  @override
  final Words words;
  final WordPair pair;

  WordsAddSave(this.words, this.pair) {
    words.addSave(pair);
  }

  @override
  List<Object> get props {
    return [words];
  }

  @override
  String toString() => 'WordsAddSave { words: $words , WordPair: $pair }';
}

class WordsRemoveSave extends WordsState {

  @override
  final Words words;
  final WordPair pair;

  WordsRemoveSave(this.words, this.pair) {
    words.removeSave(pair);
  }

  @override
  List<Object> get props {
    return [words];
  }

  @override
  String toString() => 'WordsRemoveSave { words: $words , WordPair: $pair }';
}
