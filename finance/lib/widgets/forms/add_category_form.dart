import 'package:flutter/material.dart';
import '../../services/category_service.dart';
import '../../models/category_model.dart';

class AddCategoryForm extends StatefulWidget {
  final Function(Category) onAdd;
  final Category? initialTransaction;

  const AddCategoryForm({
    super.key,
    required this.onAdd,
    this.initialTransaction,
  });

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final CategoryService categoryService = CategoryService();
  String? _categoryName;
  int? _selectedIcon;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final category = Category(
        id: widget.initialTransaction?.id,
        category: _categoryName!,
        icon: _selectedIcon ?? 0,
      );
      widget.onAdd(category);
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTransaction != null ? "Modifier la categorie" : "Ajouter une categorie"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom de la catégorie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
                onSaved: (value) => _categoryName = value,
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  for(var icon in [Icons.home, Icons.shopping_bag])
                  IconButton(
                    icon: Icon(icon),
                    color: _selectedIcon == icon.codePoint ? Colors.blue : null,
                    onPressed: () {
                      setState(() {
                        _selectedIcon = icon.codePoint;
                      });
                    })
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text("Annuler")),
        ElevatedButton(
          onPressed: _submitForm, 
          child: Text(widget.initialTransaction != null ? "Modifier" : "Ajouter")),
      ],
    );
  }
}
