import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedSuggestion extends StatefulWidget {
  final Set<WordPair> saved;
  const SavedSuggestion({Key key, this.saved}) : super(key: key);

  @override
  _SavedSuggestionState createState() => _SavedSuggestionState();
}

class _SavedSuggestionState extends State<SavedSuggestion> {
  @override
  Widget build(BuildContext context) {
    final tiles = widget.saved.map((WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
        ),
      );
    });

    final divided = ListTile.divideTiles(
      tiles: tiles,
      context: context,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Suggestion"),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
