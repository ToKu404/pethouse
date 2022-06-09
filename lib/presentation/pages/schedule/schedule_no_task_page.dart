import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScheduleNoTask extends StatefulWidget {
  const HomeScheduleNoTask({Key? key}) : super(key: key);

  static const ROUTE_NAME = "schedule_page_no_task";

  @override
  State<HomeScheduleNoTask> createState() => _HomeScheduleNoTaskState();
}

class _HomeScheduleNoTaskState extends State<HomeScheduleNoTask> {
  int activePage = 1;

  List<String> images = [
    "https://media.istockphoto.com/photos/calico-cat-with-green-eyes-lying-on-cardboard-scratch-board-picture-id1326411219?b=1&k=20&m=1326411219&s=170667a&w=0&h=TNQTmK1E0vIZk5eF9tLrJGfy1dzNlj-Yc_UutJDYcAs=",
    "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGNhdCUyMGphcGFufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://media.istockphoto.com/photos/cat-with-blue-eyes-looks-at-camera-picture-id1067347086?b=1&k=20&m=1067347086&s=170667a&w=0&h=kLUll2ujZmQo8JjMQYuxyVCtCtdd6W6ylzu6fJqu8PI="
  ];
  List pets = ["Neko", "Bobo", "Lopa"];

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${pets[activePage]}',
                  style: kTextTheme.headline5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                top: 5, right: 10, bottom: .4),
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,),
                                child: const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 20,
                                  color: kGrey,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Add Task",
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
          )
        ]
      ),
    );
  }
}