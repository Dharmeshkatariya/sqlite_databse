import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/common.dart';

import '../modal/dao/bookingdao.dart';
import '../modal/entity/booking.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _bookingDateController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();


  @override
  void dispose() {
    _customerNameController.dispose();
    _bookingDateController.dispose();
    _roomNumberController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  void _insertBooking() async {
    final newBooking = Booking(
      customerName: _customerNameController.text,
      bookingDate: _bookingDateController.text,
      roomNumber: int.parse(_roomNumberController.text),
      checkIn: _checkInController.text,
      checkOut: _checkOutController.text,
    );

    await Common().insertBooking(newBooking);
    setState(() {
      print("insertbook")
;      // Clear text fields after insertion
      // _customerNameController.clear();
      // _bookingDateController.clear();
      // _roomNumberController.clear();
      // _checkInController.clear();
      // _checkOutController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              controller: _bookingDateController,
              decoration: InputDecoration(labelText: 'Booking Date'),
            ),
            TextField(
              controller: _roomNumberController,
              decoration: InputDecoration(labelText: 'Room Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _checkInController,
              decoration: InputDecoration(labelText: 'Check-In Date'),
            ),
            TextField(
              controller: _checkOutController,
              decoration: InputDecoration(labelText: 'Check-Out Date'),
            ),
            ElevatedButton(
              onPressed: _insertBooking,
              child: Text('Add Booking'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Booking>>(
                future: Common().getAllbokking(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No bookings available.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final booking = snapshot.data![index];
                      return ListTile(
                        title: Text('Customer: ${booking.customerName}'),
                        subtitle: Text('Room: ${booking.roomNumber}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}