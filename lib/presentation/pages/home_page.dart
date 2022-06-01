import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/presentation/pages/account/account_page.dart';
import 'package:pethouse/presentation/pages/dashboard_page.dart';
import 'package:pethouse/presentation/pages/schedule/schedule_page.dart';
import 'package:core/core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 1;

  setBottomBarIndex(index) {
    setState(() {
      currentTab = index;
    });
  }

  final List<Widget> screens = [
    DashboardPage(),
    SchedulePage(),
    AccountPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
