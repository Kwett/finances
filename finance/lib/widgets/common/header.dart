import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/theme_config.dart';

class Header extends StatefulWidget {
  final String icon;
  final String title;
  final bool isDropdown;

  const Header({super.key, required this.icon, required this.title, required this.isDropdown});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String selectedValue = 'Carte';

  @override
  Widget build(BuildContext context) {
    return Column( mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(widget.icon, width: 36, height: 36),
                const SizedBox(width: 10),
                Text(widget.title.toUpperCase(), style: ThemeConfig.titleStyle),
                const SizedBox(width: 5),
              ]),
          widget.isDropdown
            ? DropdownButton<String>(
                value: selectedValue,
                items: const [
                  DropdownMenuItem(value: 'Carte', child: Text('Carte')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedValue = value;
                    });
                  }
                },
                dropdownColor: Colors.blueAccent,
              )
            : const SizedBox(),
        ]);
  }
}
