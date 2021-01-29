import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_endless_suggestion/blocs/listitem_bloc.dart';
import 'package:flutter_endless_suggestion/blocs/listitem_event.dart';

import 'blocs/listitem_state.dart';

class SavedSuggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListItemBloc, ListItemState>(
        builder: (context, listItemState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Suggestion"),
            ),
            body: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: listItemState != null
                    ? listItemState.selectedItem.map(
                        (WordPair pair) => ListTile(
                          title: Text(
                            pair.asPascalCase,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<ListItemBloc>(context).add(RemoveListItem(item: pair));
                            },
                          ),
                        ),
                      )
                    : [],
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
