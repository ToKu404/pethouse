import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/task.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TaskCard extends StatefulWidget {
  final TaskEntity task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ]),
      width: double.infinity,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.task.completeStatus!
                ? kGreyTransparant
                : kPrimaryColor,
          ),
          child: Center(
            child: Icon(
              kTaskType[widget.task.activityType],
              color: kWhite,
            ),
          ),
        ),
        title: Text(widget.task.title ?? '-',
            style: widget.task.completeStatus!
                ? kTextTheme.subtitle1?.copyWith(
                    color: kGreyTransparant,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough)
                : kTextTheme.subtitle1?.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  )),
        subtitle: Text(
          DateFormat.jm().format(widget.task.time!.toDate()),
          style: TextStyle(
              color:
                  widget.task.completeStatus! ? kGreyTransparant : kDarkBrown),
        ),
        trailing: Checkbox(
          value: widget.task.completeStatus!,
          onChanged: (value) {
            BlocProvider.of<TaskBloc>(context).add(ChangeTaskStatus(
                taskId: widget.task.id!, petId: widget.task.petId!));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: kGreyTransparant,
        ),
      ),
    );
  }
}
