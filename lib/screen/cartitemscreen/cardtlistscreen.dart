import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../dtabasehelper.dart';
import '../../modal/entity/card.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final dbHelper = CardItemDao(); // Replace with your database helper

  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsBetweenDates();
  }

  Future<void> _fetchCardsBetweenDates() async {
    final startDate = DateTime(2023, 1, 1); // Replace with your start date
    final endDate = DateTime(2023, 12, 31); // Replace with your end date

    final cards = await dbHelper.findCardsCreatedBetweenDates(startDate, endDate);

    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}