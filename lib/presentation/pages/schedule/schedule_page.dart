import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pethouse/presentation/widgets/no_pet_card.dart';

import '../../widgets/card_schedule_status.dart';
import 'schedule_calendar_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "schedule-page";

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int activePage = 0;
  late PageController _pageController;

  final List _schedule = [
    Schedule(
        name: 'Makan Pagi',
        type: FontAwesomeIcons.utensils,
        isFinish: true,
        loop: 'Daily',
        place: 'Home',
        date: '09:00'),
    Schedule(
        name: 'Vaksinasi',
        type: FontAwesomeIcons.syringe,
        isFinish: false,
        loop: 'Daily',
        place: 'Home',
        date: '08:30'),
    Schedule(
        name: 'Walks',
        type: FontAwesomeIcons.personWalking,
        isFinish: false,
        loop: 'Daily',
        place: 'Home',
        date: '10:15'),
  ];

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
                });
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ScheduleCalendarPage.ROUTE_NAME);
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
          _buildSchedule(),
        ],
      ),
    );
  }

  _buildSchedule() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        child: CardScheduleStatus(),
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
          children: _schedule
              .map(
                (schedule) => TaskCard(schedule: schedule),
              )
              .toList(),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }
}

class Schedule {
  final String name;
  final String? place;
  final String? loop;
  final String date;
  final IconData type;
  bool? isFinish;

  Schedule(
      {required this.name,
      this.place,
      this.loop,
      required this.type,
      required this.isFinish,
      required this.date});
}

class TaskCard extends StatefulWidget {
  final Schedule schedule;

  const TaskCard({Key? key, required this.schedule}) : super(key: key);

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
              widget.schedule.type,
              color: kSecondaryColor,
            ),
          ),
        ),
        title: Text(widget.schedule.name,
            style: kTextTheme.subtitle1
                ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w500)),
        subtitle: Text(
          widget.schedule.date,
        ),
        trailing: Checkbox(
          value: widget.schedule.isFinish,
          onChanged: (value) {
            setState(() {
              widget.schedule.isFinish = value;
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
