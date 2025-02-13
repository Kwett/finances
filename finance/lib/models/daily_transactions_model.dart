
import 'transactions_item_model.dart';

class DailyTransactions {
  final DateTime date;
  final double totalSpent;
  final List<TransactionItem> transactions;

  const DailyTransactions({
    required this.date,
    required this.totalSpent,
    required this.transactions,
  });
}
