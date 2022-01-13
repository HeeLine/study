import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter02/src/ui/saved_list.dart';
import 'package:flutter02/src/bloc/words/words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomList extends StatefulWidget {
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SavedList()));
              },
              icon: const Icon(Icons.list))
        ],
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

        List<WordPair> wordList = state.words.suggestions;
        Set<WordPair> saved = state.words.saved;

        if (wordList.isNotEmpty) {

          return ListView.builder(
              itemCount: wordList.length * 2,
              itemBuilder: (context, index) {
                var realIndex = index ~/ 2;

                if (index.isOdd) {
                  if (realIndex == wordList.length - 1) {
                    wordsBloc.add(const MakeRandomWords(10));
                    return const Divider();
                  }
                  else {
                    return const Divider();
                  }
                }

                WordPair pair = wordList[realIndex];
                final bool alreadySaved = saved.contains(pair);
                return _buildRow(pair, alreadySaved);
              });
        }

        wordsBloc.add(const MakeRandomWords(10));
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildRow(WordPair pair, bool alreadySaved) {
    final wordsBloc = BlocProvider.of<WordsBloc>(context);
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
            wordsBloc.add(RemovedSaveWord(pair));
          } else {
            wordsBloc.add(AddSaveWord(pair));
          }
        });
        // print(pair.asPascalCase);
      },
    );
  }

  Widget _lastRow() {
    final wordsBloc = BlocProvider.of<WordsBloc>(context);
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: Icon(Icons.star),
      ),
      onTap: () {
        wordsBloc.add(const MakeRandomWords(10));
      },
    );
  }
}
