import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

class MaxValueScreen extends StatefulWidget {
  @override
  _MaxValueScreenState createState() => _MaxValueScreenState();
}

class _MaxValueScreenState extends State<MaxValueScreen> {
  int _maxValue = 0;

  @override
  void initState() {
    super.initState();
    _findMaxValue();
  }

  Future<void> _findMaxValue() async {
    try {
      final helper = CardItemDao();
      final maxValue = await helper.findMaxPrice(); // Use your function to find the maximum value
      setState(() {
        _maxValue = maxValue;
      });
    } catch (e) {
      print('Error finding maximum value: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maximum Value'),
      ),
      body: Center(
        child: Text(
          'Maximum Value: $_maxValue',
          style: TextStyle(fontSize: 24,color: Colors.red),
        ),
      ),
    );
  }
}
