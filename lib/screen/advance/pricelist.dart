import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class PriceRangeCardList extends StatefulWidget {

  PriceRangeCardList();

  @override
  _PriceRangeCardListState createState() => _PriceRangeCardListState();
}

class _PriceRangeCardListState extends State<PriceRangeCardList> {
  List<CardItem> cardItems = []; // This should be populated with your data.
  var minPrice = 20.0;
  var maxPrice = 10000.0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Items in Price Range'),
      ),
      body: FutureBuilder<List<CardItem>>(
        // Call your database query function here
        future: CardItemDao().findCardItemsInPriceRange(minPrice, maxPrice),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Card Items found in the specified price range.'),
            );
          }

          // Update the cardItems list with the fetched data
          cardItems = snapshot.data!;

          return ListView.builder(
            itemCount: cardItems.length,
            itemBuilder: (context, index) {
              final cardItem = cardItems[index];
              return ListTile(
                title: Text(cardItem.name),
                subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
                // Add more fields as needed
              );
            },
          );
        },
      ),
    );
  }
}
