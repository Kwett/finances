import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/icons_service.dart';
import '../../models/icons_model.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Category selectedCategory;
  final ValueChanged<Category?> onChanged;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IconItem>>(
      future: IconsService().getAllIcons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('Erreur chargement des icônes');
        }

        final icons = snapshot.data!;

        return DropdownButtonFormField<Category>(
          value: selectedCategory,
          decoration: const InputDecoration(labelText: "Catégorie"),
          items: categories.map((category) {
            final icon = icons.firstWhere((i) => i.id == category.iconId, orElse: () => IconItem(id: 1, codePoint: Icons.error.codePoint, name: 'Erreur'));

            return DropdownMenuItem<Category>(
              value: category,
              child: Row(
                children: [
                  Icon(
                    IconData(icon.codePoint, fontFamily: 'MaterialIcons'),
                    color: Color(category.color),
                  ),
                  const SizedBox(width: 10),
                  Text(category.category),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
