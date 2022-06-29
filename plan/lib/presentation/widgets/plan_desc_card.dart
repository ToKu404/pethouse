import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plan/plan.dart';

class PlanDescCard extends StatelessWidget {
  final PlanEntity plan;
  const PlanDescCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePlanCalendarBloc, HomePlanCalendarState>(
      listener: (context, state) {
        if (state is RemovePlanStatusSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.activityTitle ?? '',
                    maxLines: 1,
                    style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
                  ),
                  plan.location == null || plan.location == ""
                      ? Container()
                      : Text(
                          "Location : ${plan.location}",
                          style:
                              kTextTheme.headline3?.copyWith(color: kDarkBrown),
                        ),
                  plan.time == null
                      ? Container()
                      : Text(
                          "Time : ${DateFormat.jm().format(plan.time!.toDate())}",
                          style:
                              kTextTheme.headline3?.copyWith(color: kDarkBrown),
                        ),
                  plan.time == null
                      ? Container()
                      : Text(
                          "Date : ${DateFormat.yMMMMEEEEd().format(plan.time!.toDate())}",
                          style:
                              kTextTheme.headline3?.copyWith(color: kDarkBrown),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  plan.description == null
                      ? Container()
                      : Text(
                          "Description : ",
                          style:
                              kTextTheme.headline3?.copyWith(color: kDarkBrown),
                        ),
                  plan.description == null || plan.description == ""
                      ? Container()
                      : Text(
                          plan.description ?? "",
                          style:
                              kTextTheme.bodyText1?.copyWith(color: kDarkBrown),
                        ),
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                        height: 50,
                        width: 120,
                        onTap: () {
                          showQuestionDialog(context,
                              title: 'Are you sure, to delete this plan?',
                              onTap: () {
                            BlocProvider.of<HomePlanCalendarBloc>(context).add(
                                RemovePlanEvent(
                                    planId: plan.id!,
                                    choiceDate: plan.time!.toDate()));
                          });
                        },
                        isClicked: false,
                        text: 'Delete'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DefaultButton(
                        height: 50,
                        width: 120,
                        onTap: () {
                          if (plan.time!.toDate().isAfter(DateTime.now())) {
                            Navigator.pushNamed(context, EDIT_PLAN_ROUTE_NAME,
                                arguments: plan);
                          } else {
                            showWarningDialog(context,
                                title: 'Cannot Edit Old Plan', onTap: () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        isClicked: plan.time!.toDate().isAfter(DateTime.now())
                            ? false
                            : true,
                        text: 'Edit'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
