import 'package:notification/presentation/pages/build_notification.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                    color: const Color(0xFF000000).withOpacity(.05))
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Notification",
                style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
              ),
            ),
          ),
          const Expanded(child: BuildNotification())
        ],
      ),
    );
  }
}
