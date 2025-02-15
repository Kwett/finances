import 'package:finance/services/category_service.dart';
import 'package:flutter/material.dart';
import '../../services/transactions_service.dart';
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
  final TransactionService transactionService = TransactionService();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  late bool _isExpense;
  late TabController _tabController;
  List<String> _categories = [];


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTransaction?.name ?? '');
    _amountController = TextEditingController(text: widget.initialTransaction?.amount.toString() ?? '');
    _selectedDate = widget.initialTransaction != null ? DateTime.parse(widget.initialTransaction!.date) : DateTime.now();
    _selectedCategory = 'Autre';
    _isExpense = widget.initialTransaction?.amount.isNegative ?? true;

    _tabController = TabController(length: 2, vsync: this, initialIndex: _isExpense ? 0 : 1);
    _tabController.addListener(() => setState(() => _isExpense = _tabController.index == 0));
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categoryService = CategoryService();
    final categories = await categoryService.getAllCategories();
    setState(() {
       _categories = categories.map((c) => c.category).toSet().toList();
    });
    if (!_categories.contains('Autre')) {
      _categories.add('Autre');
    }
  }

  void _addCategory() {
    final categoryService = CategoryService();

    showDialog(
      context: context,
      builder: (context) => AddCategoryForm(
        onAdd: (category) async {
           await categoryService.addCategory(category);
           await _loadCategories();
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);
      final transaction = TransactionItem(
        id: widget.initialTransaction?.id,
        accountID: widget.initialTransaction?.accountID ?? 1,
        name: title,
        description: widget.initialTransaction?.description ?? '',
        amount: _isExpense ? -amount : amount,
        date: _selectedDate.toIso8601String(),
        icon: widget.initialTransaction?.icon ?? 0,
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
              DropdownButtonFormField<String>(
                value: _selectedCategory, 
                decoration: const InputDecoration(labelText: "Catégorie"), 
                items: _categories.map((c) => 
                  DropdownMenuItem(value: c, child: Text(c))).toList(), 
                onChanged: (value) => setState(() => _selectedCategory = value!)),
              ElevatedButton(
                onPressed: _addCategory,
                child: const Icon(Icons.add, size: 28), 
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _amountController, 
                decoration: const InputDecoration(labelText: "Montant"), 
                keyboardType: TextInputType.number, validator: (value) => 
                  value == null || double.tryParse(value) == null || double.parse(value) <= 0 ? "Montant invalide" : null),
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
