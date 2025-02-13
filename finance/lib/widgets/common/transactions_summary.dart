import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../models/transactions_item_model.dart';

class TransactionsSummary extends StatelessWidget {
  final List<TransactionItem> monthTransactions;

  const TransactionsSummary({
    super.key,
    required this.monthTransactions,
  });

  double get _income => monthTransactions
      .where((t) => t.amount > 0)
      .fold(0.0, (sum, t) => sum + t.amount);
  double get _expense => monthTransactions
      .where((t) => t.amount <= 0)
      .fold(0.0, (sum, t) => sum + t.amount);
  double get _total => _income + _expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Revenu", style: ThemeConfig.recapStyle),
              const Spacer(),
              Text(
                "€${_income.toStringAsFixed(2)}",
                style: ThemeConfig.recapStyle.copyWith(
                  color: const Color.fromARGB(255, 32, 110, 35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Dépenses", style: ThemeConfig.recapStyle),
              const Spacer(),
              Text(
                "€${_expense.toStringAsFixed(2)}",
                style: ThemeConfig.recapStyle.copyWith(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Total",
                style: ThemeConfig.recapStyle.copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Text(
                "€${_total.toStringAsFixed(2)}",
                style: ThemeConfig.recapStyle.copyWith(
                  color: const Color.fromARGB(255, 32, 110, 35),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
