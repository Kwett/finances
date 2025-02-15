import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme_config.dart';
import '../../models/transactions_item_model.dart';
import '../../services/transactions_service.dart';
import '../forms/add_transaction_form.dart';

class TransactionsList extends StatelessWidget {
  final DateTime date;
  final double totalSpent;
  final List<TransactionItem> transactions;
  final VoidCallback onTransactionUpdated;

  const TransactionsList({
    super.key,
    required this.date,
    required this.totalSpent,
    required this.transactions,
    required this.onTransactionUpdated,
  });

  String _formatDate(DateTime date, String pattern) => DateFormat(pattern, "fr_FR").format(date);

  void _showContextMenu(BuildContext context, TransactionItem transaction) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Éditer"),
            onTap: () {
              Navigator.pop(ctx);
              showDialog(
                context: context,
                builder: (ctx) => AddTransactionForm(
                  onAdd: (updatedTransaction) async {
                    await TransactionService().updateTransaction(updatedTransaction);
                    onTransactionUpdated();
                  },
                  initialTransaction: transaction.copyWith(amount: transaction.amount.abs()),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Supprimer"),
            onTap: () async {
              await TransactionService().deleteTransaction(transaction.id!);
              onTransactionUpdated();
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildTransactionList(context),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      decoration: const BoxDecoration(color: Color.fromARGB(206, 50, 100, 199)),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _formatDate(date, "dd"),
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
                  Text(_formatDate(date, "EEEE"), style: ThemeConfig.dateStyle),
                  Text(_formatDate(date, "MMM yyyy"), style: ThemeConfig.dateStyle),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            "€${totalSpent.toStringAsFixed(2)}",
            style: ThemeConfig.dateStyle.copyWith(fontSize: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildTransactionItem(context, transaction, index);
      },
    );
  }

  Widget _buildTransactionItem(BuildContext context, TransactionItem transaction, int index) {
    return GestureDetector(
      onLongPress: () => _showContextMenu(context, transaction),
      child: Container(
        color: index.isEven
            ? const Color.fromARGB(110, 255, 255, 255)
            : const Color.fromARGB(55, 148, 147, 147),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          minVerticalPadding: 0,
          leading: Icon(IconData(transaction.categoryId, fontFamily: 'MaterialIcons'), color: Colors.grey[700], size: 24),
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
      ),
    );
  }
}
