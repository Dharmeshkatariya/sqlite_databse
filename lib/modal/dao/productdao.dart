import '../../dtabasehelper.dart';
import '../entity/product.dart';

class ProductDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.insert('Product', product.toMap());
  }

  Future<List<Product>> findAllProducts() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Product');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<int> updateProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.update(
      'Product',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> updateProductById(
      int id, String name, String desc, double price, int qty, double discount) async {
    final db = await dbHelper.database;
    return await db.update(
      'Product',
      {
        'name': name,
        'desc': desc,
        'price': price,
        'qty': qty,
        'discount': discount,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<int> deleteProduct(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'Product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}