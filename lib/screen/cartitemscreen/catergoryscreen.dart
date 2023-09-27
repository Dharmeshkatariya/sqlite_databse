// // import 'package:flutter/material.dart';
// //
// // import '../../modal/dao/carddao.dart';
// // import '../../modal/entity/card.dart';
// //
// // class CategoryCardsScreen extends StatefulWidget {
// //   final String category;
// //
// //   CategoryCardsScreen({required this.category});
// //
// //   @override
// //   _CategoryCardsScreenState createState() => _CategoryCardsScreenState();
// // }
// //
// // class _CategoryCardsScreenState extends State<CategoryCardsScreen> {
// //   List<CardItem> _cards = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchCardsByCategory();
// //   }
// //
// //   Future<void> _fetchCardsByCategory() async {
// //     final cards = await CardItemDao().findCardsByCategory(widget.category);
// //     setState(() {
// //       _cards = cards;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Category: ${widget.category}'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _cards.length,
// //         itemBuilder: (context, index) {
// //           final cardItem = _cards[index];
// //           return ListTile(
// //             title: Text(cardItem.name,style: TextStyle(color: Colors.black),),
// //             subtitle: Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
// //             // You can display more card details here as needed.
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import '../../modal/dao/carddao.dart';
// import '../../modal/entity/card.dart';
//
// class CategoryCardsScreen extends StatefulWidget {
//   final String category;
//
//   CategoryCardsScreen({required this.category});
//
//   @override
//   _CategoryCardsScreenState createState() => _CategoryCardsScreenState();
// }
//
// class _CategoryCardsScreenState extends State<CategoryCardsScreen> {
//   List<CardItem> _cards = [];
//   List<CardItem> _filteredCards = []; // List to store filtered cards
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCardsByCategory();
//   }
//
//   Future<void> _fetchCardsByCategory() async {
//     final cards = await CardItemDao().findCardsByCategory(widget.category);
//     setState(() {
//       _cards = cards;
//       _filteredCards = cards; // Initialize the filtered list with all cards
//     });
//   }
//
//   void _filterCards(String searchTerm) {
//     // Filter the cards based on the search term
//     setState(() {
//       _filteredCards = _cards.where((card) {
//         return card.name.toLowerCase().contains(searchTerm.toLowerCase());
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Category: ${widget.category}'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search Cards',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: () {
//                     // Clear the search field and show all cards
//                     _searchController.clear();
//                     _filterCards('');
//                   },
//                 ),
//               ),
//               onChanged: (value) {
//                 _filterCards(value); // Filter cards as the user types
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredCards.length,
//               itemBuilder: (context, index) {
//                 final cardItem = _filteredCards[index];
//                 return ListTile(
//                   title: Text(
//                     cardItem.name,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   subtitle:
//                   Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
//                   // You can display more card details here as needed.
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class CategoryCardsScreen extends StatefulWidget {
  final String category;

  CategoryCardsScreen({required this.category});

  @override
  _CategoryCardsScreenState createState() => _CategoryCardsScreenState();
}

class _CategoryCardsScreenState extends State<CategoryCardsScreen> {
  List<CardItem> _cards = [];
  List<CardItem> _filteredCards = []; // List to store filtered cards
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCardsByCategory(widget.category);
  }

  Future<void> _fetchCardsByCategory(String data) async {
    final cards = await CardItemDao().findCardsByCategory(data);
    setState(() {
      _cards = cards;
      _filteredCards = cards; // Initialize the filtered list with all cards
    });
  }

  void _filterCards(String searchTerm) {
    // Filter the cards based on the search term
    setState(() {
      _filteredCards = _cards.where((card) {
        return card.name.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category: ${widget.category}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Cards',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    // Clear the search field and show all cards
                    _searchController.clear();
                    _filterCards('');
                  },
                ),
              ),
              onChanged: (value) {
                _fetchCardsByCategory(value);
                // _filterCards(value); // Filter cards as the user types
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCards.length,
              itemBuilder: (context, index) {
                final cardItem = _filteredCards[index];
                return ListTile(
                  title: Text(
                    cardItem.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle:
                  Text('Price: \$${cardItem.price.toStringAsFixed(2)}'),
                  // You can display more card details here as needed.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
