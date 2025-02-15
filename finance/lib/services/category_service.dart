import 'database_helper.dart';
import '../models/category_model.dart';
import '../models/category_mapper.dart';

class CategoryService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final String table = 'categories';

  Future<List<Category>> getAllCategories() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => CategoryMapper.fromDatabase(map)).toList();
  }

  Future<int> addCategory(Category category) async {
    final db = await DatabaseHelper.instance.database;
    final mapper = CategoryMapper(
      id: category.id,
      category: category.category,
      icon: category.icon,
    );
    return await db.insert(table, mapper.toDatabase());
  }

  Future<int> deleteCategory(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateCategory(Category category) async {
    final db = await DatabaseHelper.instance.database;
    final mapper = CategoryMapper(
      id: category.id,
      category: category.category,
      icon: category.icon
    );
    return await db.update(
      table,
      mapper.toDatabase(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}