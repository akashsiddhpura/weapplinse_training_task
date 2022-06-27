import 'package:flutter/material.dart';

class Searchbardemo extends StatefulWidget {
  const Searchbardemo({Key? key}) : super(key: key);

  @override
  State<Searchbardemo> createState() => _SearchbardemoState();
}

class _SearchbardemoState extends State<Searchbardemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search bar demo"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Mysearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class Mysearch extends SearchDelegate {
  List<String> searchResults = [
    'shoes',
    'cap',
    'JEANS',
    'T-shirt',
    'shirt',
    'saree'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;

              showResults(context);
            },
          );
        });
  }
}
