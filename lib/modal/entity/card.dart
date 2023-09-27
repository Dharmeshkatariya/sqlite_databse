// //
// //
// //
// // import 'package:floor/floor.dart';
// //
// // @entity
// // class CardItem {
// //   @primaryKey
// //   final int id;
// //
// //   final String name;
// //   final String desc;
// //   final double price;
// //   final int qty;
// //   final double discount;
// //
// //   CardItem(this.id, this.name, this.desc, this.price, this.qty, this.discount);
// // }
//
// class CardItem {
//   final int id;
//
//   final String name;
//   final String desc;
//   final double price;
//   final int qty;
//   final DateTime createdAt;
//   final double discount;
//
//   CardItem(this.id, this.name, this.desc,
//        this.createdAt,
//       this.price, this.qty, this.discount);
//
//   factory CardItem.fromMap(Map<String, dynamic> map) {
//     return CardItem(
//       map['id'] as int,
//       map['name'] as String,
//       map['desc'] as String,
//       map['createdAt'] as String,
//
//       map['price'] as double,
//       map['qty'] as int,
//
//       map['discount'] as double,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'desc': desc,
//       'price': price,
//       'qty': qty,
//       'discount': discount,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
class CardItem {
  final int id;
  final String name;
  final String desc;
   double price;
  final int qty;
  final DateTime createdAt;
   double discount;

  CardItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.qty,
    required this.createdAt,
    required this.discount,
  });

  factory CardItem.fromMap(Map<String, dynamic> map) {
    return CardItem(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as double,
      qty: map['qty'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      discount: map['discount'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'qty': qty,
      'createdAt': createdAt.toIso8601String(),
      'discount': discount,
    };
  }
}
