import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:startup_namer/pages/favorite_words_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      builder: (context) => MyFavoriteWordsPage(favorites: _favorites),
    ));
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
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}
