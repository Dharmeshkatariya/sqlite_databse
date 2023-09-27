import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class LatestItemsScreen extends StatefulWidget {
  @override
  _LatestItemsScreenState createState() => _LatestItemsScreenState();
}

class _LatestItemsScreenState extends State<LatestItemsScreen> {
  List<CardItem> _latestItems = [];

  @override
  void initState() {
    super.initState();
    _fetchLatestItems();
  }

  Future<void> _fetchLatestItems() async {
    var helper = CardItemDao();
    final latestItems = await helper.getLatestItems(2); // Replace 10 with the number of latest items you want to fetch
    setState(() {
      _latestItems = latestItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest Items'),
      ),
      body: ListView.builder(
        itemCount: _latestItems.length,
        itemBuilder: (context, index) {
          final cardItem = _latestItems[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
            // You can display more card details here as needed.
          );
        },
      ),
    );
  }
}
