// import 'package:sqflite/sqflite.dart';
// import 'package:sqlite_work_databse_dk/dtabasehelper.dart';
// import '../entity/booking.dart';
//
// class BookingDao {
//   final  database =DatabaseHelper();
//
//
//   Future<int> insertBooking(Booking booking) async {
//     return await database.insert('bookings', booking.toMap());
//   }
//
//   Future<List<Booking>> getAllBookings() async {
//     final List<Map<String, dynamic>> maps = await database.query('bookings');
//     return List.generate(maps.length, (i) {
//       return Booking.fromMap(maps[i]);
//     });
//   }
//
//   Future<Booking?> getBookingById(int id) async {
//     final List<Map<String, dynamic>> maps = await database.query(
//       'bookings',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//
//     if (maps.isEmpty) {
//       return null; // Booking with the specified ID not found
//     }
//
//     return Booking.fromMap(maps.first);
//   }
//
//   Future<int> updateBooking(Booking booking) async {
//     return await database.update(
//       'bookings',
//       booking.toMap(),
//       where: 'id = ?',
//       whereArgs: [booking.id],
//     );
//   }
//
//   Future<int> deleteBooking(int id) async {
//     return await database.delete(
//       'bookings',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
import '../../dtabasehelper.dart';
import '../entity/booking.dart';

class BookingDao {
  final  dbHelper = DatabaseHelper();

  Future<int> insertBooking(Booking booking) async {
    final db = await dbHelper.database;
    return await db.insert('Bookings', booking.toMap());
  }

  Future<List<Booking>> getAllBookings() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Bookings');
    return List.generate(maps.length, (i) {
      return Booking.fromMap(maps[i]);
    });
  }

  Future<Booking?> getBookingById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Bookings',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null; // Booking with the specified ID not found
    }

    return Booking.fromMap(maps.first);
  }

  Future<int> updateBooking(Booking booking) async {
    final db = await dbHelper.database;
    return await db.update(
      'Bookings',
      booking.toMap(),
      where: 'id = ?',
      whereArgs: [booking.id],
    );
  }

  Future<int> deleteBooking(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'Bookings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}