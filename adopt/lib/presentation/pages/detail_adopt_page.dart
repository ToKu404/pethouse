import 'package:adopt/adopt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification/notification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailAdoptPage extends StatefulWidget {
  final String adoptId;
  const DetailAdoptPage({Key? key, required this.adoptId}) : super(key: key);

  @override
  State<DetailAdoptPage> createState() => _DetailAdoptPageState();
}

class _DetailAdoptPageState extends State<DetailAdoptPage> {
  bool isOwner = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnetimeInternetCheckCubit>(context)
        .onCheckConnectionOnetime();
    BlocProvider.of<DetailAdoptBloc>(context)
        .add(FetchPetDescription(petId: widget.adoptId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailAdoptBloc, DetailAdoptState>(
      listener: (context, state) {
        if (state is SuccessRequestAdopt) {
          Navigator.pop(context);
        } else if (state is SuccessDisagreeRequestAdopt) {
          Navigator.pop(context);
        } else if (state is RemoveAdoptSuccess) {
          Navigator.pop(context);
        }
        if (state is PetDescriptionLoaded) {
          setState(() {
            isOwner = state.isOwner;
          });
        }
      },
      child: Scaffold(
          appBar: DefaultAppBar(
            title: 'Detail Pet',
            actions: isOwner
                ? [
                    PopupMenuButton(
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Icon(
                          Icons.more_vert,
                          color: kPrimaryColor,
                        ),
                      ),
                      onSelected: (val) {
                        if (val == 1) {
                          showWarningDialog(context,
                              title: "Are you sure to remove open adopt?",
                              onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const LoadingView();
                              },
                            );
                            Future.delayed(const Duration(seconds: 1),
                                () async {
                              BlocProvider.of<DetailAdoptBloc>(context).add(
                                  RemoveOpenAdoptEvent(
                                      adoptId: widget.adoptId));
                              Navigator.pop(context);
                            });
                          });
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Remove'),
                          ),
                        ];
                      },
                    ),
                  ]
                : null,
          ),
          body:
              BlocBuilder<OnetimeInternetCheckCubit, OnetimeInternetCheckState>(
            builder: (context, state) {
              if (state is OnetimeInternetCheckLoading) {
                return const LoadingView();
              } else if (state is OnetimeInternetCheckGain) {
                return BlocBuilder<DetailAdoptBloc, DetailAdoptState>(
                    builder: (context, state) {
                  if (state is DetailAdoptLoading) {
                    return const LoadingView();
                  } else if (state is PetDescriptionLoaded) {
                    return SafeArea(
                      child: _BuildDetailAdopt(
                        adoptEntity: state.adoptEntity,
                        isOwner: state.isOwner,
                      ),
                    );
                  } else if (state is DetailAdoptError) {
                    return ErrorView(message: state.message);
                  } else {
                    return const Center();
                  }
                });
              } else {
                return const NoInternetPage();
              }
            },
          )),
    );
  }
}

