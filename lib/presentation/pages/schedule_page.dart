import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/presentation/widgets/no_pet_card.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/presentation/blocs/get_today_task_bloc/get_today_task_bloc.dart';
import 'package:schedule/presentation/pages/add_medical_activity.dart';

import '../widgets/card_schedule_status.dart';
import 'calendar_page.dart';

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
                'Schedule',
                style: kTextTheme.headline4?.copyWith(color: kDarkBrown),
              ),
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
          CarouselSlider.builder(
            itemCount: listPet.length,
            itemBuilder: (ctx, index, _) {
              return Transform.scale(
                  scale: index == activePage ? 1 : .7,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 13,
                                color:
                                    const Color(0xFF000000).withOpacity(.07)),
                            BoxShadow(
                                blurRadius: 5,
                                color: const Color(0xFF000000).withOpacity(.05))
                          ],
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: kBorderRadius,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite),
                        width: 200,
                        height: 180,
                        child: Column(
                          children: [
                            Text(
                              'ADD',
                              style: kTextTheme.headline5
                                  ?.copyWith(color: kDarkBrown),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GradientButton(
                                height: 50,
                                width: double.infinity,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, ADD_TASK_ROUTE_NAME,
                                      arguments: listPet[activePage]);
                                },
                                text: 'New Task'),
                            const SizedBox(
                              height: 10,
                            ),
                            GradientButton(
                                height: 50,
                                width: double.infinity,
                                onTap: () {
                                  Navigator.pop(context);

                                  Navigator.pushNamed(
                                      context, AddMedicalActivity.ROUTE_NAME);
                                },
                                text: 'Medical Activity')
                          ],
                        ),
                      ),
                    );
                  });
              // Navigator.pushNamed(context, ADD_TASK_ROUTE_NAME,
              //     arguments: listPet[activePage]);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 13,
                        color: const Color(0xFF000000).withOpacity(.07)),
                    BoxShadow(
                        blurRadius: 5,
                        color: const Color(0xFF000000).withOpacity(.05))
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${listPet[activePage].petName}',
                    style: kTextTheme.headline5,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.add),
                  )
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
            return Center(
                child: Text(
              'No Task Today',
              style: kTextTheme.headline6?.copyWith(color: kGrey),
            ));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: CardScheduleStatus(
                    taskFinish: getCompleteTask(state.listTask),
                    taskAll: state.listTask.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
            color: kMainOrangeColor,
          ),
          child: Center(
            child: Icon(
              kTaskType[widget.task.activity],
              color: kWhite,
            ),
          ),
        ),
        title: Text(widget.task.activity ?? '-',
            style: kTextTheme.subtitle1?.copyWith(
                color: kMainOrangeColor, fontWeight: FontWeight.w500)),
        subtitle: Text(
          DateFormat.jm().format(widget.task.startTime!.toDate()),
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
          activeColor: kPrimaryColor,
        ),
      ),
    );
  }
}
