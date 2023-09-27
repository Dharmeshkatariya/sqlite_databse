import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  // Define a list to store the retrieved CardItems
  List<CardItem> cardItems = [];

  // Function to fetch CardItems created before a specific date
  Future<void> fetchCardItems(DateTime date) async {
    try {
      List<CardItem> items = await CardItemDao().findCardItemsCreatedBefore(date);
      setState(() {
        cardItems = items;
        print(cardItems);
      });
    } catch (e) {
      // Handle errors, e.g., display an error message
      print('Error fetching CardItems: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Page Title'),
      ),
      body: Column(
        children: [
          // Add a button to trigger the data fetching
          ElevatedButton(
            onPressed: () {
              // Call the function to fetch CardItems with a specific date
              fetchCardItems(DateTime(2023, 5, 5)); // Replace with your desired date
            },
            child: Text('Fetch CardItems'),
          ),
          // Display the fetched CardItems in a ListView
          Expanded(
            child: ListView.builder(
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cardItems[index].name,style: TextStyle(color: Colors.red),),
                  subtitle: Text(cardItems[index].createdAt.toString()),
                  // Add more ListTile details as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
