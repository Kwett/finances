import 'package:flutter/material.dart';
import '../services/transactions_service.dart';
import '../models/transactions_item_model.dart';
import '../models/daily_transactions_model.dart';
import '../widgets/common/month_selector.dart';
import '../widgets/common/transactions_summary.dart';
import '../widgets/forms/add_transaction_form.dart';
import '../widgets/transactions/transactions_list.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TransactionService transactionService = TransactionService();
  DateTime selectedMonth = DateTime.now();
  List<TransactionItem> transactions = [];
  List<DailyTransactions> groupedTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final allTransactions = await transactionService.getAllTransactions();
    final filteredTransactions = transactionService.filterTransactionsForMonth(allTransactions, selectedMonth);
    final groupedList = transactionService.groupTransactionsByDay(filteredTransactions);

    setState(() {
      transactions = filteredTransactions;
      groupedTransactions = groupedList;
    });
  }

  void _updateMonth(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
    });
    _loadTransactions();
  }

  void _addTransaction() {
    showDialog(
      context: context,
      builder: (context) => AddTransactionForm(
        onAdd: (transaction) async {
          await transactionService.addTransaction(transaction);
          await _loadTransactions();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MonthSelector(selectedMonth: selectedMonth, onMonthChanged: _updateMonth),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color.fromARGB(207, 255, 255, 255)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransactionsSummary(monthTransactions: transactions),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupedTransactions.length,
                      itemBuilder: (context, index) {
                        final dailyTransaction = groupedTransactions[index];
                        return TransactionsList(
                          date: dailyTransaction.date,
                          totalSpent: dailyTransaction.totalSpent,
                          transactions: dailyTransaction.transactions,
                          onTransactionUpdated: _loadTransactions,
                        );
                      },
                    ),
                    const SizedBox(height: 128),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        backgroundColor: Colors.purple,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
