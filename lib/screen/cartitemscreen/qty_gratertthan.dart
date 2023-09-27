import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../dtabasehelper.dart';
import '../../modal/entity/card.dart';

// Your CardItem model class here

class CardsWithQuantityGreaterThanScreen extends StatefulWidget {
  @override
  _CardsWithQuantityGreaterThanScreenState createState() =>
      _CardsWithQuantityGreaterThanScreenState();
}

class _CardsWithQuantityGreaterThanScreenState
    extends State<CardsWithQuantityGreaterThanScreen> {
  final dbHelper = CardItemDao(); // Initialize your dbHelper

  List<CardItem> _cards = [];
  int _quantityThreshold = 50; // Set your desired quantity threshold

  @override
  void initState() {
    super.initState();
    _fetchCardsWithQuantityGreaterThan();
  }

  Future<void> _fetchCardsWithQuantityGreaterThan() async {
    final cards =
    await dbHelper.getCardsWithQuantityGreaterThan(_quantityThreshold);
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards with Quantity > $_quantityThreshold'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Quantity: ${cardItem.qty.toString()}'),
            // Add more details here if needed
          );
        },
      ),
    );
  }
}
