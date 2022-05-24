import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/presentation/pages/account_page.dart';
import 'package:pethouse/presentation/pages/dashboard_page.dart';
import 'package:pethouse/utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentTab = index;
    });
  }

  final List<Widget> screens = [
    DashboardPage(),
    DashboardPage(),
    AccountPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentTab],
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: Icons.dashboard),
            TabItem(icon: FontAwesomeIcons.paw),
            TabItem(icon: Icons.person),
          ],
          initialActiveIndex: 1,
          backgroundColor: kWhite,
          color: kGrey,
          activeColor: kPrimaryColor,
          elevation: 0,
          onTap: setBottomBarIndex,
          onTap: (int i) => print('click index=$i'),
        ));
  }
}
