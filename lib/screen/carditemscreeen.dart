// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../modal/dao/carddao.dart';
// import '../modal/entity/card.dart';
//
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final CardItemDao cardItemDao = CardItemDao();
//
//   List<CardItem> cardItems = [];
//   bool isUpdating = false;
//   int updatingItemId = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshCardItems();
//   }
//
//   Future<void> _refreshCardItems() async {
//     final items = await cardItemDao.getAllCardItems();
//     setState(() {
//       cardItems = items;
//     });
//   }
//
//   Future<void> _onSubmit() async {
//     final name = nameController.text;
//     final description = descriptionController.text;
//
//     if (isUpdating) {
//       final updatedItem = CardItem(
//         id: updatingItemId,
//         name: name,
//         description: description,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//       await cardItemDao.updateCardItem(updatedItem);
//     } else {
//       final newItem = CardItem(
//         name: name,
//         description: description,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//       await cardItemDao.insertCardItem(newItem);
//     }
//
//     _refreshCardItems();
//     _clearFields();
//   }
//
//   Future<void> _clearFields() {
//     nameController.text = '';
//     descriptionController.text = '';
//     setState(() {
//       isUpdating = false;
//       updatingItemId = 0;
//     });
//   }
//
//   Future<void> _deleteCardItem(int id) async {
//     await cardItemDao.deleteCardItem(id);
//     _refreshCardItems();
//   }
//
//   void _editCardItem(CardItem item) {
//     setState(() {
//       nameController.text = item.name;
//       descriptionController.text = item.description;
//       isUpdating = true;
//       updatingItemId = item.id;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SQLite Example'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _onSubmit,
//             child: Text(isUpdating ? 'Update' : 'Add'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: cardItems.length,
//               itemBuilder: (context, index) {
//                 final item = cardItems[index];
//                 return ListTile(
//                   title: Text(item.name),
//                   subtitle: Text(item.description),
//                   trailing: IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () => _editCardItem(item),
//                   ),
//                   onLongPress: () => _deleteCardItem(item.id),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
