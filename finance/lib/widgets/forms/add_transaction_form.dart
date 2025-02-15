import 'package:finance/models/category_model.dart';
import 'package:finance/services/category_service.dart';
import 'package:flutter/material.dart';
import '../../models/transactions_item_model.dart';
import '../../widgets/forms/add_category_form.dart';

class AddTransactionForm extends StatefulWidget {
  final Function(TransactionItem) onAdd;
  final TransactionItem? initialTransaction;

  const AddTransactionForm({
    super.key,
    required this.onAdd,
    this.initialTransaction,
  });

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  Category? _selectedCategory;
  late bool _isExpense;
  late TabController _tabController;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTransaction?.name ?? '');
    _amountController = TextEditingController(text: widget.initialTransaction?.amount.toString() ?? '');
    _selectedDate = widget.initialTransaction != null ? DateTime.parse(widget.initialTransaction!.date) : DateTime.now();
    _isExpense = widget.initialTransaction?.amount.isNegative ?? true;
    _tabController = TabController(length: 2, vsync: this, initialIndex: _isExpense ? 0 : 1);
    _tabController.addListener(() => setState(() => _isExpense = _tabController.index == 0));
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categoryService = CategoryService();
    final categories = await categoryService.getAllCategories();
    if (categories.isEmpty) {
      _categories = await categoryService.getAllCategories();
    } else {
      _categories = categories;
    }
    setState(() => _selectedCategory = _categories.first);
  }

  void _addCategory() {
  showDialog(
    context: context,
    builder: (context) => AddCategoryForm(
      onAdd: (category) async {
        await CategoryService().addCategory(category); // Un seul appel ici
        await _loadCategories();
      },
    ),
);

  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final transaction = TransactionItem(
        id: widget.initialTransaction?.id,
        accountID: widget.initialTransaction?.accountID ?? 1,
        name: _titleController.text,
        description: widget.initialTransaction?.description ?? '',
        amount: _isExpense ? -double.parse(_amountController.text) : double.parse(_amountController.text),
        date: _selectedDate.toIso8601String(),
        icon: _selectedCategory!.iconId,
      );
      widget.onAdd(transaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTransaction != null ? "Modifier la transaction" : "Ajouter une transaction"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(controller: _tabController, tabs: const [Tab(text: "Dépense"), Tab(text: "Revenu")]),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: "Date", border: OutlineInputBorder()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"), const Icon(Icons.calendar_today)],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: "Nom"), validator: (value) => value!.isEmpty ? "Veuillez entrer un nom" : null),
              const SizedBox(height: 10),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: "Catégorie"),
                items: _categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(IconData(category.iconId, fontFamily: 'MaterialIcons'), color: Color(category.color)),
                        const SizedBox(width: 10),
                        Text(category.category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              ElevatedButton(onPressed: _addCategory, child: const Icon(Icons.add, size: 28)),
              const SizedBox(height: 10),
              TextFormField(controller: _amountController, decoration: const InputDecoration(labelText: "Montant"), keyboardType: TextInputType.number, validator: (value) => value == null || double.tryParse(value) == null || double.parse(value) <= 0 ? "Montant invalide" : null),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Annuler")),
        ElevatedButton(onPressed: _submitForm, child: Text(widget.initialTransaction != null ? "Modifier" : "Ajouter")),
      ],
    );
  }
}
