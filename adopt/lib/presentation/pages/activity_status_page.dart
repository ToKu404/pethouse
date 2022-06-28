import 'package:adopt/adopt.dart';
import 'package:adopt/presentation/widgets/activity_status_card.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityStatusPage extends StatefulWidget {
  const ActivityStatusPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ActivityStatusPage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ActivityStatusPage> {
  final List<String> _tabTitle = ['Open Adopt', 'Request Adopt'];
  final List<Widget> _bodyPage = [
    const _BuildOpenAdoptStatus(),
    const _BuildRequestAdoptStatus()
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OpenAdoptStatusBloc>(context).add(FetchListOpenAdopt());
    BlocProvider.of<RequestAdoptStatusBloc>(context)
        .add(FetchListRequestAdopt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: const DefaultAppBar(
        title: 'Activity Status',
      ),
      body: DefaultTabController(
        length: _tabTitle.length,
        child: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicator: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2, color: kPrimaryColor))),
                unselectedLabelColor: kDarkBrown,
                labelColor: kPrimaryColor,
                labelStyle: kTextTheme.subtitle1,
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
              Expanded(
                child: TabBarView(
                  children: _bodyPage,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildRequestAdoptStatus extends StatelessWidget {
  const _BuildRequestAdoptStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<RequestAdoptStatusBloc, RequestAdoptStatusState>(
              builder: (context, state) {
                if (state is RequestAdoptStatusLoading) {
                  return const LoadingView();
                } else if (state is ListRequestAdoptLoaded) {
                  if (state.adoptList.isNotEmpty) {
                    final statusWaiting = state.adoptList
                        .where((element) => element.status == 'wait')
                        .toList();
                    final statusComplete = state.adoptList
                        .where((element) => element.status == 'completed')
                        .toList();
                    if (statusWaiting.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Waiting for confirmation',
                            style: kTextTheme.headline3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: statusWaiting.length,
                              itemBuilder: (context, index) {
                                return ActivityStatusCard(
                                    adopt: statusWaiting[index]);
                              }),
                        ],
                      );
                    } else if (statusComplete.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Request Adopt Success',
                            style: kTextTheme.headline3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: statusComplete.length,
                              itemBuilder: (context, index) {
                                return ActivityStatusCard(
                                    adopt: statusComplete[index]);
                              }),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                } else if (state is RequestAdoptStatusError) {
                  return ErrorView(message: state.message);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildOpenAdoptStatus extends StatelessWidget {
  const _BuildOpenAdoptStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<OpenAdoptStatusBloc, OpenAdoptStatusState>(
              builder: (context, state) {
                if (state is ActivityStatusLoading) {
                  return const LoadingView();
                } else if (state is ListOpenAdoptLoaded) {
                  if (state.adoptList.isNotEmpty) {
                    final statusOpen = state.adoptList
                        .where((element) => element.status == 'open')
                        .toList();
                    final statusWaiting = state.adoptList
                        .where((element) => element.status == 'wait')
                        .toList();
                    if (statusWaiting.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Pending your confirmation',
                            style: kTextTheme.headline3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: statusWaiting.length,
                              itemBuilder: (context, index) {
                                return ActivityStatusCard(
                                    adopt: statusWaiting[index]);
                              }),
                        ],
                      );
                    } else if (statusOpen.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Waiting for adopters',
                            style: kTextTheme.headline3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: statusOpen.length,
                              itemBuilder: (context, index) {
                                return ActivityStatusCard(
                                    adopt: statusOpen[index]);
                              }),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                } else if (state is ActivityStatusError) {
                  return ErrorView(message: state.message);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
