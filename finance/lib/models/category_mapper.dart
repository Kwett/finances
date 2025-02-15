import '../models/category_model.dart' as model;

class CategoryMapper {
  final int? id;
  final String category;
  final int iconId;
  final int color;

  CategoryMapper({
    this.id,
    required this.category,
    required this.iconId,
    required this.color
  });

    Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'category': category,
      'icon_id': iconId,
      'color': color
    };
  }

  static model.Category fromDatabase(Map<String, dynamic> map) {
    return model.Category(
      id: map['id'] as int?,
      category: map['category'] as String,
      iconId: map['icon_id'] as int,
      color: map['color'] as int
    );
  }
}