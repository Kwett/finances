import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme_config.dart';

class MonthSelector extends StatefulWidget {
  final DateTime selectedMonth;
  final Function(DateTime) onMonthChanged;

  const MonthSelector({
    super.key,
    required this.selectedMonth,
    required this.onMonthChanged,
  });

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    currentMonth = widget.selectedMonth;
  }

  void _changeMonth(int increment) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + increment, 1);
      widget.onMonthChanged(currentMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _changeMonth(-1),
        ),
        Text(
          DateFormat.yMMMM('fr').format(currentMonth),
          style: ThemeConfig.basicStyle,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _changeMonth(1),
        ),
      ],
    );
  }
}
