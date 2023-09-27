import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

// Your CardItem model class here

class CardsSortedByNameScreen extends StatefulWidget {
  @override
  _CardsSortedByNameScreenState createState() =>
      _CardsSortedByNameScreenState();
}

class _CardsSortedByNameScreenState extends State<CardsSortedByNameScreen> {
  final dbHelper = CardItemDao(); // Initialize your dbHelper

  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsSortedByName();
  }

  Future<void> _fetchCardsSortedByName() async {
    final cards = await dbHelper.getCardsSortedByName();
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Sorted by Name'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
            // Add more details here if needed
          );
        },
      ),
    );
  }
}
