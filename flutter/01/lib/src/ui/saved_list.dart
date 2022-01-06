import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter01/src/bloc/word_bloc.dart';

class SavedList extends StatefulWidget {
  // const SaveList({Key? key}) : super(key: key);

  // SavedList({required this.saved});

  // final Set<WordPair>  saved;

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("saveList"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder(
        stream: wordBloc.data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Set<WordPair> saved = Set<WordPair>();

          if (snapshot.hasData)
            saved.addAll(snapshot.data.saved);
          else
            wordBloc.currentData;

          return ListView.builder(
              itemCount: saved.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return const Divider();
                }
                var realIndex = index ~/ 2;

                return _buildRow(saved.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          wordBloc.wordEventBloc.wordEventSink.add(WordEvent(
              flag: WordEventFlag.SAVE_REMOVED_EORD_EVENT, wordPair: pair));
        });
      },
    );
  }
}
