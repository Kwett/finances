import 'package:flutter/material.dart';
import '../models/transactions_model.dart';

class TestSet {
  final List<TransactionDay> dailyTransaction = [
    TransactionDay(
      date: DateTime(2025, 2, 11),
      totalSpent: 83.98,
      transactions: [
        TransactionItem(name: "Autre", amount: 83.98, icon: Icons.category),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 10),
      totalSpent: -22.90,
      transactions: [
        TransactionItem(name: "Transport", amount: -37.85, icon: Icons.directions_bus),
        TransactionItem(name: "Logement", amount: 14.95, icon: Icons.home),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 9),
      totalSpent: 39.74,
      transactions: [
        TransactionItem(name: "Loisirs", amount: -9.13, icon: Icons.movie),
        TransactionItem(name: "Courses", amount: 57.88, icon: Icons.shopping_cart),
        TransactionItem(name: "Santé", amount: 5.53, icon: Icons.local_hospital),
        TransactionItem(name: "Transport", amount: -14.54, icon: Icons.directions_car),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 8),
      totalSpent: 22.27,
      transactions: [
        TransactionItem(name: "Courses", amount: 10.92, icon: Icons.shopping_bag),
        TransactionItem(name: "Transport", amount: 11.35, icon: Icons.train),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 7),
      totalSpent: 118.79,
      transactions: [
        TransactionItem(name: "Loisirs", amount: -53.12, icon: Icons.sports_esports),
        TransactionItem(name: "Loisirs", amount: 71.11, icon: Icons.music_note),
        TransactionItem(name: "Autre", amount: 46.35, icon: Icons.category),
        TransactionItem(name: "Restaurant", amount: 54.45, icon: Icons.fastfood),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 6),
      totalSpent: -80.14,
      transactions: [
        TransactionItem(name: "Transport", amount: 55.91, icon: Icons.directions_bus),
        TransactionItem(name: "Restaurant", amount: 78.82, icon: Icons.restaurant),
        TransactionItem(name: "Cadeaux", amount: -61.38, icon: Icons.card_giftcard),
        TransactionItem(name: "Logement", amount: -86.22, icon: Icons.home),
        TransactionItem(name: "Santé", amount: -67.27, icon: Icons.healing),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 5),
      totalSpent: 38.58,
      transactions: [
        TransactionItem(name: "Restaurant", amount: 43.13, icon: Icons.restaurant),
        TransactionItem(name: "Courses", amount: -77.59, icon: Icons.local_grocery_store),
        TransactionItem(name: "Autre", amount: 73.04, icon: Icons.category),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 4),
      totalSpent: 180.12,
      transactions: [
        TransactionItem(name: "Autre", amount: -36.41, icon: Icons.category),
        TransactionItem(name: "Logement", amount: 66.19, icon: Icons.apartment),
        TransactionItem(name: "Transport", amount: 17.6, icon: Icons.train),
        TransactionItem(name: "Courses", amount: 68.59, icon: Icons.local_mall),
        TransactionItem(name: "Restaurant", amount: 64.15, icon: Icons.fastfood),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 3),
      totalSpent: -45.04,
      transactions: [
        TransactionItem(name: "Transport", amount: -25.3, icon: Icons.directions_car),
        TransactionItem(name: "Cadeaux", amount: -78.63, icon: Icons.card_giftcard),
        TransactionItem(name: "Courses", amount: 37.32, icon: Icons.shopping_cart),
        TransactionItem(name: "Courses", amount: 21.57, icon: Icons.shopping_cart),
      ],
    ),
    TransactionDay(
      date: DateTime(2025, 2, 2),
      totalSpent: -124.49,
      transactions: [
        TransactionItem(name: "Loisirs", amount: 12.56, icon: Icons.movie),
        TransactionItem(name: "Santé", amount: -75.98, icon: Icons.local_hospital),
        TransactionItem(name: "Santé", amount: -72.38, icon: Icons.medical_services),
        TransactionItem(name: "Transport", amount: 11.31, icon: Icons.directions_bus),
      ],
    ),
  ];

  TestSet();

  List<TransactionDay> getDataSet() {
    return dailyTransaction;
  }
}
