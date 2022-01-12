import 'package:english_words/english_words.dart';

class Words {
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
