import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schedule/presentation/pages/add_medical_activity.dart';
import 'package:schedule/presentation/pages/add_new_task.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:core/core.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: kWhite,
                border: Border(bottom: BorderSide(width: 1, color: kGrey))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Calendar',
                style: kTextTheme.headline4?.copyWith(color: kDarkBrown),
              ),
            ),
          ),
          Expanded(
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
                    _getEventsfromDay(selectedDay).isEmpty
                        ? const Center()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              '${DateFormat('MMMM dd, yyyy').format(selectedDay)}',
                              style: kTextTheme.headline6,
                            ),
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      itemCount: _getEventsfromDay(selectedDay).length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
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
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '09:00',
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
                  event.title,
                  style:
                      kTextTheme.subtitle2?.copyWith(color: kMainOrangeColor),
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
