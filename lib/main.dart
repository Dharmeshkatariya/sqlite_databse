// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sqlite_work_databse_dk/screen/productlist.dart';
// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'common.dart';
// import 'dtabasehelper.dart';
//
// void main()async {
//   // Initialize ffi loader
//   // sqfliteFfiInit();
//
//   // Define the database factory
//   // var databaseFactory = databaseFactoryFfi;
//
//   // Open an in-memory database
//   // var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
//
//   final common = Common();
//   await common.initDatabase();
//   // final databaseHelper = DatabaseHelper(); // Create an instance of your database helper class
//   // await databaseHelper.initDatabase(); // Initialize the
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     _listScreen();
//     super.initState();
//   }
//

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text(
//               'Product Data ',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sqlite_work_databse_dk/screen/productlist.dart';

import 'common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _initDatabase() async {
    await Common().initDatabase();
  }
  _listScreen() async {
    await Common().initDatabase();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Get.off(ProductList());
      timer.cancel();
    });
  }
  @override
  void initState() {
    super.initState();
    _listScreen();
    // Call the database initialization method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Product Data ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
