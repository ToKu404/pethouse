import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: kGrey),
              child: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 18,
                color: kWhite,
              ),
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: kTextTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: kGrey,
      ),
    );
  }
}
