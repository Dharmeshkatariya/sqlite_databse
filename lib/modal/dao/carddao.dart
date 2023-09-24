import '../../dtabasehelper.dart';
import '../entity/card.dart';

class CardItemDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertCard(CardItem cardItem) async {
    final db = await dbHelper.database;
    return await db.insert('CardItem', cardItem.toMap());
  }

  Future<List<CardItem>> findAllCards() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('CardItem');
    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<int> updateCard(CardItem cardItem) async {
    final db = await dbHelper.database;
    return await db.update(
      'CardItem',
      cardItem.toMap(),
      where: 'id = ?',
      whereArgs: [cardItem.id],
    );
  }

  Future<int> deleteCard(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'CardItem',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
