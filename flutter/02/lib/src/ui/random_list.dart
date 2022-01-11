import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter02/src/ui/saved_list.dart';
import 'package:flutter02/src/bloc/word_bloc.dart';

class RandomList extends StatefulWidget {
  // const RandomList({Key? key}) : super(key: key);

  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("naming app"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print(wordBloc.data.first);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SavedList()));
                // wordBloc.wordEventBloc.wordEventSink.add(WordEvent(flag:  WordEventFlag.MAKE_RANDOM_WORD_EVENT,wordPair:  null));
              },
              icon: const Icon(Icons.list))
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder(
        stream: wordBloc.data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<WordPair> wordList = <WordPair>[];
          Set<WordPair> saved = Set<WordPair>();

          if (snapshot.hasData) {
            wordList = snapshot.data.suggestions;
            saved = snapshot.data.saved;
          } else {
            wordBloc.currentData;
          }

          if (snapshot.hasData) {
            if (wordList.isNotEmpty) {
              return ListView.builder(
                  itemCount: wordList.length * 2,
                  itemBuilder: (context, index) {
                    var realIndex = index ~/ 2;

                    if (index.isOdd) {
                      if (realIndex == wordList.length - 1) {
                        wordBloc.wordEventBloc.wordEventSink.add(WordEvent(
                            flag: WordEventFlag.MAKE_RANDOM_WORD_EVENT,
                            wordPair: null));
                        // _suggestions.addAll(generateWordPairs().take(10));
                      }
                      return const Divider();
                    }

                    WordPair pair = wordList[realIndex];
                    final bool alreadySaved = saved.contains(pair);
                    return _buildRow(pair, alreadySaved);
                  });
            }
          }
          wordBloc.wordEventBloc.wordEventSink.add(WordEvent(
              flag: WordEventFlag.MAKE_RANDOM_WORD_EVENT, wordPair: null));
          return CircularProgressIndicator();
        });
  }

  Widget _buildRow(WordPair pair, bool alreadySaved) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            wordBloc.wordEventBloc.wordEventSink.add(WordEvent(
                flag: WordEventFlag.SAVE_REMOVED_EORD_EVENT, wordPair: pair));
            // _saved.remove(pair);
          } else {
            wordBloc.wordEventBloc.wordEventSink.add(WordEvent(
                flag: WordEventFlag.SAVE_ADD_WORD_EVENT, wordPair: pair));
            // _saved.add(pair);
          }
        });
        // print(pair.asPascalCase);
      },
    );
  }
}
