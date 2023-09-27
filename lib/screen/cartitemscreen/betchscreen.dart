// // import 'package:flutter/material.dart';
// //
// // import '../../modal/dao/carddao.dart';
// // import '../../modal/entity/card.dart';
// //
// // class BatchUpdateScreen extends StatefulWidget {
// //   @override
// //   _BatchUpdateScreenState createState() => _BatchUpdateScreenState();
// // }
// //
// // class _BatchUpdateScreenState extends State<BatchUpdateScreen> {
// //   // Example list of CardItem objects to update
// //   final List<CardItem> cardItemsToUpdate = [
// //     // CardItem(1, 'Updated Item 1', 'Updated Description 1', DateTime.now(), 10.99, 5, 0.2, id: null, name: ''),
// //     // CardItem(2, 'Updated Item 2', 'Updated Description 2', DateTime.now(), 15.99, 3, 0.1),
// //     // Add more CardItem objects to update as needed
// //   ];
// //
// //   Future<void> _handleBatchUpdate() async {
// //     try {
// //       await CardItemDao().batchUpdate(cardItemsToUpdate);
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //         content: Text('Batch update successful'),
// //         duration: Duration(seconds: 2),
// //       ));
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //         content: Text('Batch update failed: $e'),
// //         duration: Duration(seconds: 2),
// //       ));
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Batch Update Screen'),    ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: _handleBatchUpdate,
// //           child: Text('Batch Update'),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
//
// import '../../dtabasehelper.dart';
// import '../../modal/dao/carddao.dart';
// import '../../modal/entity/card.dart';
//
// class BatchUpdateScreen extends StatefulWidget {
//   @override
//   _BatchUpdateScreenState createState() => _BatchUpdateScreenState();
// }
//
// class _BatchUpdateScreenState extends State<BatchUpdateScreen> {
//   final dbHelper = DatabaseHelper();
//   final cardItemDao = CardItemDao();
//   List<CardItem> _cardItems = []; // List to store CardItems to be updated
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCardItemsForUpdate(); // Load CardItems to be updated when the screen initializes
//   }
//
//   Future<void> _loadCardItemsForUpdate() async {
//     final cardItems = await cardItemDao.findAllCards(); // Replace with your method to get CardItems
//     setState(() {
//       _cardItems = cardItems;
//     });
//   }
//
//   Future<void> _handleBatchUpdate() async {
//     final updatedCardItems = List<CardItem>.from(_cardItems); // Create a copy of the original list
//     for ( var cardItem in updatedCardItems) {
//       // Modify the properties of CardItem as needed
//       cardItem.discount += 10.0; // For example, increase the price by 10
//     }
//
//     try {
//       await cardItemDao.batchUpdate(updatedCardItems); // Perform the batch update
//       _showSnackBar('Batch update successful');
//     } catch (e) {
//       _showSnackBar('Error: Batch update failed');
//       print('Error: $e');
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 2),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Batch Update Screen'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: _handleBatchUpdate,
//             child: Text('Batch Update'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../dtabasehelper.dart';
import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class BatchUpdateScreen extends StatefulWidget {
  @override
  _BatchUpdateScreenState createState() => _BatchUpdateScreenState();
}

class _BatchUpdateScreenState extends State<BatchUpdateScreen> {
  final dbHelper = DatabaseHelper();
  final cardItemDao = CardItemDao();
  List<CardItem> _cardItems = [];

  @override
  void initState() {
    super.initState();
    _loadCardItemsForUpdate();
  }

  Future<void> _loadCardItemsForUpdate() async {
    final cardItems = await cardItemDao.findAllCards();
    setState(() {
      _cardItems = cardItems;
    });
  }

  Future<void> _handleBatchUpdate() async {
    final updatedCardItems = List<CardItem>.from(_cardItems);
    for (var cardItem in updatedCardItems) {
      cardItem.price += 10.0;
    }

    try {
      await cardItemDao.batchUpdate(updatedCardItems);
      _showSnackBar('Batch update successful');
      _loadCardItemsForUpdate(); // Reload the list after the batch update
    } catch (e) {
      _showSnackBar('Error: Batch update failed');
      print('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batch Update Screen'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _handleBatchUpdate,
            child: Text('Batch Update'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cardItems.length,
              itemBuilder: (context, index) {
                final cardItem = _cardItems[index];
                return ListTile(
                  title: Text(cardItem.name),
                  subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
