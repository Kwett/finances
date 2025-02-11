import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class Recap extends StatelessWidget {
  final double revenu;
  final double depenses;
  final double total;

  const Recap({
    super.key,
    required this.revenu,
    required this.depenses,
    required this.total,
  });

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
              const Text(
                "Revenu",
                style: ThemeConfig.recapStyle,
              ),
              const Spacer(),
              Text(
                "€${revenu.toStringAsFixed(2)}",
                style: ThemeConfig.recapStyle.copyWith(color: const Color.fromARGB(255, 32, 110, 35)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Text(
                "Dépenses",
                style: ThemeConfig.recapStyle,
              ),
              const Spacer(),
              Text(
                "€${depenses.toStringAsFixed(2)}",
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
                "€${total.toStringAsFixed(2)}",
                style: ThemeConfig.recapStyle.copyWith(color: const Color.fromARGB(255, 32, 110, 35), fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
