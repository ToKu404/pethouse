import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/open_adopt_bloc/open_adopt_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';
import 'package:notification/presentation/blocs/send_notif_bloc/send_notif_bloc.dart';

class PetAdoptOwnerCard extends StatelessWidget {
  final AdoptEntity adopt;
  const PetAdoptOwnerCard({Key? key, required this.adopt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 130,
      width: 300,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 13, color: const Color(0xFF000000).withOpacity(.07)),
          BoxShadow(
              blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
        ],
      ),
      child: Column(
        children: [
          _buildTopSide(context),
        ],
      ),
    );
  }

  Widget _buildTopSide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                width: 80,
                height: 130,
                child: adopt.petPictureUrl != null && adopt.petPictureUrl != ''
                    ? Image.network(
                        adopt.petPictureUrl!,
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
              height: 130,
              width: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adopt.petName ?? '-',
                    style: kTextTheme.subtitle1,
                  ),
                  Text(
                    adopt.petTypeText ?? '-',
                    style: kTextTheme.bodyText1,
                  ),
                  _BottomSide(adopt: adopt)
                ],
              ))
        ],
      ),
    );
  }
}

class _BottomSide extends StatelessWidget {
  final AdoptEntity adopt;
  const _BottomSide({Key? key, required this.adopt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String adoptName = adopt.adopterName ?? '';
    if (adopt.status == 'wait') {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Divider(),
            Center(child: Text('$adoptName want to adopt your pet')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kGrey),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        color: Color(0xFFA51313),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    final notif = NotificationEntity(
                      title: 'Your order have been success',
                      value: 'pet owner accept your adopt request',
                      type: 'adopt',
                      readStatus: false,
                      sendTime: Timestamp.fromDate(DateTime.now()),
                    );
                    BlocProvider.of<OpenAdoptBloc>(context)
                        .add(RemoveOpenAdoptEvent(adoptId: adopt.adoptId!));
                    BlocProvider.of<SendNotifBloc>(context).add(
                        SendAdoptNotification(
                            ownerId: adopt.adopterId!,
                            notificationEntity: notif));
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF13A54E)),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: kWhite,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFFB4BE)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text('Status : ${adopt.status}'),
      );
    }
  }
}
