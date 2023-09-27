import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

class DistinctNamesScreen extends StatefulWidget {
  @override
  _DistinctNamesScreenState createState() => _DistinctNamesScreenState();
}

class _DistinctNamesScreenState extends State<DistinctNamesScreen> {
  List<String> _distinctNames = [];

  @override
  void initState() {
    super.initState();
    _fetchDistinctNames();
  }

  Future<void> _fetchDistinctNames() async {
    try {
      var helper  = CardItemDao()
;      final distinctNames = await helper .getDistinctNames(); // Use your function to get distinct names
      setState(() {
        _distinctNames = distinctNames;
      });
    } catch (e) {
      print('Error fetching distinct names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distinct Names'),
      ),
      body: ListView.builder(
        itemCount: _distinctNames.length,
        itemBuilder: (context, index) {
          final name = _distinctNames[index];
          return ListTile(
            title: Text(name),
            // You can add more details or actions here if needed.
          );
        },
      ),
    );
  }
}
