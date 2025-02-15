import 'package:flutter/material.dart';
import '../../services/icons_service.dart';
import '../../models/icons_model.dart';

class IconPicker extends StatefulWidget {
  final Function(int) onIconSelected;

  const IconPicker({super.key, required this.onIconSelected});

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  int? _selectedIcon;
  List<IconItem> _icons = [];

  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  Future<void> _loadIcons() async {
    final icons = await IconsService().getAllIcons();
    setState(() {
      _icons = icons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: _selectedIcon == null 
          ? const Icon(Icons.add, color: Colors.black)
          : Icon(IconData(_selectedIcon!, fontFamily: 'MaterialIcons'), color: Colors.black),
      onSelected: (int selected) {
        setState(() {
          _selectedIcon = selected;
        });
        widget.onIconSelected(selected);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<int>(
          enabled: false,
          child: SizedBox(
            width: 300,
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: _icons.map((icon) {
                return IconButton(
                  icon: Icon(IconData(icon.codePoint, fontFamily: 'MaterialIcons'), color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context, icon.codePoint);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
