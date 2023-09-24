// // entity/person.dart
//
// import 'package:floor/floor.dart';
//
// @entity
// class Person {
//   @primaryKey
//   final int id;
//
//   final String name;
//
//   Person(this.id, this.name);
// }
class Person {
  final int id;

  final String name;

  Person(this.id, this.name);

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      map['id'] as int,
      map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
