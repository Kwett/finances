import '../models/category_model.dart' as model;

class CategoryMapper {
  final int? id;
  final String category;
  final int icon;

  CategoryMapper({
    this.id,
    required this.category,
    required this.icon
  });

    Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'category': category,
      'icon': icon,
    };
  }

  static model.Category fromDatabase(Map<String, dynamic> map) {
    return model.Category(
      id: map['id'] as int?,
      category: map['category'] as String,
      icon: map['icon'] as int,
    );
  }
}