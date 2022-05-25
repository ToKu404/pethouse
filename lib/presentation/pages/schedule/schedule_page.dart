import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/utils/styles.dart';

import '../../widgets/card_schedule_status.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "schedule-page";

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int activePage = 1;
  late PageController _pageController;
  List<String> images = [
    "https://media.istockphoto.com/photos/calico-cat-with-green-eyes-lying-on-cardboard-scratch-board-picture-id1326411219?b=1&k=20&m=1326411219&s=170667a&w=0&h=TNQTmK1E0vIZk5eF9tLrJGfy1dzNlj-Yc_UutJDYcAs=",
    "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGNhdCUyMGphcGFufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://media.istockphoto.com/photos/cat-with-blue-eyes-looks-at-camera-picture-id1067347086?b=1&k=20&m=1067347086&s=170667a&w=0&h=kLUll2ujZmQo8JjMQYuxyVCtCtdd6W6ylzu6fJqu8PI="
  ];
  List pets = ["Neko", "Bobo", "Lopa"];

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
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
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
                                  color: Color(0xFFFFC46A),
                                )
                              : Border.all(width: 5, color: kGrey),
                          image: DecorationImage(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.cover),
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
              enableInfiniteScroll: true,
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${pets[activePage]}',
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: CardScheduleStatus(),
          ),
          SizedBox(
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
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
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(2),
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
            color: Color(0xFFFFE7C3),
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
