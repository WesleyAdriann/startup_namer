import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
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

class FavoriteWords extends StatelessWidget {
  const FavoriteWords({Key? key, required this.favorites}) : super(key: key);

  final List<WordPair> favorites;

  @override
  Widget build(BuildContext context) {
    final tiles = favorites.map(
      (pair) => ListTile(
          title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18))),
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
