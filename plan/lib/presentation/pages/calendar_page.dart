import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:plan/plan.dart';
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
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlanCalendarBloc>(context).add(FetchPlanCalendarEvent(
        petId: widget.petEntity.id!, choiceDate: selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Event Calendar'),
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
                      border: Border.all(width: 1, color: kDarkBrown)),
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
                        BlocProvider.of<PlanCalendarBloc>(context).add(
                            FetchPlanCalendarEvent(
                                petId: widget.petEntity.id!,
                                choiceDate: selectedDay));
                        focusedDay = focusDay;
                      });
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      markersMaxCount: 3,
                      markerSizeScale: .15,
                      selectedDecoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle),
                      todayDecoration: BoxDecoration(
                          color: kPrimaryColor,
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
                      headerMargin: const EdgeInsets.only(bottom: 20),
                      titleCentered: true,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      titleTextStyle:
                          kTextTheme.headline6?.copyWith(color: kDarkBrown) ??
                              const TextStyle(),
                    ),
                  ),
                ),
                BlocBuilder<PlanCalendarBloc, PlanCalendarState>(
                  builder: (context, state) {
                    if (state is PlanCalendarLoading) {
                      return const LoadingView();
                    } else if (state is PlanCalendarSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              DateFormat('MMMM dd, yyyy').format(selectedDay),
                              style: kTextTheme.headline6
                                  ?.copyWith(color: kDarkBrown),
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            itemCount: state.listPlan.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return ScheduleTaskCard(
                                event: state.listPlan[index],
                                isFirst: index == 0 ? true : false,
                                isLast: index == state.listPlan.length - 1
                                    ? true
                                    : false,
                                isSingle:
                                    state.listPlan.length == 1 ? true : false,
                              );
                            }),
                          ),
                        ],
                      );
                    } else if (state is PlanCalendarError) {
                      return const Text('');
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ADD_PLAN_ROUTE_NAME,
            arguments: widget.petEntity),
        foregroundColor: kWhite,
        backgroundColor: kSecondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
