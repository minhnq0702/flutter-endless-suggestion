import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MutaListItem {}

class AddListItem extends MutaListItem {
  final WordPair item;

  AddListItem({@required this.item});
}

class RemoveListItem extends MutaListItem {
  final WordPair item;

  RemoveListItem({@required this.item});
}
