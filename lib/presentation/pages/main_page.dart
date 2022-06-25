// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pethouse/presentation/pages/map_page.dart';
import 'package:pethouse/presentation/pages/notification_page.dart';
import 'package:pethouse/presentation/pages/petrivia_page.dart';
import 'package:pethouse/presentation/pages/service_page.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'home_page.dart';
import 'package:core/core.dart';

class MainPage extends StatefulWidget {
  final String userId;
  const MainPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentTab = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RealtimeInternetCheckCubit>(context).onCheckConnectionRealtime();
    BlocProvider.of<UserDbBloc>(context).add(GetUserFromDb(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kWhite,
      body: BlocListener<RealtimeInternetCheckCubit, RealtimeInternetCheckState>(
        listener: (context, state) {
          if (state is RealtimeInternetCheckLost) {
            const snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Your internet connection is lost!',
                  style: TextStyle(color: kWhite),
                ));
            _scaffoldKey.currentState!.showSnackBar(snackBar);
          } else if (state is RealtimeInternetCheckGain) {
            _scaffoldKey.currentState!.removeCurrentSnackBar();
          }
        },
        child: BlocBuilder<UserDbBloc, UserDbState>(
          builder: (context, state) {
            if (state is UserDbLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessGetData) {
              final List<Widget> screens = [
                HomePage(
                  userEntity: state.user,
                ),
                const ServicePage(),
                PetMapPage(
                  userEntity: state.user,
                ),
                const NotificationPage(),
                const PetrviaPage()
              ];
              return screens[currentTab];
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Service",
            icon: Icon(Icons.pets),
          ),
          BottomNavigationBarItem(
            label: "Maps",
            icon: Icon(Icons.map_sharp),
          ),
          BottomNavigationBarItem(
            label: "Notification",
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: "Petrivia",
            icon: Icon(Icons.library_books),
          ),
        ],
        backgroundColor: kWhite,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: const Color(0xFFD6D6D6),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentTab,
        elevation: 0,
        onTap: setBottomBarIndex,
      ),
    );
  }
}