class _BuildDetailAdopt extends StatelessWidget {
  final AdoptEntity adoptEntity;
  final bool isOwner;
  const _BuildDetailAdopt({
    required this.adoptEntity,
    required this.isOwner,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        adoptEntity.status == 'wait' && isOwner
            ? Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.all(10),
                color: kPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${adoptEntity.adopterName} want to adopt your pet",
                      style: kTextTheme.headline3?.copyWith(color: kWhite),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (() =>
                              BlocProvider.of<DetailAdoptBloc>(context).add(
                                DisagreeRequestAdopt(adoptEntity: adoptEntity),
                              )),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kWhite),
                            child: Text(
                              'Disagree',
                              style: kTextTheme.bodyText1
                                  ?.copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => BlocProvider.of<DetailAdoptBloc>(context)
                              .add(AgreeRequestAdopt(adoptEntity: adoptEntity)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kWhite),
                            child: Text(
                              'Agree',
                              style: kTextTheme.bodyText1
                                  ?.copyWith(color: Colors.green),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : Container(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  margin: const EdgeInsets.symmetric(
                      horizontal: kPadding * 2, vertical: kPadding),
                  child: adoptEntity.petPictureUrl == "" ||
                          adoptEntity.petPictureUrl == null
                      ? const NoImageCard(
                          borderRadius: 10,
                        )
                      : CachedNetworkImage(
                          imageUrl: adoptEntity.petPictureUrl!,
                          placeholder: (context, url) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const ShimmerLoadingView(
                              borderRadius: 10,
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          errorWidget: (context, url, error) =>
                              const NoImageCard(),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  adoptEntity.petName ?? '-',
                                  style: kTextTheme.headline4,
                                ),
                                Text(
                                  adoptEntity.petTypeText ?? '-',
                                  style: kTextTheme.bodyText2?.copyWith(
                                      height: 1,
                                      fontSize: 14,
                                      color: kGreyTransparant),
                                ),
                              ],
                            ),
                          ),
                          adoptEntity.certificateUrl != "" &&
                                  adoptEntity.certificateUrl != null
                              ? InkWell(
                                  onTap: () async {
                                    if (!await launchUrlString(
                                      adoptEntity.certificateUrl!,
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw 'Could not launch ${adoptEntity.certificateUrl!}';
                                    }
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 41,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kPrimaryColor,
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: SvgPicture.asset(
                                        'assets/icons/certificate_icon.svg'),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCardDescPet(
                            'Gender',
                            adoptEntity.gender ?? '-',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _buildCardDescPet(
                            'Age',
                            adoptEntity.dateOfBirth != null
                                ? TextGeneratorHelper.dateToAge(
                                    adoptEntity.dateOfBirth!.toDate())
                                : '-',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _buildCardDescPet(
                            'Breed',
                            adoptEntity.petBreed != '' &&
                                    adoptEntity.petBreed != null
                                ? adoptEntity.petBreed!
                                : '-',
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        adoptEntity.petDescription ?? '',
                        style: kTextTheme.bodyText1
                            ?.copyWith(fontSize: 14, color: kGreyTransparant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildDetailButton(context),
      ],
    );
  }

  Widget _buildCardDescPet(String type, String content) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            border: Border.all(width: 1, color: kGreyTransparant)),
        height: 68,
        child: Column(
          children: [
            Text(
              type,
              style: kTextTheme.bodyText2,
            ),
            Text(content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTextTheme.subtitle1
                    ?.copyWith(color: Colors.black54, fontSize: 14))
          ],
        ),
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    if (!isOwner) {
      if (adoptEntity.status == 'open') {
        return Container(
          height: 52,
          margin: const EdgeInsets.symmetric(
              vertical: kPadding, horizontal: kPadding * 2),
          width: double.infinity,
          child: Row(
            children: [
              (adoptEntity.whatsappNumber != null &&
                      adoptEntity.whatsappNumber != '')
                  ? InkWell(
                      onTap: () async {
                        if (!await launchUrlString(
                          'https://wa.me/${adoptEntity.whatsappNumber!}',
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch ${adoptEntity.whatsappNumber!}';
                        }
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        margin: const EdgeInsets.only(right: kPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: kPrimaryColor)),
                        child: const Icon(
                          Icons.whatsapp,
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: DefaultButton(
                  height: 52,
                  width: 100,
                  onTap: () {
                    showQuestionDialog(context,
                        title: 'Send Adopt request to pet owner?', onTap: () {
                      final notif = NotificationEntity(
                        title: 'Request For Adopt',
                        value: 'some people want to adopt your pet',
                        type: 'adopt',
                        readStatus: false,
                        sendTime: Timestamp.fromDate(DateTime.now()),
                      );
                      BlocProvider.of<DetailAdoptBloc>(context)
                          .add(RequestAdopt(adoptEntity: adoptEntity));
                      BlocProvider.of<SendNotifBloc>(context).add(
                          SendAdoptNotification(
                              ownerId: adoptEntity.userId!,
                              notificationEntity: notif));
                    });
                  },
                  text: 'Adopt Now',
                  isClicked: false,
                ),
              )
            ],
          ),
        );
      } else if (adoptEntity.status == 'wait') {
        return Container(
          height: 52,
          margin: const EdgeInsets.symmetric(
              vertical: kPadding, horizontal: kPadding * 2),
          width: double.infinity,
          child: DefaultButton(
            height: 52,
            width: 100,
            onTap: () {
              showQuestionDialog(context,
                  title: 'Are you sure to cancel request adopt?', onTap: () {
                BlocProvider.of<DetailAdoptBloc>(context)
                    .add(DisagreeRequestAdopt(adoptEntity: adoptEntity));
              });
            },
            text: 'Cancel Request',
            isClicked: false,
          ),
        );
      } else {
        return Container(
          height: 52,
          margin: const EdgeInsets.symmetric(
              vertical: kPadding, horizontal: kPadding * 2),
          width: double.infinity,
          child: DefaultButton(
            height: 52,
            width: 100,
            onTap: () {
              showQuestionDialog(context,
                  title: 'Are you sure to remove open adopt?', onTap: () {
                BlocProvider.of<DetailAdoptBloc>(context)
                    .add(RemoveOpenAdoptEvent(adoptId: adoptEntity.adoptId!));
              });
            },
            text: 'Adoption Completed',
            isClicked: false,
          ),
        );
      }
    } else {
      return Container(
        height: 52,
        margin: const EdgeInsets.symmetric(
            vertical: kPadding, horizontal: kPadding * 2),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                child: Container(
                  width: 100,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: kPrimaryColor)),
                  child: Center(
                    child: Text('Edit Data',
                        style: kTextTheme.subtitle1
                            ?.copyWith(color: kPrimaryColor)),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, EDIT_ADOPT_ROUTE_NAME,
                    arguments: adoptEntity),
              ),
            ),
            const SizedBox(
              width: kPadding,
            ),
            Expanded(
              child: DefaultButton(
                height: 52,
                width: 100,
                onTap: () {
                  Navigator.pushNamed(context, ACTIVITY_STATUS_ROUT_NAME);
                },
                text: 'Check Status',
                isClicked: false,
              ),
            )
          ],
        ),
      );
    }
  }
}
