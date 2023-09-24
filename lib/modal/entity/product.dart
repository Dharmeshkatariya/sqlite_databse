// // entity/person.dart
//
// import 'package:floor/floor.dart';
//
// @entity
// class Product {
//   @primaryKey
//   final int id;
//
//   final String name;
//   final String desc;
//   final double price;
//   int qty;
//   final double discount;
//
//   Product(this.id, this.name, this.desc, this.price, this.qty, this.discount);
// }

class Product {
  final int id;

  final String name;
  final String desc;
  final double price;
  final int qty; // Make this non-nullable since it's not in the constructor
  final double discount;

  Product(this.id, this.name, this.desc, this.price, this.qty, this.discount);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'] as int,
      map['name'] as String,
      map['desc'] as String,
      map['price'] as double,
      map['qty'] as int,
      map['discount'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'qty': qty,
      'discount': discount,
    };
  }
}
