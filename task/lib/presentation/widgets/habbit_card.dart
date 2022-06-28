import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/presentation/blocs/habbit_cubit/habbit_cubit.dart';

class HabbitCard extends StatefulWidget {
  final HabbitEntity habbit;
  const HabbitCard({Key? key, required this.habbit}) : super(key: key);

  @override
  State<HabbitCard> createState() => _HabbitCardState();
}

class _HabbitCardState extends State<HabbitCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.habbit.id!),
      onDismissed: (DismissDirection direction) {
        BlocProvider.of<HabbitCubit>(context).onRemoveHabbit(widget.habbit);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.habbit.activityType ?? '-',
              style: kTextTheme.subtitle2?.copyWith(color: kPrimaryColor),
            ),
            Text(
              widget.habbit.title ?? '-',
              style: kTextTheme.subtitle1,
            ),
            Text(
              widget.habbit.repeat == 'Custom'
                  ? _getDayRepeat(widget.habbit.dayRepeat!)
                  : widget.habbit.repeat,
              style: kTextTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  _getDayRepeat(List<String> dayRepeat) {
    String repeatDays = '';
    for (var element in dayRepeat) {
      repeatDays += ("${element.toUpperCase()} ");
    }
    return repeatDays;
  }
}
