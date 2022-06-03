import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:core/core.dart';
import '../pages/pet_description_page.dart';

class DailySummaryCard extends StatelessWidget {
  final DailySummary dailySummary;
  DailySummaryCard({Key? key, required this.dailySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [kSecondaryColor, kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              dailySummary.title,
              style: kTextTheme.headline6?.copyWith(color: kWhite),
            ),
          ),
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 5.0,
            circularStrokeCap: CircularStrokeCap.round,
            percent: dailySummary.progress,
            progressColor: kDarkBrown,
            backgroundColor: kGrey,
            center: CircleAvatar(
              radius: 35.0,
              backgroundColor: kWhite,
              child: SvgPicture.asset(dailySummary.icon, height: 32),
            ),
          ),
          Text("Recent ${dailySummary.time} Am",
              style: kTextTheme.subtitle2?.copyWith(color: kDarkBrown))
        ],
      ),
    );
  }
}
