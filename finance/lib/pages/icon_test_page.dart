import 'package:flutter/material.dart';
import '../../services/icons_service.dart';
import '../../models/icons_model.dart';

class IconTestPage extends StatelessWidget {
  const IconTestPage({super.key});

  Future<IconItem> _fetchIcon() async {
    return await IconsService().getIconById(1); // Exemple avec l'ID 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Icône DB')),
      body: Center(
        child: FutureBuilder<IconItem>(
          future: _fetchIcon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Erreur de chargement de l\'icône');
            }
            if (!snapshot.hasData) {
              return const Text('Aucune icône trouvée');
            }

            final icon = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  IconData(icon.codePoint, fontFamily: 'MaterialIcons'),
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text('Nom: ${icon.name}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
