import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/app_page.dart';
import 'config/theme_config.dart';
import 'services/category_service.dart';
import 'models/category_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr', null);

  // Test CategoryService
  final categoryService = CategoryService();
  final newCategory = Category(
    category: 'TestCat',
    iconId: 1,
    color: Colors.blue.value,
  );

  await categoryService.addCategory(newCategory);
  final allCategories = await categoryService.getAllCategories();
  print('Catégories récupérées: ${allCategories.map((c) => c.category).toList()}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.appTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AppPage(title: 'Transactions', icon: 'assets/icons/transaction.svg', isDropdown: true),
    const AppPage(title: 'Vos Comptes', icon: 'assets/icons/account.svg', isDropdown: false),
    const AppPage(title: 'Statistiques', icon: 'assets/icons/stats.svg', isDropdown: false),
    ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(206, 255, 255, 255),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Vos comptes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiques',
          ),
        ],
      ),
    );
  }
}
