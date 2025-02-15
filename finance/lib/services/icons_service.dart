import 'database_helper.dart';
import '../models/icons_model.dart';

class IconsService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final table = 'icons';

  Future<List<IconItem>> getAllIcons() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => IconItem(
      id: map['id'] as int,
      codePoint: map['code_point'] as int,
      name: map['name'] as String,
    )).toList();
  }

  Future<IconItem> getIconById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return IconItem(
        id: maps.first['id'] as int,
        codePoint: maps.first['code_point'] as int,
        name: maps.first['name'] as String,
      );
    } else {
      throw Exception('Icône non trouvée');
    }
  }
}
