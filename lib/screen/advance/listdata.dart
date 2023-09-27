import 'package:flutter/material.dart';

import '../../common.dart';
import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class CardItemListScreen extends StatefulWidget {
  @override
  _CardItemListScreenState createState() => _CardItemListScreenState();
}

class _CardItemListScreenState extends State<CardItemListScreen> {
  final cardItems = <CardItem>[]; // Initialize with an empty list
  final cardItemDao = CardItemDao(); // Your DAO instance

  @override
  void initState() {
    super.initState();
    fetchCardItems();
  }

  // Fetch card items from the database
  Future<void> fetchCardItems() async {
    final items = await cardItemDao.findAllCards();
    setState(() {
      cardItems.clear();
      cardItems.addAll(items);
    });
  }

  // Insert new card items into the database and refresh the list
  Future<void> insertNewCardItems() async {
    final newCardItems = <CardItem>[
      // Create your new CardItem objects here
      CardItem(name: 'New Card 15555', id: Common().getRandomId()+12, desc: 'dh', price: 2, qty: 50, createdAt: DateTime.now(), discount: 50),
      CardItem(name: 'New Card tt1', id: Common().getRandomId()+555, desc: 'dtth', price: 21, qty: 450, createdAt: DateTime.now(), discount: 50),
      CardItem(name: 'New Card 125', id: Common().getRandomId()+454, desc: 'dh', price: 2, qty: 540, createdAt: DateTime.now(), discount: 50),

    ];

    await cardItemDao.insertAllCardItemsSimplicity(newCardItems);
    fetchCardItems(); // Refresh the list after inserting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Item List'),
      ),
      body: ListView.builder(
        itemCount: cardItems.length,
        itemBuilder: (context, index) {
          final cardItem = cardItems[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Price: ${cardItem.price.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: insertNewCardItems,
        child: Icon(Icons.add),
      ),
    );
  }
}
