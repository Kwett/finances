import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme_config.dart';
import '../../models/transactions_model.dart';

class DailyTransactions extends StatelessWidget {
  final DateTime date;
  final double totalSpent;
  final List<TransactionItem> transactions;

  const DailyTransactions({
    super.key,
    required this.date,
    required this.totalSpent,
    required this.transactions,
  });

  String _getDayNumber(DateTime date) => DateFormat("dd", "fr_FR").format(date);
  String _getWeekday(DateTime date) => DateFormat("EEEE", "fr_FR").format(date);
  String _getMonthYear(DateTime date) => DateFormat("MMM yyyy", "fr_FR").format(date);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(206, 50, 100, 199),
          ),
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _getDayNumber(date),
                    style: ThemeConfig.dateStyle.copyWith(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getWeekday(date),
                        style: ThemeConfig.dateStyle,
                      ),
                      Text(
                        _getMonthYear(date),
                        style: ThemeConfig.dateStyle,
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Text(
                "€${totalSpent.toStringAsFixed(2)}",
                style: ThemeConfig.dateStyle.copyWith(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            return Container(
              color: index.isEven 
                  ? const Color.fromARGB(110, 255, 255, 255)
                  : const Color.fromARGB(55, 148, 147, 147),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                minVerticalPadding: 0,
                leading: Icon(transaction.icon, color: Colors.grey[700], size: 24), 
                title: Text(
                  transaction.name,
                  style: ThemeConfig.recapStyle.copyWith(fontSize: 16),
                ),
                trailing: Text(
                  "€${transaction.amount.toStringAsFixed(2)}",
                  style: ThemeConfig.recapStyle.copyWith(
                    fontSize: 20,
                    color: transaction.amount > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
