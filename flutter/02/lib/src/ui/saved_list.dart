import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter02/src/bloc/words/words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedList extends StatefulWidget {
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
    final wordsBloc = BlocProvider.of<WordsBloc>(context);
    // return BlocBuilder<WordsBloc, WordsState>(
    return BlocBuilder(
        bloc: wordsBloc,
        builder: (BuildContext context, WordsState state) {

          Set<WordPair> saved = state.words.saved;

          if(saved.isNotEmpty) {
            return ListView.builder(
                itemCount: saved.length * 2, itemBuilder: (context, index) {
              if (index.isOdd) {
                return const Divider();
              }
              var realIndex = index ~/ 2;

              return _buildRow(saved.toList()[realIndex]);
            });
          }

          return CircularProgressIndicator();
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final wordsBloc = BlocProvider.of<WordsBloc>(context);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          RemovedSaveWord event = RemovedSaveWord(pair);
          wordsBloc.add(event);
        });
      },
    );
  }
}
