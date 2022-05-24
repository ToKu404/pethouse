import 'package:flutter/material.dart';

final double width = 320;
final double height = 52;
final double elevation = 5;

class CardAccount extends StatelessWidget {
  final String title;
  final IconData trailing;
  final IconData? leading;
  const CardAccount({
    super.key,
    required this.title,
    required this.trailing,
    required this.leading,
  });



  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height,
        width: width,
        child: ListTile(
          leading: Icon(leading),
          title: Text(title),
          trailing: Icon(trailing),
        ),
      ),
    );
  }
}

class CardDarkMode extends StatefulWidget {
  @override
  State<CardDarkMode> createState() => _CardDarkModeState();
}

class _CardDarkModeState extends State<CardDarkMode> {
  bool statusSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height,
        width: width,
        child: ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Dark Mode'),
            trailing: Switch.adaptive(
                value: statusSwitch,
                onChanged: (value) =>
                    setState(() => statusSwitch = !statusSwitch)
            ),
        ),
      ),
    );
  }
}
