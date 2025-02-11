import 'package:flutter/material.dart';

class TransactionItem {
  final String name;
  final double amount;
  final IconData icon;

  TransactionItem({required this.name, required this.amount, required this.icon});
}

class TransactionDay {
  final DateTime date;
  final double totalSpent;
  final List<TransactionItem> transactions;

  TransactionDay({required this.date, required this.totalSpent, required this.transactions});

  static fromJson(Map<String, Object> json) {}
}
