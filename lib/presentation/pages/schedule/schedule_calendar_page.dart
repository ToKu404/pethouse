import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/presentation/pages/activity/add_medical_activity.dart';
import 'package:pethouse/presentation/pages/activity/add_new_task.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:core/core.dart';

class ScheduleCalendarPage extends StatefulWidget {
  static const ROUTE_NAME = 'schedule-calander-page';
  @override
  State<ScheduleCalendarPage> createState() => _ScheduleCalendarPageState();
}

class _ScheduleCalendarPageState extends State<ScheduleCalendarPage> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: kGrey),
                child: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 18,
                  color: kWhite,
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Schedule',
            style: kTextTheme.headline5,
          ),
          elevation: 1,
          shadowColor: kGrey,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9EFE2),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 13,
                            color: const Color(0xFF000000).withOpacity(.07)),
                        BoxShadow(
                            blurRadius: 5,
                            color: const Color(0xFF000000).withOpacity(.05))
                      ],
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
                          focusedDay = focusDay;
                        });
                        print(focusedDay);
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },

                      eventLoader: _getEventsfromDay,

                      // Style
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        markersMaxCount: 3,
                        markerSizeScale: .15,
                        selectedDecoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle),
                        todayDecoration: BoxDecoration(
                            color: kSecondaryColor,
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
                              colors: [kSecondaryColor, kPrimaryColor],
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
                  _getEventsfromDay(selectedDay).isEmpty
                      ? Center()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '${DateFormat('MMMM dd, yyyy').format(selectedDay)}',
                            style: kTextTheme.headline6,
                          ),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemCount: _getEventsfromDay(selectedDay).length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      final event = _getEventsfromDay(selectedDay);
                      return ScheduleTaskCard(
                        event: event[index],
                        isFirst: index == 0 ? true : false,
                        isLast:
                            index == _getEventsfromDay(selectedDay).length - 1
                                ? true
                                : false,
                        isSingle: _getEventsfromDay(selectedDay).length == 1
                            ? true
                            : false,
                      );
                    }),
                  ),
                  // ..._getEventsfromDay(selectedDay).map(
                  //   (Event event) =>
                  // ),
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
                child: Icon(
                  Icons.task,
                  color: kSecondaryColor,
                ),
                onTap: () => Navigator.pushReplacementNamed(context, AddNewTaskActivity.ROUTE_NAME),
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //     title: Text("Add Event"),
                    //     content: TextFormField(
                    //       controller: _eventController,
                    //     ),
                    //     actions: [
                    //       TextButton(
                    //         child: Text("Cancel"),
                    //         onPressed: () => Navigator.pop(context),
                    //       ),
                    //       TextButton(
                    //         child: Text("Ok"),
                    //         onPressed: () {
                    //           if (_eventController.text.isEmpty) {
                    //           } else {
                    //             if (selectedEvents[selectedDay] != null) {
                    //               selectedEvents[selectedDay]?.add(
                    //                 Event(title: _eventController.text),
                    //               );
                    //             } else {
                    //               selectedEvents[selectedDay] = [
                    //                 Event(title: _eventController.text)
                    //               ];
                    //             }
                    //           }
                    //           Navigator.pop(context);
                    //           _eventController.clear();
                    //           setState(() {});
                    //           return;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),

                foregroundColor: kSecondaryColor,
                label: 'Task',
            ),
            SpeedDialChild(
              child: Icon(
                Icons.medical_services,
                color: kSecondaryColor,
              ),
              foregroundColor: kSecondaryColor,
              label: 'Medical',
              onTap: () => Navigator.pushNamed(context, AddMedicalActivity.ROUTE_NAME)
            ),
          ],
        ));
  }
}

class Event {
  final String title;

  Event({required this.title});

  String toString() => this.title;
}

class ScheduleTaskCard extends StatelessWidget {
  final Event event;
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
        margin: EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '09:00',
              style: kTextTheme.subtitle1,
            ),
            SizedBox(
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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kPrimaryColor),
                  ),
                ),
                (isSingle)
                    ? Center()
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
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: kTextTheme.subtitle2?.copyWith(color: kPrimaryColor),
                ),
                Text(
                  'Gereja',
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
