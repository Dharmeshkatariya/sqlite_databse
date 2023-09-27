import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_work_databse_dk/common.dart';

import '../../dtabasehelper.dart';
import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

// Define the CardItem class with properties matching your database schema

class AllCardAdded extends StatefulWidget {
  @override
  _AllCardAddedState createState() => _AllCardAddedState();
}

class _AllCardAddedState extends State<AllCardAdded> {
  final dbHelper = DatabaseHelper(); // Initialize your database helper
  final cardDao = CardItemDao(); // Initialize your CardItemDao

  List<CardItem> existingData = []; // List to store existing data

  @override
  void initState() {
    super.initState();
    // Fetch and populate the existing data when the screen loads
    _fetchExistingData();
  }

  Future<void> _fetchExistingData() async {
    final cards = await cardDao.findAllCards();
    setState(() {
      existingData = cards;
    });
  }

  Future<void> _insertNewData() async {
    // Create a list of new card items
    final List<CardItem> newCardItems = [
      CardItem(name: 'New Card 15555', id: Common().getRandomId()+2, desc: 'dh', price: 2, qty: 50, createdAt: DateTime.now(), discount: 50),
      CardItem(name: 'New Card tt1', id: Common().getRandomId()+5, desc: 'dtth', price: 21, qty: 450, createdAt: DateTime.now(), discount: 50),
      CardItem(name: 'New Card 125', id: Common().getRandomId()+454, desc: 'dh', price: 2, qty: 540, createdAt: DateTime.now(), discount: 50),
      // Add more new CardItem objects as needed
    ];

    // Insert the new card items
    await cardDao.insertAllCardItems(newCardItems);

    // Fetch and update the existing data after insertion
    await _fetchExistingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Items'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _insertNewData,
            child: Text('Insert New Data'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: existingData.length,
              itemBuilder: (context, index) {
                final card = existingData[index];
                return ListTile(
                  title: Text(card.name),
                  subtitle: Text(card.price.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
