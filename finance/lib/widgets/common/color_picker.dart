import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final Function(int) onSelectedColor; // Change Function signature to return int

  const ColorPicker({super.key, required this.onSelectedColor});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? _selectedColor = Colors.black;
  final List<Color> _colors = [
    Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.black,
    Colors.yellow, Colors.teal, Colors.pink, Colors.brown, Colors.cyan, Colors.amber,
    Colors.lime, Colors.indigo, Colors.grey, Colors.deepOrange, Colors.lightBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: _selectedColor?.value,
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: _selectedColor ?? Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      onSelected: (int colorValue) {
        setState(() {
          _selectedColor = Color(colorValue);
        });
        widget.onSelectedColor(colorValue);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 200,
            height: 200,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: _colors.map((color) => GestureDetector(
                onTap: () {
                  Navigator.pop(context, color.value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
