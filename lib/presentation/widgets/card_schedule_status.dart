import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardScheduleStatus extends StatelessWidget {
  const CardScheduleStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kPadding * 2),
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Daily Task',
                style: kTextTheme.bodyText1?.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: kSecondaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  RichText(
                    text: TextSpan(
                        text: '4/6',
                        style: kTextTheme.headline3,
                        children: [
                          const TextSpan(
                            text: ' Task',
                            style: const TextStyle(color: kGreyTransparant),
                          )
                        ]),
                  )
                ],
              )
            ],
          ),
          CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              percent: 0.62,
              progressColor: kSecondaryColor,
              backgroundColor: kGrey,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "62%",
                    style: kTextTheme.headline5,
                  ),
                  Text(
                    "Done",
                    style: kTextTheme.bodyText1?.copyWith(height: 1),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
