import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/carddao.dart';

import '../../dtabasehelper.dart';

class NearbyPlacesScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double maxDistance;

  NearbyPlacesScreen({
    required this.latitude,
    required this.longitude,
    required this.maxDistance,
  });

  @override
  _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  final dbHelper = CardItemDao();
  List<Map<String, dynamic>> _nearbyPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadNearbyPlaces();
  }

  Future<void> _loadNearbyPlaces() async {
    try {
      final nearbyPlaces = await dbHelper.findNearbyPlaces(
        widget.latitude,
        widget.longitude,
        widget.maxDistance,
      );
      setState(() {
        _nearbyPlaces = nearbyPlaces;
      });
    } catch (e) {
      print('Error loading nearby places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Places'),
      ),
      body: ListView.builder(
        itemCount: _nearbyPlaces.length,
        itemBuilder: (context, index) {
          final place = _nearbyPlaces[index];
          final placeName = place['name'] as String;

          return ListTile(
            title: Text(placeName),
          );
        },
      ),
    );
  }
}
