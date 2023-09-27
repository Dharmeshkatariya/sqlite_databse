import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class CardsWithDiscountLessThanScreen extends StatefulWidget {

  CardsWithDiscountLessThanScreen();

  @override
  _CardsWithDiscountLessThanScreenState createState() =>
      _CardsWithDiscountLessThanScreenState();
}

class _CardsWithDiscountLessThanScreenState
    extends State<CardsWithDiscountLessThanScreen> {
  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsWithDiscountLessThan();
  }

  Future<void> _fetchCardsWithDiscountLessThan() async {
    var discount = 100000.0;
    var helper = CardItemDao();
    final cards = await helper
        .getCardsWithDiscountLessThan(discount); // Call your query method here
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards with Discount Less Tha}'),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Discount: ${cardItem.discount}%'),
            // Add more card details here as needed.
          );
        },
      ),
    );
  }
}
