import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/notification.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Notification",
                    style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showWarningDialog(context,
                        title: 'Are you sure to clear notifications?',
                        onTap: () {
                      BlocProvider.of<NotificationBloc>(context)
                          .add(ClearNotification());
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Text(
                        'Clear',
                        style: kTextTheme.headline3
                            ?.copyWith(color: kGreyTransparant),
                      )),
                )
              ],
            ),
          ),
          const Expanded(child: BuildNotification())
        ],
      ),
    );
  }
}
