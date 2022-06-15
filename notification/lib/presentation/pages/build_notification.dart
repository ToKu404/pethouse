import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification/presentation/widgets/notif_card.dart';

import '../../domain/entities/nofitication_entity.dart';

class BuildNotification extends StatefulWidget {
  const BuildNotification({Key? key}) : super(key: key);

  @override
  State<BuildNotification> createState() => _BuildNotificationState();
}

class _BuildNotificationState extends State<BuildNotification> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationBloc>(context).add(FetchListNotification());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NotificationError) {
          return Text(state.message);
        } else if (state is NotificationSuccess) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kPadding * 2),
              child: Column(
                  children: state.listNotification
                      .map((e) => _buildListNotification(e))
                      .toList()),
            ),
          );
        } else {
          return const Center(
            child: Text('null'),
          );
        }
      },
    );
  }

  Widget _buildListNotification(NotificationEntity cardNotif) {
    return NotifCard(notificationEntity: cardNotif);
  }
}
