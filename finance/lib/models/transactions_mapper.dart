import 'transactions_item_model.dart';

class TransactionsMapper {
  final int? id;
  final int accountID;
  final String name;
  final String description;
  final double amount;
  final String date;
  final int icon;

  TransactionsMapper({
    this.id,
    required this.accountID,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.icon,
  });

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'account_id': accountID,
      'name': name,
      'description': description,
      'amount': amount,
      'date': date,
      'icon': icon,
    };
  }

  static TransactionItem fromDatabase(Map<String, dynamic> map) {
    return TransactionItem(
      id: map['id'] as int?,
      accountID: map['account_id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: map['date'] as String,
      icon: map['icon'] as int,
    );
  }
}
