import 'package:sqflite/sqflite.dart';

import '../../domain/entities/dish.entity.dart';
import '../models/dish.model.dart';

class DishProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table $tableDish (
            $columnId integer primary key autoincrement,
            $columnName text not null,
            $columnRecipe longtext null default null,
            $columnLocation text null default null,
            $columnIconPath longtext null default null
          )''');
      },
    );
  }

  Future<List<DishEntity>> index() async {
    await open(dbPath);
    List<Map> maps = await db.query(tableDish);
    db.close();

    return maps.map((data) => DishModel.fromJson(data)).toList();
  }

  Future<DishModel?> show(int id) async {
    await open(dbPath);
    List<Map> maps = await db.query(
      tableDish,
      columns: ['*'],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DishModel.fromJson(maps.first);
    }
    db.close();

    return null;
  }

  Future<DishEntity> store(DishEntity dish) async {
    await open(dbPath);
    await db.insert(tableDish, dish.toMap());
    db.close();

    return dish;
  }

  Future<bool> destroy(int id) async {
    await open(dbPath);
    await db.delete(
      tableDish,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    db.close();

    return true;
  }
}
