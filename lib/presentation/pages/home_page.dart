import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pethouse/presentation/widgets/no_pet_card.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/schedule.dart';
import 'package:user/domain/entities/user_entity.dart';

import '../widgets/card_schedule_status.dart';

class HomePage extends StatefulWidget {
  final UserEntity userEntity;
  const HomePage({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  DateTime _dateNow = DateTime.now();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSchedulePetBloc>(context).add(FetchListSchedulePet());

    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
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
            color: kWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kPrimaryColor),
                      child: SvgPicture.asset(
                        'assets/icons/pethouse_icon.svg',
                        color: kWhite,
                        // width: 24,
                        // height: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Pethouse",
                      style:
                          kTextTheme.headline5?.copyWith(color: kPrimaryColor),
                    )
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, PROFILE_ROUTE_NAME,
                      arguments: widget.userEntity),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: kWhite),
                    child: const Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GetSchedulePetBloc, GetSchedulePetState>(
                builder: ((context, state) {
              if (state is GetSchedulePetLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetSchedulePetSuccess) {
                if (state.listPet.isNotEmpty) {
                  return _buildListPet(state.listPet);
                } else {
                  return const Center(child: NoPetCard());
                }
              } else {
                return const Text('Error');
              }
            })),
          ),
        ],
      ),
    );
  }

  _buildListPet(List<PetEntity> listPet) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 290,
                width: double.infinity,
                color: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Pets',
                            style:
                                kTextTheme.headline6?.copyWith(color: kWhite),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              ADD_PET_ROUTE_NAME,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: kWhite),
                                  child: const Icon(
                                    Icons.add,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 160,
                      child: CarouselSlider.builder(
                        itemCount: listPet.length,
                        itemBuilder: (ctx, index, _) {
                          return Transform.scale(
                              scale: index == activePage ? 1 : .8,
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, PET_DESC_ROUTE_NAME,
                                    arguments: listPet[activePage].id),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 13,
                                              color: const Color(0xFF000000)
                                                  .withOpacity(.07)),
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: const Color(0xFF000000)
                                                  .withOpacity(.05))
                                        ],
                                        shape: BoxShape.circle,
                                        border: index == activePage
                                            ? Border.all(
                                                width: 6,
                                                color: const Color(0xFFFFB4BE),
                                              )
                                            : Border.all(
                                                width: 4,
                                                color: const Color(0xFFFFB4BE)),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kWhite,
                                            shape: BoxShape.circle,
                                            image: listPet[index]
                                                            .petPictureUrl !=
                                                        '' &&
                                                    listPet[index]
                                                            .petPictureUrl !=
                                                        null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        listPet[index]
                                                            .petPictureUrl!),
                                                    fit: BoxFit.cover)
                                                : const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/image_user.png'))),
                                      ),
                                    ),
                                    index == activePage
                                        ? Container()
                                        : Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kWhite.withOpacity(.8),
                                            ),
                                          )
                                  ],
                                ),
                              ));
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          enableInfiniteScroll:
                              listPet.length > 2 ? true : false,
                          viewportFraction: .5,
                          initialPage: activePage,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activePage = index;
                            });
                            BlocProvider.of<GetTodayTaskBloc>(context).add(
                                FetchTodayTask(petId: listPet[activePage].id!));
                            BlocProvider.of<DayPlanCalendarBloc>(context).add(
                                FetchPlanCalendarEvent(
                                    petId: listPet[activePage].id!,
                                    choiceDate: _dateNow));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Text(
                        '${listPet[activePage].petName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.headline6?.copyWith(color: kWhite),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.only(top: 275),
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 13,
                        offset: const Offset(0, -7),
                        color: const Color(0xFF000000).withOpacity(.07)),
                    BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(0, -7),
                        color: const Color(0xFF000000).withOpacity(.05))
                  ],
                  color: kWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                constraints: BoxConstraints(
                    minHeight: (MediaQuery.of(context).size.height -
                        275 -
                        60 -
                        56 -
                        MediaQuery.of(context).viewPadding.top)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plans',
                            style: kTextTheme.headline6
                                ?.copyWith(color: kDarkBrown),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, SCHEDULE_CALENDAR_ROUTE_NAME,
                                arguments: listPet[activePage]),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: kWhite),
                                  child: const Icon(
                                    Icons.calendar_month,
                                    color: kDarkBrown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _BuildHomeCalendar(
                      petId: listPet[activePage].id!,
                      onDateTimeChanged: (newDt) {
                        _dateNow = newDt;
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Daily Task',
                            style: kTextTheme.headline6
                                ?.copyWith(color: kDarkBrown),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, ADD_TASK_ROUTE_NAME,
                                arguments: listPet[activePage]),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: kWhite),
                                  child: const Icon(
                                    Icons.add,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _BuildSchedule(petEntity: listPet[activePage]),
                    // const Divider(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Notes',
                    //         style: kTextTheme.headline6
                    //             ?.copyWith(color: kDarkBrown),
                    //       ),
                    //       InkWell(
                    //         onTap: () => Navigator.pushNamed(
                    //             context, ADD_TASK_ROUTE_NAME,
                    //             arguments: listPet[activePage]),
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               width: 30,
                    //               height: 30,
                    //               decoration: const BoxDecoration(
                    //                   shape: BoxShape.circle, color: kWhite),
                    //               child: const Icon(
                    //                 Icons.add,
                    //                 color: kPrimaryColor,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       color: kWhite,
                    //       borderRadius: BorderRadius.circular(10),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             blurRadius: 13,
                    //             color:
                    //                 const Color(0xFF000000).withOpacity(.07)),
                    //         BoxShadow(
                    //             blurRadius: 5,
                    //             color: const Color(0xFF000000).withOpacity(.05))
                    //       ]),
                    //   child: ListNotes(),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildSchedule extends StatefulWidget {
  final PetEntity petEntity;
  const _BuildSchedule({Key? key, required this.petEntity}) : super(key: key);

  @override
  State<_BuildSchedule> createState() => __BuildScheduleState();
}

class __BuildScheduleState extends State<_BuildSchedule> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetTodayTaskBloc>(context)
        .add(FetchTodayTask(petId: widget.petEntity.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTodayTaskBloc, GetTodayTaskState>(
      builder: (context, state) {
        if (state is GetTodayTaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetTodayTaskSuccess) {
          if (state.listTask.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Daily Task Not Set Up',
                style: kTextTheme.subtitle2
                    ?.copyWith(color: kGreyTransparant, fontSize: 14),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
                  child: CardScheduleStatus(
                    taskFinish: getCompleteTask(state.listTask),
                    taskAll: state.listTask.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
                  child: Column(
                    children: state.listTask
                        .map(
                          (task) => TaskCard(task: task),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          }
        } else if (state is GetTodayTaskError) {
          return Text(state.message);
        } else {
          return const Text('Error');
        }
      },
    );
  }

  getCompleteTask(List<TaskEntity> tasks) {
    return tasks.where((e) => e.status == 'complete').toList().length;
  }
}

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
            color: widget.task.status == 'complete'
                ? kGreyTransparant
                : kMainOrangeColor,
          ),
          child: Center(
            child: Icon(
              kTaskType[widget.task.activity],
              color: kWhite,
            ),
          ),
        ),
        title: Text(widget.task.activity ?? '-',
            style: widget.task.status == 'complete'
                ? kTextTheme.subtitle1?.copyWith(
                    color: kGreyTransparant,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough)
                : kTextTheme.subtitle1?.copyWith(
                    color: kMainOrangeColor,
                    fontWeight: FontWeight.w500,
                  )),
        subtitle: Text(
          DateFormat.jm().format(widget.task.startTime!.toDate()),
          style: TextStyle(
              color: widget.task.status == 'complete'
                  ? kGreyTransparant
                  : kDarkBrown),
        ),
        trailing: Checkbox(
          value: widget.task.status == 'complete',
          onChanged: (value) {
            BlocProvider.of<GetTodayTaskBloc>(context).add(ChangeTaskStatus(
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

class _BuildHomeCalendar extends StatefulWidget {
  final String petId;
  final ValueChanged<DateTime> onDateTimeChanged;

  const _BuildHomeCalendar(
      {Key? key, required this.petId, required this.onDateTimeChanged})
      : super(key: key);

  @override
  State<_BuildHomeCalendar> createState() => __BuildHomeCalendarState();
}

class __BuildHomeCalendarState extends State<_BuildHomeCalendar> {
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DayPlanCalendarBloc>(context).add(
        FetchPlanCalendarEvent(petId: widget.petId, choiceDate: _selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DatePicker(
            DateTime.now(),
            initialSelectedDate: _selectedDate,
            selectionColor: kPrimaryColor,
            daysCount: 5,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              _selectedDate = date;
              widget.onDateTimeChanged(date);
              setState(() {
                BlocProvider.of<DayPlanCalendarBloc>(context).add(
                    FetchPlanCalendarEvent(
                        petId: widget.petId, choiceDate: _selectedDate));
              });
            },
          ),
          BlocBuilder<DayPlanCalendarBloc, DayPlanCalendarState>(
            builder: (context, state) {
              if (state is DayPlanCalendarLoading) {
                return const CircularProgressIndicator();
              } else if (state is DayPlanCalendarSuccess) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: state.listPlan.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return ScheduleTaskCard(
                      event: state.listPlan[index],
                      isFirst: index == 0 ? true : false,
                      isLast: index == state.listPlan.length - 1 ? true : false,
                      isSingle: state.listPlan.length == 1 ? true : false,
                    );
                  }),
                );
              } else {
                return const Text('');
              }
            },
          )
        ],
      ),
    );
  }
}
