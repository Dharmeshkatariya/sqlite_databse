import 'dart:io';

import 'package:sqflite/sqflite.dart';

import '../../dtabasehelper.dart';
import '../entity/card.dart';

class CardItemDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertCard(CardItem cardItem) async {
    final db = await dbHelper.database;
    return await db.insert('CardItem', cardItem.toMap());
  }

  Future<List<CardItem>> getPaginatedAndSortedDataWithDateFilter({
    required int page,
    required int pageSize,
    required bool ascending,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await dbHelper.database;
    final sortOrder = ascending ? 'ASC' : 'DESC';
    final offset = (page - 1) * pageSize;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
  SELECT *
  FROM CardItem
  WHERE createdAt BETWEEN ? AND ?
  ORDER BY createdAt $sortOrder
  LIMIT ? OFFSET ?
''', [
      startDate.toIso8601String(),
      endDate.toIso8601String(),
      pageSize,
      offset,
    ]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });

  //   final List<Map<String, dynamic>> maps = await db.rawQuery('''
  //   SELECT *
  //   FROM CardItem
  //   WHERE created_at BETWEEN ? AND ?
  //   ORDER BY columnName $sortOrder
  //   LIMIT $pageSize OFFSET $offset
  // ''', [startDate.toIso8601String(), endDate.toIso8601String()]);
  //
  //   return List.generate(maps.length, (i) {
  //     return CardItem.fromMap(maps[i]);
  //   });
  }

  Future<List<CardItem>> getPaginatedAndSortedData({
    required int page,
    required int pageSize,
    required bool ascending,
  }) async {
    final db = await dbHelper.database;
    final sortOrder = ascending ? 'ASC' : 'DESC';
    final offset = (page - 1) * pageSize;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM CardItem
      ORDER BY columnName $sortOrder
      LIMIT $pageSize OFFSET $offset
    ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
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

  Future<CardItem?> findCardById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CardItem.fromMap(maps.first);
    } else {
      return null;
    }
  }
  Future<List<CardItem>> findCardsByCategory(String category) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'name = ?',
      whereArgs: [category],
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> fetchRecentCards({int limit = 10}) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      orderBy: 'createdAt DESC',
      limit: limit,
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  // Future<List<CardItem>> findMostRecentCards({int limit = 10}) async {
  //   final db = await dbHelper.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'CardItem',
  //     orderBy: 'timestamp DESC',
  //     limit: limit,
  //   );
  //
  //   return List.generate(maps.length, (i) {
  //     return CardItem.fromMap(maps[i]);
  //   });
  // }
  Future<List<CardItem>> customQuery(String sql, List<dynamic> args) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(sql, args);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> findCardItemsWithCategory() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT CardItem.*, Category.name AS categoryName
    FROM CardItem
    INNER JOIN Category ON CardItem.categoryId = Category.id
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<Map<String, int>> countCardItemsByCategory() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Category.name, COUNT(CardItem.id) AS count
    FROM CardItem
    INNER JOIN Category ON CardItem.categoryId = Category.id
    GROUP BY Category.name
  ''');

    final result = <String, int>{};
    for (final map in maps) {
      result[map['name'] as String] = map['count'] as int;
    }

    return result;
  }

  Future<int> countCardItems() async {
    final db = await dbHelper.database;
    final result = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM CardItem'));

    return result ?? 0;
  }
  Future<void> transferFundsBetweenAccounts(double amount, int senderId, int receiverId) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      // Deduct funds from sender's account
      await txn.rawUpdate('UPDATE Account SET balance = balance - ? WHERE id = ?', [amount, senderId]);

      // Add funds to receiver's account
      await txn.rawUpdate('UPDATE Account SET balance = balance + ? WHERE id = ?', [amount, receiverId]);
    });
  }



  Future<int> deleteCard(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'CardItem',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CardItem>> findCardsInCategoriesWithCondition() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE categoryId IN (
      SELECT id
      FROM Category
      WHERE condition_column = ?
    )
  ''', ['your_condition_value']);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<Map<String, dynamic>>> rankCardsByScore() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT id, name, score, 
           RANK() OVER (ORDER BY score DESC) AS ranking
    FROM CardItem
  ''');

    return maps;
  }
  Future<List<Map<String, dynamic>>> findSubordinates(int managerId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    WITH RECURSIVE Subordinates AS (
      SELECT id, name, managerId
      FROM Employee
      WHERE managerId = ?
      UNION ALL
      SELECT e.id, e.name, e.managerId
      FROM Employee e
      INNER JOIN Subordinates s ON e.managerId = s.id
    )
    SELECT * FROM Subordinates
  ''', [managerId]);

    return maps;
  }
  Future<List<CardItem>> searchCards(String query) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE name LIKE ?
       OR desc LIKE ?
  ''', ['%$query%', '%$query%']);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  // Future<List<Map<String, dynamic>>> searchCards(String query) async {
  //   final db = await dbHelper.database;
  //   final List<Map<String, dynamic>> maps = await db.rawQuery('''
  //   SELECT * FROM CardItem
  //   WHERE CardItem MATCH ?
  // ''', [query]);
  //
  //   return maps;
  // }
  Future<List<CardItem>> findCardsCreatedBetweenDates(DateTime startDate, DateTime endDate) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE createdAt BETWEEN ? AND ?
  ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<int> updateCardsWithCondition(String conditionValue, int newValue) async {
    final db = await dbHelper.database;
    return await db.rawUpdate('''
    UPDATE CardItem
    SET some_column = ?
    WHERE condition_column = ?
  ''', [newValue, conditionValue]);
  }
  Future<void> batchInsert(List<CardItem> cardItems) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      for (final cardItem in cardItems) {
        await txn.insert('CardItem', cardItem.toMap());
      }
    });
  }

  Future<List<CardItem>> findCardsWithComplexConditions(String name, int price, String category) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE (name = ? OR desc = ?) AND price >= ?
  ''', [name, category, price]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }


  Future<List<CardItem>> getPaginatedCards(int page, int pageSize, String sortByColumn) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY $sortByColumn ASC
    LIMIT ? OFFSET ?
  ''', [pageSize, (page - 1) * pageSize]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<void> backupDatabase(String backupPath) async {
    // final originalPath = await dbHelper.getDatabasePath();
    // final file = File(originalPath);
    // await file.copy(backupPath);
  }
  Future<void> createIndexOnColumn(String columnName) async {
    final db = await dbHelper.database;
    await db.execute('CREATE INDEX IF NOT EXISTS ${columnName}_index ON CardItem($columnName)');
  }

  Future<void> exportDataToCsv(String exportPath) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('SELECT * FROM CardItem');
    final csvList = result.map((row) => row.values.join(',')).toList();
    final csvContent = csvList.join('\n');
    final file = File(exportPath);
    await file.writeAsString(csvContent);
  }


  Future<void> batchUpdate(List<CardItem> cardItems) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      for (final cardItem in cardItems) {
        await txn.update(
          'CardItem',
          cardItem.toMap(),
          where: 'id = ?',
          whereArgs: [cardItem.id],
        );
      }
    });
  }

  // sql query for sqlite db
  Future<List<Map<String, dynamic>>> customQueryWithParams(String sql, List<dynamic> params) async {
    final db = await dbHelper.database;
    final results = await db.rawQuery(sql, params);
    return results;
  }

  Future<void> vacuumDatabase() async {
    final db = await dbHelper.database;
    await db.execute('VACUUM');
  }

  Future<void> exportDatabaseToFile(String exportPath) async {
    // final originalPath = await dbHelper.getDatabasePath();
    // final file = File(originalPath);
    // final backupFile = File(exportPath);
    // await file.copy(backupFile.path);
  }
  Future<void> updateCardItemWithOptimisticLocking(CardItem updatedCardItem) async {
    final db = await dbHelper.database;
    final currentVersion = updatedCardItem.qty; // Get the current version from the UI
    final rowsUpdated = await db.update(
      'CardItem',
      updatedCardItem.toMap(),
      where: 'id = ? AND version = ?',
      whereArgs: [updatedCardItem.id, currentVersion],
    );


  }

  Future<List<Map<String, dynamic>>> rankEmployeesByDepartment() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT id, name, department,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
    FROM Employee
  ''');

    return maps;
  }
  Future<List<Map<String, dynamic>>> findAncestors(int employeeId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    WITH RECURSIVE Ancestors AS (
      SELECT id, name, managerId
      FROM Employee
      WHERE id = ?
      UNION ALL
      SELECT e.id, e.name, e.managerId
      FROM Employee e
      INNER JOIN Ancestors a ON e.id = a.managerId
    )
    SELECT * FROM Ancestors
  ''', [employeeId]);

    return maps;
  }
  Future<double> weightedAverageSalary() async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('''
    SELECT custom_weighted_avg(salary) AS weighted_avg
    FROM Employee
  ''');

    return (result.first['weighted_avg'] as double?) ?? 0.0;
  }
  Future<List<Map<String, dynamic>>> findNearbyPlaces(double latitude, double longitude, double maxDistance) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('''
    SELECT name
    FROM Places
    WHERE ST_Distance(
      ST_Point(?1, ?2),
      ST_Point(Places.latitude, Places.longitude)
    ) <= ?3
  ''', [longitude, latitude, maxDistance]);

    return result;
  }
  Future<List<Map<String, dynamic>>> findDescendants(int nodeId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    WITH RECURSIVE Descendants AS (
      SELECT * FROM TreeTable WHERE id = ?
      UNION ALL
      SELECT tt.* FROM TreeTable tt
      INNER JOIN Descendants d ON d.id = tt.parent_id
    )
    SELECT * FROM Descendants;
  ''', [nodeId]);

    return maps;
  }
  Future<void> createFTS5Table() async {
    final db = await dbHelper.database;
    await db.execute('''
    CREATE VIRTUAL TABLE IF NOT EXISTS CardItemFTS
    USING fts5(name, description);
  ''');
  }

  Future<List<Map<String, dynamic>>> searchFTS5(String query) async {
    final db = await dbHelper.database;
    final results = await db.rawQuery('''
    SELECT * FROM CardItemFTS
    WHERE CardItemFTS MATCH ?
  ''', [query]);

    return results;
  }
  Future<List<Map<String, dynamic>>> getPaginatedResults(int page, int pageSize) async {
    final db = await dbHelper.database;
    final results = await db.rawQuery('''
    SELECT * FROM YourTable
    LIMIT ? OFFSET ?
  ''', [pageSize, (page - 1) * pageSize]);

    return results;
  }
  Future<List<CardItem>> getItemsByDateRange(DateTime startDate, DateTime endDate) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE createdAt >= ? AND createdAt <= ?
  ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });


  }
  Future<List<CardItem>> getItemsByName(String name) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('CardItem',
        where: 'name = ?',
        whereArgs: [name]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getItemsByDescriptionKeyword(String keyword) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('CardItem',
        where: 'description LIKE ?',
        whereArgs: ['%$keyword%']);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<double> calculateAverageValue() async {
    final db = await dbHelper.database;
    final result = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT AVG(price * (1 - discount / 100)) AS average_value
    FROM CardItem
  '''));
    return result?.toDouble() ?? 0.0;
  }

  // Future<double> calculateAverageValue() async {
  //   final db = await dbHelper.database;
  //   final result = Sqflite.firstIntValue(await db.rawQuery('''
  //   SELECT AVG(value) AS average_value
  //   FROM CardItem
  // '''));
  //   return result?.toDouble() ?? 0.0;
  // }
  // Future<int> findMaxValue() async {
  //   final db = await dbHelper.database;
  //   final result = Sqflite.firstIntValue(await db.rawQuery('''
  //   SELECT MAX(value) AS max_value
  //   FROM CardItem
  // '''));
  //   return result ?? 0;
  // }
  Future<int> findMaxPrice() async {
    final db = await dbHelper.database;
    final result = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT MAX(price) AS price
    FROM CardItem
  '''));
    return result ?? 0;
  }
  Future<List<String>> getDistinctNames() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT DISTINCT name
    FROM CardItem
  ''');

    return maps.map((map) => map['name'] as String).toList();
  }


  Future<List<CardItem>> getLatestItems(int n) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY createdAt DESC
    LIMIT ?
  ''', [n]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<int> countItems() async {
    final db = await dbHelper.database;
    final result = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*)
    FROM CardItem
  '''));
    return result ?? 0;
  }
  Future<List<CardItem>> getCardsWithQuantityGreaterThan(int quantity) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE qty > ?
  ''', [quantity]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> getCardsWithDiscountGreaterThan(double discount) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE discount > ?
  ''', [discount]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> getCardsInPriceRange(double minPrice, double maxPrice) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE price BETWEEN ? AND ?
  ''', [minPrice, maxPrice]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getCardsSortedByName() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY name ASC
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getCardsWithQuantityLessThan(int quantity) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE qty < ?
  ''', [quantity]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getCardsWithDiscountLessThan(double discount) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE discount < ?
  ''', [discount]);

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getCardsSortedByPriceDescending() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY price DESC
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> getCardsSortedByQuantityAscending() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY qty ASC
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }


  Future<void> clearOldCardData() async {
    final db = await dbHelper.database;
    final currentTime = DateTime.now().toIso8601String();

    // Define a threshold for clearing old data, e.g., data older than 30 days
    final thresholdDate = DateTime.now().subtract(Duration(days: 30)).toIso8601String();

    // Delete data that is older than the threshold date
    await db.delete(
      'CardItem',
      where: 'createdAt < ?',
      whereArgs: [thresholdDate],
    );
  }
  Future<List<CardItem>> getMorePaginatedAndSortedDataWithDateFilter({
    required int page,
    required int pageSize,
    required bool ascending,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await dbHelper.database;
    final sortOrder = ascending ? 'ASC' : 'DESC';
    final offset = (page - 1) * pageSize;

    // Fetch the new page of data
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM CardItem
      WHERE createdAt BETWEEN ? AND ?
      ORDER BY createdAt $sortOrder
      LIMIT ? OFFSET ?
    ''', [
      startDate.toIso8601String(),
      endDate.toIso8601String(),
      pageSize,
      offset,
    ]);

    // Clear old data after fetching the new page
    await clearOldCardData();

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> getCardsSortedByDate(bool ascending) async {
    final db = await dbHelper.database;
    final sortOrder = ascending ? 'ASC' : 'DESC';

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    ORDER BY createdAt $sortOrder
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<void> insertAllCardItems(List<CardItem> cardItems) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (final cardItem in cardItems) {
        await txn.insert('CardItem', cardItem.toMap());
      }
    });
  }
  Future<void> insertAllCardItemsSimplicity(List<CardItem> cardItems) async {
    final db = await dbHelper.database;

    // Use a transaction to ensure all or none of the records are inserted
    await db.transaction((txn) async {
      for (final cardItem in cardItems) {
        await txn.insert(
          'CardItem',
          cardItem.toMap(), // Convert the CardItem object to a map
          conflictAlgorithm: ConflictAlgorithm.replace, // Use REPLACE for simplicity
        );
      }
    });
  }

  Future<int> deleteAllCardItems() async {
    final db = await dbHelper.database;
    return await db.delete('CardItem');
  }

  Future<List<CardItem>> findCardItemsCreatedBefore(DateTime date) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'createdAt < ?',
      whereArgs: [date.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> findCardItemsWithDiscount() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'discount > 0',
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> findCardItemsByNameAndCategory(String name, String category) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'name = ? AND category = ?',
      whereArgs: [name, category],
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<int> countCardItemsWithQuantityLessThan(int quantity) async {
    final db = await dbHelper.database;
    final result = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM CardItem WHERE qty < ?', [quantity]));

    return result ?? 0;
  }
  Future<int> updateCardItemsByCategory(String oldCategory, String newCategory) async {
    final db = await dbHelper.database;
    return await db.update(
      'CardItem',
      {'category': newCategory},
      where: 'category = ?',
      whereArgs: [oldCategory],
    );
  }
  Future<List<CardItem>> findCardItemsInPriceRange(double minPrice, double maxPrice) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CardItem',
      where: 'price BETWEEN ? AND ?',
      whereArgs: [minPrice, maxPrice],
    );

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }
  Future<List<CardItem>> findCardItemsWithCategoryAdvance() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT CardItem.*, Category.name AS categoryName
    FROM CardItem
    INNER JOIN Category ON CardItem.categoryId = Category.id
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<CardItem>> findItemsWithMaxPriceInEachCategory() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT ci.*
    FROM CardItem ci
    WHERE ci.price = (
      SELECT MAX(price)
      FROM CardItem
      WHERE categoryId = ci.categoryId
    )
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }

  Future<List<Map<String, dynamic>>> calculateTotalSpentByCategory() async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('''
    SELECT Category.name, SUM(CardItem.price) AS total_spent
    FROM CardItem
    INNER JOIN Category ON CardItem.categoryId = Category.id
    GROUP BY Category.name
  ''');

    return result;
  }

  Future<List<CardItem>> findItemsMatchingComplexCriteria() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT *
    FROM CardItem
    WHERE (name LIKE '%keyword1%' OR name LIKE '%keyword2%')
      AND (price > 100 OR (qty > 10 AND discount > 0.1))
  ''');

    return List.generate(maps.length, (i) {
      return CardItem.fromMap(maps[i]);
    });
  }


}
