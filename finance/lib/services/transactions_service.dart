import '../models/transactions_item_model.dart';
import '../models/daily_transactions_model.dart';
import '../models/transactions_mapper.dart';
import 'database_helper.dart';

class TransactionService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<List<TransactionItem>> getAllTransactions() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return maps.map((map) => TransactionsMapper.fromDatabase(map)).toList();
  }

  Future<int> addTransaction(TransactionItem transaction) async {
    final db = await DatabaseHelper.instance.database;
    final mapper = TransactionsMapper(
      id: transaction.id,
      accountID: transaction.accountID,
      name: transaction.name,
      description: transaction.description,
      amount: transaction.amount,
      date: transaction.date,
      icon: transaction.icon,
    );
    return await db.insert('transactions', mapper.toDatabase());
  }

  Future<int> deleteTransaction(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTransaction(TransactionItem transaction) async {
    final db = await DatabaseHelper.instance.database;
    final mapper = TransactionsMapper(
      id: transaction.id,
      accountID: transaction.accountID,
      name: transaction.name,
      description: transaction.description,
      amount: transaction.amount,
      date: transaction.date,
      icon: transaction.icon,
    );
    return await db.update(
      'transactions',
      mapper.toDatabase(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  List<TransactionItem> filterTransactionsForMonth(List<TransactionItem> transactions, DateTime month) {
    return transactions.where((transaction) {
      final date = DateTime.parse(transaction.date);
      return date.year == month.year && date.month == month.month;
    }).toList();
  }

  List<DailyTransactions> groupTransactionsByDay(List<TransactionItem> transactions) {
    final Map<DateTime, List<TransactionItem>> groupedMap = {};
    for (final transaction in transactions) {
      final date = DateTime.parse(transaction.date);
      final onlyDate = DateTime(date.year, date.month, date.day);
      groupedMap.putIfAbsent(onlyDate, () => []).add(transaction);
    }

    return groupedMap.entries.map((entry) {
      final totalSpent = entry.value.fold(0.0, (sum, item) => sum + item.amount);
      return DailyTransactions(
        date: entry.key,
        totalSpent: totalSpent,
        transactions: entry.value,
      );
    }).toList();
  }
}
