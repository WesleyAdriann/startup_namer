import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyFavoriteWordsPage extends StatelessWidget {
  const MyFavoriteWordsPage({Key? key, required this.favorites})
      : super(key: key);

  final List<WordPair> favorites;

  @override
  Widget build(BuildContext context) {
    final tiles = favorites.map(
      (pair) => ListTile(
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView(children: divided),
    );
  }
}
