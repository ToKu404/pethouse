import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notification/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification/presentation/widgets/notif_card.dart';

import '../../domain/entities/nofitication_entity.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotificationBloc>(context)
        .add(FetchListNotification());
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
                FontAwesomeIcons.arrowLeft,
                size: 18,
                color: kWhite,
              ),
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: kTextTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: kGrey,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotificationError) {
            return Text(state.message);
          } else if (state is NotificationSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                    children: state.listNotification
                        .map((e) => _buildListNotification(e))
                        .toList()),
              ),
            );
          } else {
            return Center(
              child: Text('null'),
            );
          }
        },
      ),
    );
  }

  Widget _buildListNotification(NotificationEntity cardNotif) {
    return NotifCard(notificationEntity: cardNotif);
  }
}
