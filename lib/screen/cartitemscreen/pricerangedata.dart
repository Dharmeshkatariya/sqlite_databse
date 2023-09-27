import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

// Your CardItem model class here

class CardsInPriceRangeScreen extends StatefulWidget {
  @override
  _CardsInPriceRangeScreenState createState() =>
      _CardsInPriceRangeScreenState();
}

class _CardsInPriceRangeScreenState extends State<CardsInPriceRangeScreen> {
  final dbHelper = CardItemDao(); // Initialize your dbHelper

  List<CardItem> _cards = [];
  double _minPrice = 10; // Set your desired minimum price
  double _maxPrice = 7000; // Set your desired maximum price

  @override
  void initState() {
    super.initState();
    _fetchCardsInPriceRange();
  }

  Future<void> _fetchCardsInPriceRange() async {
    final cards = await dbHelper.getCardsInPriceRange(_minPrice, _maxPrice);
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards in Price Range'),
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
