import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './listitem_event.dart';
import './listitem_state.dart';

class ListItemBloc extends Bloc<MutaListItem, ListItemState> {
  ListItemBloc() : super(ListItemState(Set<WordPair>()));

  @override
  Stream<ListItemState> mapEventToState(MutaListItem event) async* {
    if (event is AddListItem) {
      yield* addListItem(event);
    } else if (event is RemoveListItem) {
      yield* removeListItem(event);
    }
  }

  Stream<ListItemState> addListItem(AddListItem event) async* {
    var selectedItem = [...state.selectedItem].toSet();
    selectedItem.add(event.item);
    final newState = ListItemState(selectedItem);
    yield newState;
  }

  Stream<ListItemState> removeListItem(RemoveListItem event) async* {
    var selectedItem = [...state.selectedItem].toSet();
    selectedItem.remove(event.item);
    final newState = ListItemState(selectedItem);
    yield newState;
  }
}
