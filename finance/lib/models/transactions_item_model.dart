class TransactionItem {
  final int? id;
  final int accountID;
  final String name;
  final String description;
  final double amount;
  final String date;
  final int categoryId;

  const TransactionItem({
    this.id,
    required this.accountID,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
  });

  TransactionItem copyWith({
    int? id,
    int? accountID,
    String? name,
    String? description,
    double? amount,
    String? date,
    int? categoryId,
  }) {
    return TransactionItem(
      id: id ?? this.id,
      accountID: accountID ?? this.accountID,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
