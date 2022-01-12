import 'package:bloc/bloc.dart';
import 'package:flutter02/src/bloc/words/words_event.dart';
import 'package:flutter02/src/bloc/words/words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc(WordsState initialState) : super(initialState);

  @override
  Stream<WordsState> mapEventToState(WordsEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MakeRandomWords) {
      yield* _mapMakeRandomWordsToState(event);
    } else if (event is AddSaveWord) {
      yield* _mapAddSaveWordToState(event);
    } else if (event is RemovedSaveWord) {
      yield* _mapRemoveSaveWordToState(event);
    } else if (event is ReloadWords) {
      yield WordsReload(state.words);
    } else {
      yield WordsLoading(state.words);
    }
  }

  Stream<WordsState> _mapMakeRandomWordsToState(MakeRandomWords event) async* {
    try {
      yield WordsMakeRandom(state.words, event.count);
      yield WordsReload(state.words);
    } catch (_) {
      print("error");
      yield WordsLoading(state.words);
    }
  }

  Stream<WordsState> _mapAddSaveWordToState(AddSaveWord event) async* {
    try {
      yield WordsAddSave(state.words, event.pair);
    } catch (_) {
      print("error");
      yield WordsLoading(state.words);
    }
  }

  Stream<WordsState> _mapRemoveSaveWordToState(RemovedSaveWord event) async* {
    try {
      yield WordsRemoveSave(state.words, event.pair);
    } catch (_) {
      print("error");
      yield WordsLoading(state.words);
    }
  }
}
