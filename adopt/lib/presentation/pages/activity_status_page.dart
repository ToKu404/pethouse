import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ActivityStatusPage extends StatefulWidget {
  const ActivityStatusPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ActivityStatusPage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ActivityStatusPage> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ListAdoptBloc>(context).add(FetchListOpenAdopt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: kGrey),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: kWhite,
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Activity Status',
          style: kTextTheme.headline5,
        ),
        elevation: 1,
        shadowColor: kGrey,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
