//
//
//
// import 'package:floor/floor.dart';
//
// @entity
// class CardItem {
//   @primaryKey
//   final int id;
//
//   final String name;
//   final String desc;
//   final double price;
//   final int qty;
//   final double discount;
//
//   CardItem(this.id, this.name, this.desc, this.price, this.qty, this.discount);
// }

class CardItem {
  final int id;

  final String name;
  final String desc;
  final double price;
  final int qty;
  final double discount;

  CardItem(this.id, this.name, this.desc, this.price, this.qty, this.discount);

  factory CardItem.fromMap(Map<String, dynamic> map) {
    return CardItem(
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
