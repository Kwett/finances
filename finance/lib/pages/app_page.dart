import 'package:flutter/material.dart';
import 'package:finance/pages/transaction_page.dart';
import '../widgets/common/header.dart';
import '../widgets/layout/background_container.dart';

class AppPage extends StatelessWidget {
  final String title;
  final String icon;
  final bool isDropdown;

  const AppPage({super.key, required this.title, required this.icon, this.isDropdown = false});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Header(icon: icon, title: title, isDropdown: isDropdown),
          ),

          if (title == 'Transactions') 
            Positioned.fill(
              top: 120,
              child: TransactionPage(),
            ),
        ],
      ),
    );
  }
}
