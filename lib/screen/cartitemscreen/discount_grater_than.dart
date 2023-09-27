import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

// Your CardItem model class here

class CardsWithDiscountGreaterThanScreen extends StatefulWidget {
  @override
  _CardsWithDiscountGreaterThanScreenState createState() =>
      _CardsWithDiscountGreaterThanScreenState();
}

class _CardsWithDiscountGreaterThanScreenState
    extends State<CardsWithDiscountGreaterThanScreen> {
  final dbHelper = CardItemDao(); // Initialize your dbHelper

  List<CardItem> _cards = [];
  double _discountThreshold = 100; // Set your desired discount threshold

  @override
  void initState() {
    super.initState();
    _fetchCardsWithDiscountGreaterThan();
  }

  Future<void> _fetchCardsWithDiscountGreaterThan() async {
    final cards =
    await dbHelper.getCardsWithDiscountGreaterThan(_discountThreshold);
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards with Discount > $_discountThreshold'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Discount: ${cardItem.discount.toStringAsFixed(2)}'),
            // Add more details here if needed
          );
        },
      ),
    );
  }
}
