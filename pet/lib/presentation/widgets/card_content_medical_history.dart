import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule/domain/entities/plan_entity.dart';

class CardContentMedical extends StatelessWidget {
  final PlanEntity planEntity;
  const CardContentMedical({Key? key, required this.planEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: kPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kWhite,
        boxShadow: [
          BoxShadow(
              blurRadius: 13, color: const Color(0xFF000000).withOpacity(.07)),
          BoxShadow(
              blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(planEntity.location ?? '-', style: kTextTheme.caption),
                ],
              ),
              Text(
                'Posted On ${DateFormat.yMMMd().format(planEntity.time!.toDate())}',
                style: kTextTheme.caption,
              ),
            ],
          ),
          Text(
            planEntity.activity!,
            style: kTextTheme.subtitle1?.copyWith(color: kPrimaryColor),
          ),
          Text(
            planEntity.description ?? '-',
            style: kTextTheme.caption,
          ),
          // Text(
          //   'Expired on ${planEntity.expiredDate == null ? "-" : DateFormat.yMMMd().format(planEntity.expiredDate!.toDate())}',
          //   style: kTextTheme.caption?.copyWith(color: kGreyTransparant),
          // ),
        ],
      ),
    );
  }
}
