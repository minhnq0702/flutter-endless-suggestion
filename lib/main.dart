import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_endless_suggestion/saved.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        body: RandomWords(),
      ),
      theme: ThemeData(
        primaryColor: Colors.purple,
        dividerColor: Colors.red,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  Widget _buildSuggestion() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index], index);
      },
    );
  }

  Widget _buildRow(WordPair word, int index) {
    final alredySaved = _saved.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text("MINH NE $index"),
      leading: Icon(Icons.flight_land),
      trailing: Icon(
        alredySaved ? Icons.favorite : Icons.favorite_border,
        color: alredySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alredySaved) {
            _saved.remove(word);
          } else {
            _saved.add(word);
          }
        });
      },
    );
  }

  void _pushSaved() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    //   final tiles = _saved.map((WordPair pair) {
    //     return ListTile(
    //       title: Text(
    //         pair.asPascalCase,
    //         style: TextStyle(fontSize: 18.0),
    //       ),
    //     );
    //   });

    //   final divided = ListTile.divideTiles(
    //     context: context,
    //     tiles: tiles,
    //   ).toList();

    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Favorite Suggestion"),
    //     ),
    //     body: ListView(
    //       children: divided,
    //     ),
    //   );
    // }));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => SavedSuggestion(
              saved: _saved,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("this is app bar title"),
          actions: [
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved,
            )
          ],
        ),
        body: _buildSuggestion());
  }
}
