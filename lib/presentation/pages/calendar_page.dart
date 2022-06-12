import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/presentation/blocs/day_calendar_task_bloc/day_calendar_task_bloc.dart';
import 'package:schedule/presentation/pages/add_medical_activity.dart';
import 'package:schedule/presentation/pages/add_new_task.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:core/core.dart';

class CalendarPage extends StatefulWidget {
  final PetEntity petEntity;
  const CalendarPage({Key? key, required this.petEntity}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Map<DateTime, List<Event>> selectedEvents = {
  //   DateTime.now(): [Event(title: 'Jancko')]
  // };
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  // List<Event> _getEventsfromDay(DateTime date) {
  //   return selectedEvents[date] ?? [];
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DayCalendarTaskBloc>(context).add(FetchChoiceDayTask(
        petId: widget.petEntity.id!, choiceDate: selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            color: kDarkBrown,
          ),
          backgroundColor: Colors.white,
          title: Text(
            '${widget.petEntity.petName} Schedule',
            style: kTextTheme.headline5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEAB6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2100, 3, 14),
                      focusedDay: selectedDay,
                      calendarFormat: format,

                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,
                      //Day Changed
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          BlocProvider.of<DayCalendarTaskBloc>(context).add(
                              FetchChoiceDayTask(
                                  petId: widget.petEntity.id!,
                                  choiceDate: selectedDay));
                          focusedDay = focusDay;
                        });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      // eventLoader: ,
                      // Style
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        markersMaxCount: 3,
                        markerSizeScale: .15,
                        selectedDecoration: BoxDecoration(
                            color: kMainOrangeColor,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle),
                        todayDecoration: BoxDecoration(
                            color: kMainPinkColor,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle),
                        defaultDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle),
                        weekendDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                      ),

                      headerStyle: HeaderStyle(
                        headerMargin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        titleCentered: true,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [kMainPinkColor, kMainOrangeColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        titleTextStyle: GoogleFonts.poppins(
                          color: kWhite,
                          fontSize: 16,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon: const Icon(
                          FontAwesomeIcons.angleLeft,
                          color: kWhite,
                          size: 16,
                        ),
                        rightChevronIcon: const Icon(
                          FontAwesomeIcons.angleRight,
                          color: kWhite,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<DayCalendarTaskBloc, DayCalendarTaskState>(
                    builder: (context, state) {
                      if (state is DayCalendarTaskLoading) {
                        return CircularProgressIndicator();
                      } else if (state is DayCalendarTaskSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '${DateFormat('MMMM dd, yyyy').format(selectedDay)}',
                                style: kTextTheme.headline6
                                    ?.copyWith(color: kDarkBrown),
                              ),
                            ),
                            ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              itemCount: state.listTask.length,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return ScheduleTaskCard(
                                  event: state.listTask[index],
                                  isFirst: index == 0 ? true : false,
                                  isLast: index == state.listTask.length - 1
                                      ? true
                                      : false,
                                  isSingle:
                                      state.listTask.length == 1 ? true : false,
                                );
                              }),
                            ),
                          ],
                        );
                      } else {
                        return Text('');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          foregroundColor: kWhite,
          backgroundColor: kSecondaryColor,
          overlayColor: Colors.black,
          spacing: 10,
          overlayOpacity: .7,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.task,
                color: kSecondaryColor,
              ),
              onTap: () => Navigator.pushNamed(context, ADD_TASK_ROUTE_NAME,
                  arguments: widget.petEntity),
              foregroundColor: kSecondaryColor,
              label: 'Task',
            ),
            SpeedDialChild(
              onTap: () => Navigator.pushNamed(
                  context, AddMedicalActivity.ROUTE_NAME,
                  arguments: widget.petEntity),
              child: const Icon(
                Icons.medical_services,
                color: kSecondaryColor,
              ),
              foregroundColor: kSecondaryColor,
              label: 'Medical',
            ),
          ],
        ));
  }
}

class ScheduleTaskCard extends StatelessWidget {
  final TaskEntity event;
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
        print(isLast);
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat.jm().format(event.startTime!.toDate()),
              style: kTextTheme.subtitle1,
            ),
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  width: 8,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kMainOrangeColor),
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
                              color: kMainOrangeColor,
                            ),
                          )
                        : (isFirst)
                            ? Positioned(
                                bottom: 0,
                                left: 3,
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: kMainOrangeColor,
                                ),
                              )
                            : Positioned(
                                top: 0,
                                left: 3,
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: kMainOrangeColor,
                                ),
                              ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.activity!,
                  style:
                      kTextTheme.subtitle2?.copyWith(color: kMainOrangeColor),
                ),
                Text(
                  event.description,
                  style: kTextTheme.bodyText2?.copyWith(height: 1.2),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
