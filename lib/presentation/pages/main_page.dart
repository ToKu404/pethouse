import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/presentation/pages/calendar_page.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'dashboard_page.dart';
import 'schedule_page.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserDbBloc>(context).add(GetUserFromDb(widget.userId));
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: BlocBuilder<UserDbBloc, UserDbState>(
        builder: (context, state) {
          if (state is UserDbLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessGetData) {
            final List<Widget> screens = [
              DashboardPage(
                user: state.user,
              ),
              SchedulePage(),
              CalendarPage(),
              // ProfilePage(
              //   userEntity: state.user,
              // ),
            ];
            return screens[currentTab];
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: const [
          TabItem(icon: Icons.dashboard),

          TabItem(
            icon: FontAwesomeIcons.paw,
          ),
          TabItem(icon: FontAwesomeIcons.calendar),
          // TabItem(icon: Icons.person),
        ],
        initialActiveIndex: currentTab,
        backgroundColor: kWhite,
        color: kGrey,
        activeColor: kMainOrangeColor,
        elevation: 0,
        onTap: setBottomBarIndex,
      ),
    );
  }
}
