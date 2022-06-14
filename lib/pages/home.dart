import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:startup_namer/pages/favorite_words.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _suggestions = <WordPair>[];
  final _favorites = <WordPair>[];

  void _generateMore() {
    _suggestions.addAll(generateWordPairs().take(10));
  }

  void _handleTap(WordPair word, bool alreadyFavorited) {
    final handler = alreadyFavorited ? _favorites.remove : _favorites.add;
    setState(() {
      handler(word);
    });
  }

  void _pushToFavoriteList() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FavoriteWords(favorites: _favorites),
    ));
  }

  Widget _generateListItem(BuildContext context, int index) {
    if (index.isOdd) return const Divider();
    if (index >= _suggestions.length) _generateMore();

    final word = _suggestions[index];
    final alreadyFavorited = _favorites.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        alreadyFavorited ? Icons.favorite : Icons.favorite_border,
        color: alreadyFavorited ? Colors.red : null,
        semanticLabel: alreadyFavorited ? 'Remove' : 'Save',
      ),
      onTap: () {
        _handleTap(word, alreadyFavorited);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushToFavoriteList,
            icon: const Icon(Icons.list),
            tooltip: 'Favorite list',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: _generateListItem,
      ),
    );
  }
}
