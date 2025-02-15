import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'finance.db');
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE icons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code_point INTEGER NOT NULL,
        name TEXT NOT NULL
        );
      ''');

    await db.execute('''
      INSERT INTO icons (code_point, name) VALUES
      (${Icons.home.codePoint}, 'Logement'),
      (${Icons.shopping_cart.codePoint}, 'Shopping'),
      (${Icons.fastfood.codePoint}, 'Restauration'),
      (${Icons.local_gas_station.codePoint}, 'Carburant'),
      (${Icons.shopping_bag.codePoint}, 'Courses'),
      (${Icons.local_movies.codePoint}, 'Divertissement'),
      (${Icons.local_hospital.codePoint}, 'Santé'),
      (${Icons.paid.codePoint}, 'Paiements'),
      (${Icons.attach_money.codePoint}, 'Salaire'),
      (${Icons.savings.codePoint}, 'Épargne'),
      (${Icons.account_balance.codePoint}, 'Banque'),
      (${Icons.trending_up.codePoint}, 'Investissements'),
      (${Icons.card_giftcard.codePoint}, 'Cadeaux'),
      (${Icons.money_off.codePoint}, 'Remboursements'),
      (${Icons.directions_car.codePoint}, 'Transport'),
      (${Icons.phone_android.codePoint}, 'Télécommunications'),
      (${Icons.child_care.codePoint}, 'Famille'),
      (${Icons.pets.codePoint}, 'Animaux'),
      (${Icons.fitness_center.codePoint}, 'Sport'),
      (${Icons.school.codePoint}, 'Éducation'),
      (${Icons.list.codePoint}, 'Transactions'),
      (${Icons.bar_chart.codePoint}, 'Statistiques'),
      (${Icons.settings.codePoint}, 'Paramètres'),
      (${Icons.calendar_today.codePoint}, 'Calendrier'),
      (${Icons.credit_card.codePoint}, 'Carte Bancaire'),
      (${Icons.receipt.codePoint}, 'Factures'),
      (${Icons.luggage.codePoint}, 'Voyages'),
      (${Icons.music_note.codePoint}, 'Abonnements'),
      (${Icons.construction.codePoint}, 'Réparations'),
      (${Icons.shopping_basket.codePoint}, 'Achats en ligne'),
      (${Icons.work.codePoint}, 'Travail'),
      (${Icons.dining.codePoint}, 'Restaurants'),
      (${Icons.healing.codePoint}, 'Assurance'),
      (${Icons.directions_bus.codePoint}, 'Transport public'),
      (${Icons.sports_esports.codePoint}, 'Jeux vidéo');
    ''');


    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon_id INTEGER NOT NULL,
        FOREIGN KEY (icon_id) REFERENCES icons(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        icon_id INTEGER NOT NULL,
        color INTEGER NOT NULL,
        FOREIGN KEY (icon_id) REFERENCES icons(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      INSERT INTO categories (category, icon_id, color) VALUES
      ('Autre', 1, ${Colors.black.value});
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
