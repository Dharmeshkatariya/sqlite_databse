import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

class ItemCountScreen extends StatefulWidget {
  @override
  _ItemCountScreenState createState() => _ItemCountScreenState();
}

class _ItemCountScreenState extends State<ItemCountScreen> {
  int _itemCount = 0; // Variable to store the item count

  @override
  void initState() {
    super.initState();
    _fetchItemCount();
  }

  Future<void> _fetchItemCount() async {
    var dbHelper = CardItemDao()
;    final itemCount = await dbHelper.countItems();
    setState(() {
      _itemCount = itemCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Count'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Items:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_itemCount',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
