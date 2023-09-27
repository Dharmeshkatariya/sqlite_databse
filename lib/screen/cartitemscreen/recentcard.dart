import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../dtabasehelper.dart';
import '../../modal/entity/card.dart';

class RecentCardList extends StatefulWidget {
  @override
  _RecentCardListState createState() => _RecentCardListState();
}

class _RecentCardListState extends State<RecentCardList> {
  final cardItemDao = CardItemDao(); // Initialize your database helper

  List<CardItem> recentCards = [];

  @override
  void initState() {
    super.initState();
    _fetchRecentCards();
  }

  Future<void> _fetchRecentCards() async {
    final recentCards = await cardItemDao.fetchRecentCards();
    setState(() {
      this.recentCards = recentCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Cards'),
      ),
      body: ListView.builder(
        itemCount: recentCards.length,
        itemBuilder: (context, index) {
          final card = recentCards[index];
          return ListTile(
            title: Text(card.name), // Replace with the actual card title field
            subtitle: Text(card.createdAt.minute.toString() ), // Replace with the actual card description field
            // Add other card information here as needed
          );
        },
      ),
    );
  }
}
