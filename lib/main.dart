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

  void generateMore() {
    _suggestions.addAll(generateWordPairs().take(10));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index.isOdd) return const Divider();
        if (index >= _suggestions.length) {
          generateMore();
        }
        return ListTile(
            title: Text(
          _suggestions[index].asPascalCase,
          style: const TextStyle(fontSize: 18),
        ));
      },
    );
  }
}
