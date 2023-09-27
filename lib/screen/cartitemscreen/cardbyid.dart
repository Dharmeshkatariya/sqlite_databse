import 'package:flutter/material.dart';

import '../../modal/dao/carddao.dart';
import '../../modal/entity/card.dart';

class CardFindByIdScreeen extends StatefulWidget {
  @override
  _CardFindByIdScreeenState createState() => _CardFindByIdScreeenState();
}

class _CardFindByIdScreeenState extends State<CardFindByIdScreeen> {
  final TextEditingController _idController = TextEditingController();
  CardItem? _cardItem;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _fetchCardDetails() async {
    final int id = int.tryParse(_idController.text) ?? -1; // Parse the ID from the TextField
    final cardItem = await CardItemDao().findCardById(id); // Query the database

    setState(() {
      _cardItem = cardItem;
      print(_cardItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Card ID'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchCardDetails,
              child: Text('Fetch Card Details'),
            ),
            SizedBox(height: 16),
            _cardItem != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${_cardItem!.id}'),
                Text('Name: ${_cardItem!.name}'),
                Text('Description: ${_cardItem!.desc}'),
                Text('Price: \$${_cardItem!.price.toStringAsFixed(2)}'),
                Text('Quantity: ${_cardItem!.qty}'),
                Text('Created At: ${_cardItem!.createdAt.toLocal()}'),
                Text('Discount: ${_cardItem!.discount * 100}%'),
              ],
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
