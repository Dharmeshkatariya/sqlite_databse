import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class FindCardForConitonScreen extends StatefulWidget {
  @override
  _FindCardForConitonScreenState createState() => _FindCardForConitonScreenState();
}

class _FindCardForConitonScreenState extends State<FindCardForConitonScreen> {
  Future<List<CardItem>> _fetchCards() async {
    // Define the query parameters (name, price, category)
    final name = "dharmesh"; // Replace with actual values
    final price = 20; // Replace with actual values
    final category = "radhe"; // Replace with actual values

    // Execute the query and return the results
    return await CardItemDao().findCardsWithComplexConditions(name, price, category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
      ),
      body: FutureBuilder<List<CardItem>>(
        future: _fetchCards(),
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
