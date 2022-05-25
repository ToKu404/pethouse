import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/account/change_password_page.dart';

final double width = 320;
final double height = 52;
final double elevation = 5;

class ChangePassword extends StatelessWidget {
  final String title;
  final IconData? trailing;
  final IconData leading;
  const ChangePassword({
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
          onTap: () => {
            Navigator.pushNamed(context, ChangePasswordPage.ROUTE_NAME)
          },
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

class ChangeLanguage extends StatelessWidget {
  final String title;
  final IconData? trailing;
  final IconData leading;
  const ChangeLanguage({
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
          onTap: () => {
            {}
          },
        ),
      ),
    );
  }
}
class LogOut extends StatelessWidget {
  final String title;
  final IconData? trailing;
  final IconData leading;
  const LogOut({
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
          onTap: () => {
            {}
          },
        ),
      ),
    );
  }
}
