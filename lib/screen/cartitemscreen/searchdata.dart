import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/entity/card.dart';

import '../../modal/dao/carddao.dart';

class CardSearchScreen extends StatefulWidget {
  @override
  _CardSearchScreenState createState() => _CardSearchScreenState();
}

class _CardSearchScreenState extends State<CardSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<CardItem> _searchResults = [];

  void _performSearch(String query) async {
    final results = await CardItemDao().searchCards(query);

    setState(() {
      print(results);
      _searchResults = results;
      // esults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Cards',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Perform the search when the search button is pressed
                    _performSearch(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                // Create widgets to display the search results here
                return ListTile(
                  title: Text(result.name),
                  subtitle: Text(result.createdAt.toString()),
                  // You can display more card details as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
