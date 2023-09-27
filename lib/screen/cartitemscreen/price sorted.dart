import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class CardsSortedByPriceDescendingScreen extends StatefulWidget {
  @override
  _CardsSortedByPriceDescendingScreenState createState() => _CardsSortedByPriceDescendingScreenState();
}

class _CardsSortedByPriceDescendingScreenState extends State<CardsSortedByPriceDescendingScreen> {
  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsSortedByPriceDescending();
  }

  Future<void> _fetchCardsSortedByPriceDescending() async {
    var helper = CardItemDao();
    final cards = await helper .getCardsSortedByPriceDescending(); // Call your query method here
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Sorted by Price (Descending)'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
            // Add more card details here as needed.
          );
        },
      ),
    );
  }
}
