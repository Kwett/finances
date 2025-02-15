import 'package:sqflite/sqflite.dart';
import '../services/database_helper.dart';
import '../models/category_model.dart';
import '../models/category_mapper.dart';

class CategoryService {
  final dbHelper = DatabaseHelper.instance;
  final String table = 'categories';

  Future<int> addCategory(Category category) async {
    final db = await dbHelper.database;
    final mapper = CategoryMapper(
      category: category.category,
      iconId: category.iconId,
      color: category.color,
    );
    try {
      final id = await db.insert(
        table,
        mapper.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Catégorie ajoutée avec l\'id: $id');
      return id;
    } catch (e) {
      print('Erreur lors de l\'ajout: $e');
      return -1;
    }
  }

  Future<List<Category>> getAllCategories() async {
    final db = await dbHelper.database;
    final result = await db.query(table);
    return result.map((e) => CategoryMapper.fromDatabase(e)).toList();
  }
}
