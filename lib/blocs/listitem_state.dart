import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';

class ListItemState extends Equatable {
  final Set<WordPair> selectedItem;

  const ListItemState(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}
