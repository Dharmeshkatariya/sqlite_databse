import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../modal/entity/card.dart';

class CardsWithQuantityLessThanScreen extends StatefulWidget {

  CardsWithQuantityLessThanScreen();

  @override
  _CardsWithQuantityLessThanScreenState createState() => _CardsWithQuantityLessThanScreenState();
}

class _CardsWithQuantityLessThanScreenState extends State<CardsWithQuantityLessThanScreen> {
  List<CardItem> _cards = [];

  @override
  void initState() {
    super.initState();
    _fetchCardsWithQuantityLessThan();
  }

  Future<void> _fetchCardsWithQuantityLessThan() async {
    var qty = 500;
    var helper = CardItemDao()
;    final cards = await  helper .getCardsWithQuantityLessThan(qty); // Call your query method here
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards with Quantity Less Than '),
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final cardItem = _cards[index];
          return ListTile(
            title: Text(cardItem.name),
            subtitle: Text('Quantity: ${cardItem.qty}'),
            // Add more card details here as needed.
          );
        },
      ),
    );
  }
}
