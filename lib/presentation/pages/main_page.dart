import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dashboard_page.dart';
import 'schedule/schedule_page.dart';
import 'package:core/core.dart';
import 'package:user/user.dart';

class MainPage extends StatefulWidget {
  final String userId;
  const MainPage({Key? key, required this.userId}) : super(key: key);
  static const ROUTE_NAME = "main-page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 1;

  setBottomBarIndex(index) {
    setState(() {
      currentTab = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardPage(),
      const SchedulePage(),
      ProfilePage(
        userId: widget.userId,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
          elevation: .7,
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/pethouse_icon.svg",
                color: kDarkBrown,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Pethouse",
                style: kTextTheme.headline5,
              )
            ],
          ),
          backgroundColor: kWhite,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NOTIFICATION_ROUT_NAME);
              },
              icon: SvgPicture.asset(
                'assets/icons/notif_icon.svg',
                color: kDarkBrown,
              ),
            )
          ]),
      body: screens[currentTab],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: const [
          TabItem(icon: Icons.dashboard),
          TabItem(icon: FontAwesomeIcons.paw),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: currentTab,
        backgroundColor: kWhite,
        color: kGrey,
        activeColor: kPrimaryColor,
        elevation: 0,
        onTap: setBottomBarIndex,
      ),
    );
  }
}
