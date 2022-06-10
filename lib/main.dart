import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final _pageTitle = 'Startup Name Generator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _pageTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(_pageTitle),
          ),
          body: const Center(
            child: RandomWords(),
          ),
        ));
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

  Widget _generateListItem(BuildContext context, int index) {
    if (index.isOdd) return const Divider();
    if (index >= _suggestions.length) {
      _generateMore();
    }
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: _generateListItem,
    );
  }
}
