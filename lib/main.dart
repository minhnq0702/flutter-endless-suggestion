import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_endless_suggestion/blocs/listitem_state.dart';
import 'blocs/listitem_bloc.dart';
import 'blocs/listitem_event.dart';
import 'saved.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print('onChange ${change.currentState.hashCode} - ${change.nextState.hashCode}');
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition ${transition.currentState.hashCode} - ${transition.nextState.hashCode}');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListItemBloc(),
      child: MaterialApp(
        title: 'Startup Name Generator',
        home: Scaffold(
          body: RandomWords(),
        ),
        theme: ThemeData(
          primaryColor: Colors.purple,
          dividerColor: Colors.red,
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  void initState() {
    super.initState();
    // listItemBloc = BlocProvider.of<ListItemBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    // listItemBloc.close();
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<SavedSuggestion>(
        builder: (context) {
          return BlocProvider.value(
            value: BlocProvider.of<ListItemBloc>(context),
            child: SavedSuggestion(),
          );
        },
      ),
    );
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
      body: SelectionList(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("this is app bar title"),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.list),
  //           onPressed: _pushSaved,
  //         )
  //       ],
  //     ),
  //     body: _buildSuggestion(),
  //   );
  // }
}

class SelectionList extends StatelessWidget {
  // ListItemBloc listItemBloc;
  final _suggestions = <WordPair>[];

  Widget _buildRow(WordPair word, int index, context) {
    // var alredySaved = BlocProvider.of<ListItemBloc>(context).state.selectedItem.contains(word);
    // return ListTile(
    //   title: Text(
    //     word.asPascalCase,
    //     style: TextStyle(fontSize: 18.0),
    //   ),
    //   subtitle: Text("MINH NE $index"),
    //   leading: Icon(Icons.flight_land),
    //   trailing: Icon(
    //     alredySaved ? Icons.favorite : Icons.favorite_border,
    //     color: alredySaved ? Colors.red : null,
    //   ),
    //   onTap: () {
    //     if (alredySaved) {
    //       BlocProvider.of<ListItemBloc>(context).add(RemoveListItem(item: word));
    //     } else {
    //       BlocProvider.of<ListItemBloc>(context).add(AddListItem(item: word));
    //     }
    //   },
    // );

    return BlocBuilder<ListItemBloc, ListItemState>(builder: (context, state) {
      return ListTile(
        title: Text(
          word.asPascalCase,
          style: TextStyle(fontSize: 18.0),
        ),
        subtitle: Text("${BlocProvider.of<ListItemBloc>(context).state.selectedItem.contains(word)}"),
        leading: Icon(Icons.flight_land),
        trailing: Icon(
          BlocProvider.of<ListItemBloc>(context).state.selectedItem.contains(word)
              ? Icons.favorite
              : Icons.favorite_border,
          color: BlocProvider.of<ListItemBloc>(context).state.selectedItem.contains(word) ? Colors.red : null,
        ),
        onTap: () {
          if (BlocProvider.of<ListItemBloc>(context).state.selectedItem.contains(word)) {
            BlocProvider.of<ListItemBloc>(context).add(RemoveListItem(item: word));
          } else {
            BlocProvider.of<ListItemBloc>(context).add(AddListItem(item: word));
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index], index, context);
      },
    );
  }
}
