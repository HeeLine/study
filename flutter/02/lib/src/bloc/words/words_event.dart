import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class ReloadWords extends WordsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ReloadWords';
}

//MAKE_RANDOM_WORD_EVENT, SAVE_ADD_WORD_EVENT, SAVE_REMOVED_EORD_EVENT
class MakeRandomWords extends WordsEvent {
  final int count;
  const MakeRandomWords(this.count);

  @override
  List<Object> get props => [count];

  @override
  String toString() => 'MakeRandomWords { count: $count }';
}

class AddSaveWord extends WordsEvent {
  final WordPair pair;
  const AddSaveWord(this.pair);

  @override
  List<Object> get props => [pair];

  @override
  String toString() => 'AddSaveWord { WordPair: $pair }';
}

class RemovedSaveWord extends WordsEvent {
  final WordPair pair;
  const RemovedSaveWord(this.pair);

  @override
  List<Object> get props => [pair];

  @override
  String toString() => 'RemovedSaveWord { WordPair: $pair }';
}
