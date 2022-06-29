import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plan/presentation/widgets/plan_desc_card.dart';

import '../../domain/entities/plan_entity.dart';

class ScheduleTaskCard extends StatelessWidget {
  final PlanEntity event;
  final bool isFirst;
  final bool isLast;
  final bool isSingle;
  const ScheduleTaskCard({
    Key? key,
    required this.event,
    required this.isFirst,
    required this.isLast,
    required this.isSingle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            builder: (builder) {
              return PlanDescCard(plan: event);
            });
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: Text(
                DateFormat.jm().format(event.time!.toDate()),
                style: kTextTheme.subtitle1,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                SizedBox(
                  height: 40,
                  width: 8,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kPrimaryColor),
                  ),
                ),
                (isSingle)
                    ? const Center()
                    : (!isFirst && !isLast)
                        ? Positioned(
                            left: 3,
                            child: Container(
                              height: 40,
                              width: 2,
                              color: kPrimaryColor,
                            ),
                          )
                        : (isFirst)
                            ? Positioned(
                                bottom: 0,
                                left: 3,
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: kPrimaryColor,
                                ),
                              )
                            : Positioned(
                                top: 0,
                                left: 3,
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: kPrimaryColor,
                                ),
                              ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              event.activityTitle!,
              style: kTextTheme.headline3?.copyWith(color: kDarkBrown),
            )),
          ],
        ),
      ),
    );
  }
}
