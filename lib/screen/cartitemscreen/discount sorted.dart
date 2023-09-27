import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class CardsSortedByQuantityAscendingScreen extends StatefulWidget {
  @override
  _CardsSortedByQuantityAscendingScreenState createState() => _CardsSortedByQuantityAscendingScreenState();
}

class _CardsSortedByQuantityAscendingScreenState extends State<CardsSortedByQuantityAscendingScreen> {
  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsSortedByQuantityAscending();
  }

  Future<void> _fetchCardsSortedByQuantityAscending() async {
    var helper  = CardItemDao();
    final cards = await helper .getCardsSortedByQuantityAscending();
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Sorted by Quantity (Ascending)'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Quantity: ${cardItem.qty}'),
            // Add more card details here as needed.
          );
        },
      ),
    );
  }
}
