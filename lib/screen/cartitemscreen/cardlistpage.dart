import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class CardItemListPage extends StatefulWidget {
  @override
  _CardItemListPageState createState() => _CardItemListPageState();
}

class _CardItemListPageState extends State<CardItemListPage> {
  List<CardItem> cardItems = [];
  int currentPage = 1;
  final pageSize = 10; // Adjust the page size as needed
  final ascending = true; // Set your desired sorting order
  DateTime startDate = DateTime(2023, 1, 1); // Adjust start date
  DateTime endDate = DateTime.now(); // Use the current date as the end date

  @override
  void initState() {
    super.initState();
    // Load the initial page of data
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    final newCardItems = await CardItemDao().getMorePaginatedAndSortedDataWithDateFilter(
      page: currentPage,
      pageSize: pageSize,
      ascending: ascending,
      startDate: startDate,
      endDate: endDate,
    );

    setState(() {
      cardItems.addAll(newCardItems);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Items'),
      ),
      body: ListView.builder(
        itemCount: cardItems.length + 1,
        itemBuilder: (context, index) {
          if (index == cardItems.length) {
            // Display a loading indicator when loading more data
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final cardItem = cardItems[index];
            return ListTile(
              title: Text(cardItem.name),
              subtitle: Text(cardItem.desc),
              // You can display other properties of the CardItem here
            );
          }
        },
        // Trigger loading more data when reaching the end of the list
        controller: ScrollController()
          ..addListener(() {
            loadNextPage();

          }),
      ),
    );
  }
}
