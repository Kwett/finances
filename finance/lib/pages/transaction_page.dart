import 'package:flutter/material.dart';
import '../widgets/common/month_selector.dart';
import '../widgets/common/transactions_summary.dart';
import '../widgets/transactions/transactions_list.dart';
import '../models/transactions_model.dart';
import '../data/mock_transactions.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  DateTime selectedMonth = DateTime.now();
  List<TransactionDay> dailyTransactions = TestSet().getDataSet();

  void _updateMonth(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            MonthSelector(
              selectedMonth: selectedMonth,
              onMonthChanged: _updateMonth,
            ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(207, 255, 255, 255),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Recap(revenu: 200.0, depenses: 193.0, total: 300.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dailyTransactions.length,
                      itemBuilder: (context, index) {
                        final day = dailyTransactions[index];
                        return DailyTransactions(
                          date: day.date,
                          totalSpent: day.totalSpent,
                          transactions: day.transactions,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
