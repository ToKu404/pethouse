import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pethouse/presentation/widgets/task_daily_summary_card.dart';
import 'package:pethouse/presentation/widgets/event_card.dart';
import 'package:pethouse/presentation/widgets/no_pet_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/task.dart';
import 'package:user/domain/entities/user_entity.dart';
import 'package:plan/plan.dart';

import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  final UserEntity userEntity;
  const HomePage({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  DateTime _dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSchedulePetBloc>(context).add(FetchListSchedulePet());
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
                return const LoadingView();
              } else if (state is GetSchedulePetSuccess) {
                if (state.listPet.isNotEmpty) {
                  return _buildListPet(state.listPet);
                } else {
                  return const Center(child: NoPetView());
                }
              } else if (state is GetSchedulePetError) {
                return ErrorView(message: state.message);
              } else {
                return const Center();
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
                                                color: kSmoothYellow,
                                              )
                                            : Border.all(
                                                width: 4, color: kSmoothYellow),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: listPet[index].petPictureUrl !=
                                                  '' &&
                                              listPet[index].petPictureUrl !=
                                                  null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  listPet[index].petPictureUrl!,
                                              placeholder: (context, url) =>
                                                  Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kGrey),
                                              ),
                                              imageBuilder: (context,
                                                      imagePrviceder) =>
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: kGrey,
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imagePrviceder,
                                                              fit: BoxFit
                                                                  .cover))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Center(
                                                          child: Icon(
                                                              Icons.image)),
                                            )
                                          : Container(
                                              decoration: const BoxDecoration(
                                                color: kGrey,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.image,
                                                      color: kGreyTransparant,
                                                    ),
                                                    Text('No Image',
                                                        style: kTextTheme
                                                            .caption
                                                            ?.copyWith(
                                                                color:
                                                                    kGreyTransparant))
                                                  ],
                                                ),
                                              ),
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
                            BlocProvider.of<TaskBloc>(context).add(
                                FetchTaskEvent(petId: listPet[activePage].id!));
                            BlocProvider.of<HomePlanCalendarBloc>(context).add(
                                FetchHomePlanCalendarEvent(
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
                            'Events',
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    _buildListTask(listPet[activePage]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildListTask(PetEntity pet) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Daily Task',
                style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, ALL_HABBIT_ROUTE_NAME,
                    arguments: pet),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: kWhite),
                  child: const Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _BuildSchedule(petEntity: pet),
      ],
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
    BlocProvider.of<TaskBloc>(context)
        .add(FetchTaskEvent(petId: widget.petEntity.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: 15,
            child: const ShimmerLoadingView(borderRadius: 10),
          );
        } else if (state is GetTaskSuccess) {
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
                  child: TaskDailySummaryCard(
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
        } else if (state is TaskError) {
          return Text(state.message);
        } else {
          return const Center();
        }
      },
    );
  }

  getCompleteTask(List<TaskEntity> tasks) {
    return tasks.where((e) => e.completeStatus!).toList().length;
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
    BlocProvider.of<HomePlanCalendarBloc>(context).add(
        FetchHomePlanCalendarEvent(
            petId: widget.petId, choiceDate: _selectedDate));
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
                BlocProvider.of<HomePlanCalendarBloc>(context).add(
                    FetchHomePlanCalendarEvent(
                        petId: widget.petId, choiceDate: _selectedDate));
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HomePlanCalendarBloc, HomePlanCalendarState>(
            builder: (context, state) {
              if (state is HomePlanCalendarLoading) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 15,
                  child: const ShimmerLoadingView(
                    borderRadius: 10,
                  ),
                );
              } else if (state is HomePlanCalendarSuccess) {
                if (state.listPlan.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Text(
                      'No Event Today',
                      style: kTextTheme.subtitle2
                          ?.copyWith(color: kGreyTransparant, fontSize: 14),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    shrinkWrap: true,
                    itemCount: state.listPlan.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return EventCard(
                        event: state.listPlan[index],
                      );
                    }),
                  );
                }
              } else if (state is HomePlanCalendarError) {
                return const Text('Error');
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
