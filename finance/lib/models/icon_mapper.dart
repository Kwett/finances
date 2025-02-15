import 'icons_model.dart';

class IconMapper {
  final int? id;
  final int codePoint;
  final String name;

  IconMapper({
    this.id,
    required this.codePoint,
    required this.name
  });

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'code_point' : codePoint,
      'name' : name,
    };
  }

  static IconItem fromDatabase(Map<String, dynamic> map) {
    return IconItem(
      id : map['id'] as int?,
      codePoint: map['code_point'] as int,
      name: map['name'] as String,
    );
  }
}