import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

class AverageValueScreen extends StatefulWidget {
  @override
  _AverageValueScreenState createState() => _AverageValueScreenState();
}

class _AverageValueScreenState extends State<AverageValueScreen> {
  double _averageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateAverageValue();
  }

  Future<void> _calculateAverageValue() async {
    try {
      var data = CardItemDao();
      final averageValue = await data. calculateAverageValue(); // Use your function to calculate the average value
      setState(() {
        _averageValue = averageValue;
      });
    } catch (e) {
      print('Error calculating average value: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Average Value'),
      ),
      body: Center(
        child: Text(
          'Average Value: \$${_averageValue.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
