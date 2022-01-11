import 'dart:async';
import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';

class WordBloc {

  final WordData _data = WordData();

  WordEventBloc wordEventBloc = WordEventBloc();

  final StreamController<WordData> _dataController = StreamController<WordData>.broadcast();

  Stream get data => _dataController.stream;

  get currentData => _dataController.sink.add(_data);

  WordBloc() {
    wordEventBloc._countEventSubject.stream.listen(_wordEventListen);
  }

  _wordEventListen(WordEvent event) {

    switch (event.flag) {
      case WordEventFlag.MAKE_RANDOM_WORD_EVENT:
        _data.makeRandomWord(10);
        _dataController.sink.add(_data);
        break;
      case WordEventFlag.SAVE_ADD_WORD_EVENT:
        _data.addSave(event.wordPair!);
        _dataController.sink.add(_data);
        break;
      case WordEventFlag.SAVE_REMOVED_EORD_EVENT:
        _data.removeSave(event.wordPair!);
        _dataController.sink.add(_data);
        break;
    }
  }

  dispose() {
    _dataController.close();
    wordEventBloc.dispose();
  }
}



class WordEventBloc {
  final StreamController<WordEvent> _countEventSubject = StreamController<WordEvent>();

  Sink<WordEvent> get wordEventSink => _countEventSubject.sink;

  dispose() {
    _countEventSubject.close();
  }
}

class WordData {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  List<WordPair> get suggestions => _suggestions;
  Set<WordPair> get saved => _saved;

  makeRandomWord(int count) {
    _suggestions.addAll(generateWordPairs().take(10));
  }

  addSave(WordPair pair) {
    _saved.add(pair);
  }

  removeSave(WordPair pair) {
    _saved.remove(pair);
  }
}

class WordEvent {
  final WordEventFlag flag;
  final WordPair? wordPair;

  WordEvent({required this.flag, this.wordPair});

}

enum WordEventFlag { MAKE_RANDOM_WORD_EVENT, SAVE_ADD_WORD_EVENT, SAVE_REMOVED_EORD_EVENT }

WordBloc wordBloc = WordBloc();
