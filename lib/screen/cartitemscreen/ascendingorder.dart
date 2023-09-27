import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class Soretdcardlistpagescreeen extends StatefulWidget {
  @override
  _SoretdcardlistpagescreeenState createState() => _SoretdcardlistpagescreeenState();
}

class _SoretdcardlistpagescreeenState extends State<Soretdcardlistpagescreeen> {
  List<CardItem> _cards = []; // List to store retrieved cards
  bool _isAscending = true; // Sort order flag, true for ascending, false for descending

  @override
  void initState() {
    super.initState();
    // Fetch and populate the card list when the page loads
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    final cardDao = CardItemDao(); // Initialize your CardItemDao

    // Fetch the cards from the database sorted by date
    final cards = await cardDao.getCardsSortedByDate(_isAscending);

    setState(() {
      _cards = cards;
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending; // Toggle the sort order
      _fetchCards(); // Fetch and update the card list with the new sort order
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
        actions: [
          IconButton(
            icon: Icon(_isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: _toggleSortOrder,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return ListTile(
            title: Text(card.name), // Replace with the appropriate card property
            subtitle: Text(card.desc), // Replace with the appropriate card property
            // Add more ListTile properties to display other card information
          );
        },
      ),
    );
  }
}