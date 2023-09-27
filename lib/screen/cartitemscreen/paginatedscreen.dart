import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class PaginatedCardListScreen extends StatefulWidget {
  @override
  _PaginatedCardListScreenState createState() => _PaginatedCardListScreenState();
}

class _PaginatedCardListScreenState extends State<PaginatedCardListScreen> {
  Future<List<CardItem>> _fetchPaginatedCards(int page, int pageSize, String sortByColumn) async {
    // Execute the query and return the results
    return await CardItemDao().getPaginatedCards(page, pageSize, sortByColumn);
  }

  @override
  Widget build(BuildContext context) {
    final int pageSize = 5; // Define the number of items per page
    int currentPage = 1; // Define the current page number
    String sortByColumn = 'name'; // Define the column to sort by (e.g., 'name')

    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated Card List'),
      ),
      body: FutureBuilder<List<CardItem>>(
        future: _fetchPaginatedCards(currentPage, pageSize, sortByColumn),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If an error occurs
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there is no data
            return Text('No cards found.');
          } else {
            // If data is available, display the list
            final cards = snapshot.data;

            return ListView.builder(
              itemCount: cards!.length,
              itemBuilder: (context, index) {
                final cardItem = cards[index];
                return ListTile(
                  title: Text(cardItem.name),
                  subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
                  // Display more card details here as needed.
                );
              },
            );
          }
        },
      ),
    );
  }
}
