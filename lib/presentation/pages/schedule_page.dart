import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pethouse/presentation/widgets/no_pet_card.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/presentation/blocs/get_today_task_bloc/get_today_task_bloc.dart';

import '../widgets/card_schedule_status.dart';
import 'schedule/schedule_calendar_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int activePage = 0;
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
    );
  }

  _buildListPet(List<PetEntity> listPet) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: listPet.length,
            itemBuilder: (ctx, index, _) {
              return Transform.scale(
                  scale: index == activePage ? 1 : .7,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: index == activePage
                              ? Border.all(
                                  width: 7,
                                  color: const Color(0xFFFFC46A),
                                )
                              : Border.all(width: 5, color: kGrey),
                          image: listPet[index].petPictureUrl != '' &&
                                  listPet[index].petPictureUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      listPet[index].petPictureUrl!),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/image_user.png')),
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
                  ));
            },
            options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: listPet.length > 2 ? true : false,
              viewportFraction: .5,
              initialPage: activePage,
              onPageChanged: (index, reason) {
                setState(() {
                  activePage = index;
                  BlocProvider.of<GetTodayTaskBloc>(context)
                      .add(FetchTodayTask(petId: listPet[activePage].id!));
                });
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ADD_TASK_ROUTE_NAME,
                  arguments: listPet[activePage]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${listPet[activePage].petName}',
                    style: kTextTheme.headline5,
                  ),
                  const Icon(
                    FontAwesomeIcons.angleRight,
                    size: 18,
                    color: kDarkBrown,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _BuildSchedule(petEntity: listPet[activePage]),
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
    // TODO: implement initState
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
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ADD_TASK_ROUTE_NAME,
                    arguments: widget.petEntity);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 10, bottom: .4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      color: kGrey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 160,
                          color: kWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 20,
                                  color: kGrey,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                "Add Task",
                                style: TextStyle(
                                  color: kGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  child: CardScheduleStatus(
                    taskFinish: 2,
                    taskAll: 3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Text(
                    'Today Task',
                    style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: state.listTask
                        .map(
                          (task) => TaskCard(task: task),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
            color: const Color(0xFFFFE7C3),
          ),
          child: Center(
            child: Icon(
              kTaskType[widget.task.activity],
              color: kSecondaryColor,
            ),
          ),
        ),
        title: Text(widget.task.activity ?? '-',
            style: kTextTheme.subtitle1
                ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500)),
        subtitle: Text(
          DateFormat.jm().format(widget.task.startTime!.toDate()),
        ),
        trailing: Checkbox(
          value: widget.task.status == 'finish',
          onChanged: (value) {
            setState(() {
              // widget.task.status = value;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: kPrimaryColor,
        ),
      ),
    );
  }
}
