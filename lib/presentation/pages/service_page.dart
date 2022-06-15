import 'package:adopt/presentation/pages/adopt_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<String> _tabTitle = ['Adopt', 'Store'];
  int _tabIndex = 0;
  final List<Widget> _bodyPage = [
    const AdoptPage(),
    const Center(
      child: Text('Coming Soon'),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: _tabTitle.length,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              height: 60,
              width: double.infinity,
              color: kWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Service",
                      style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
                    ),
                  ),
                  _tabIndex == 0
                      ? InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, OPEN_ADOPT_ROUTE_NAME),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kWhite),
                            child: const Icon(
                              Icons.add,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: kWhite,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                      color: const Color(0xFF000000).withOpacity(.05))
                ],
              ),
              child: TabBar(
                indicator: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2, color: kPrimaryColor))),
                unselectedLabelColor: kDarkBrown,
                labelColor: kPrimaryColor,
                labelStyle: kTextTheme.subtitle1,
                onTap: (index) {
                  setState(() {
                    _tabIndex = index;
                  });
                },
                unselectedLabelStyle: kTextTheme.subtitle1,
                tabs: [
                  Tab(
                    child: Text(
                      _tabTitle[0],
                    ),
                  ),
                  Tab(
                    child: Text(
                      _tabTitle[1],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _bodyPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
