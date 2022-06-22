import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/plan.dart';

class EventCard extends StatefulWidget {
  final PlanEntity event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    bool? isCheck = false;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 4, color: kPrimaryColor),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.activityTitle ?? '-',
                  style: kTextTheme.subtitle1,
                ),
                Text(
                  DateFormat.jm().format(widget.event.time!.toDate()),
                  style: kTextTheme.bodyText2
                      ?.copyWith(color: kDarkBrown, height: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.event.location != null
                    ? Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: kGreyTransparant,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.event.location!,
                            style: kTextTheme.caption
                                ?.copyWith(color: kGreyTransparant),
                          ),
                        ],
                      )
                    : Container(),
                widget.event.reminder == true
                    ? Row(
                        children: [
                          const Icon(
                            Icons.alarm,
                            size: 12,
                            color: kGreyTransparant,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Reminder',
                            style: kTextTheme.caption
                                ?.copyWith(color: kGreyTransparant),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          widget.event.date! == DateFormat.yMMMEd().format(DateTime.now())
              ? Checkbox(
                  value: widget.event.completeStatus,
                  onChanged: (value) {
                    BlocProvider.of<HomePlanCalendarBloc>(context).add(
                        ChangePlanStatusEvent(widget.event.petId!,
                            widget.event.id!, widget.event.time!.toDate()));
                  },
                  shape: const CircleBorder(),
                  activeColor: kPrimaryColor,
                )
              : Container(),
        ],
      ),
    );
  }
}
