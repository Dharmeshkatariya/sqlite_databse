import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_work_databse_dk/modal/dao/productdao.dart';

import 'modal/dao/carddao.dart';
import 'dtabasehelper.dart';
import 'modal/entity/card.dart';
import 'modal/entity/product.dart';

class Common {
  static String productDetail = '/product_detail';

  int getRandomId() {
    var random = Random();
    return random.nextInt(100);
  }
  static final Common _instance = Common._internal();

  factory Common() => _instance;

  Common._internal();

  late final DatabaseHelper dbHelper; // Declare DatabaseHelper instance

  Future<void> initDatabase() async {
    dbHelper = DatabaseHelper(); // Initialize DatabaseHelper
    await dbHelper.initDatabase(); // Initialize the database
  }

  // static var database;
  //
  // initDatabase() async {
  //   database ??=
  //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // }

  Future<void> insertProduct(Product product) async {
    try {
      final productDao = ProductDao();

      var res = await productDao.insertProduct(product);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final productDao = ProductDao();
      List<Product> products = await productDao.findAllProducts();
      print(products);
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }


  updateProduct(Product product) async {
    try {
      final productDao = ProductDao();

      var res = await productDao.updateProductById(product.id, product.name,
          product.desc, product.price, product.qty, product.discount);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<void> insertCardItem(CardItem card) async {
    try {
      final cardDao = CardItemDao(); // Initialize CardItemDao

      var res = await cardDao.insertCard(card);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<List<CardItem>> getAllCardItems() async {
    try {
      final cardDao = CardItemDao(); // Initialize CardItemDao
      List<CardItem> cardItems = await cardDao.findAllCards();
      print(cardItems);
      return cardItems;
    } catch (e) {
      print(e);
      return [];
    }}

  static Widget button({required String text,GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Text(
            text,
            style:const  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white),
          ),
        ));
  }

 static Widget textField(
      {String? text,
      TextEditingController? controller,
      dynamic validator,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: text,
            labelText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
