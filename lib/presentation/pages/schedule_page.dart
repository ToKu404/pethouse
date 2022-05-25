import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/utils/styles.dart';

import '../widgets/card_schedule_status.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "schedule-page";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Neko Task",
                  style: kTextTheme.headline5,
                ),
                const Icon(
                  FontAwesomeIcons.angleRight,
                  size: 18,
                  color: kDarkBrown,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: CardScheduleStatus(),
        ),
      ],
    );
  }
}
