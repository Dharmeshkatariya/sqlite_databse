class Booking {
  final int? id;
  final String customerName;
  final String bookingDate;
  final int roomNumber;
  final String checkIn;
  final String checkOut;

  Booking({
    this.id,
    required this.customerName,
    required this.bookingDate,
    required this.roomNumber,
    required this.checkIn,
    required this.checkOut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_name': customerName,
      'booking_date': bookingDate,
      'room_number': roomNumber,
      'check_in': checkIn,
      'check_out': checkOut,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      customerName: map['customer_name'],
      bookingDate: map['booking_date'],
      roomNumber: map['room_number'],
      checkIn: map['check_in'],
      checkOut: map['check_out'],
    );
  }
}