import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class AddCategoryForm extends StatefulWidget {
  final Function(Category) onAdd;

  const AddCategoryForm({super.key, required this.onAdd});

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? _categoryName;
  int? _selectedIconId;
  int _selectedColor = Colors.black.value;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final category = Category(
        category: _categoryName!,
        iconId: _selectedIconId ?? 1,
        color: _selectedColor,
      );

      widget.onAdd(category); // Appelle la fonction fournie par AddTransactionForm
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter une catégorie'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom de la catégorie'),
              validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) => _categoryName = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
