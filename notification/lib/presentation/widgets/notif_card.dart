import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';

class NotifCard extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const NotifCard({Key? key, required this.notificationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleOnTap() {
      if (notificationEntity.type! == 'adopt') {
        Navigator.pushNamed(context, ACTIVITY_STATUS_ROUT_NAME);
      }
    }

    return InkWell(
      onTap: () {
        _handleOnTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kPadding),
        margin: const EdgeInsets.only(bottom: kPadding ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 13,
                  color: const Color(0xFF000000).withOpacity(.07)),
              BoxShadow(
                  blurRadius: 5,
                  color: const Color(0xFF000000).withOpacity(.05))
            ],
            color: notificationEntity.readStatus! ? kWhite : kWhite,
            borderRadius: kBorderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notificationEntity.type!,
                  style: kTextTheme.caption,
                ),
                Text(
                  DateFormat.yMMMd()
                      .format(notificationEntity.sendTime!.toDate()),
                  style: kTextTheme.caption,
                )
              ],
            ),
            Text(
              notificationEntity.title!,
              style: kTextTheme.subtitle1,
            ),
            Text(
              notificationEntity.value!,
              style: kTextTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
