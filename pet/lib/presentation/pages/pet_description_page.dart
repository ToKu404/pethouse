import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/pages/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_pet_desc/get_pet_desc_bloc.dart';
import 'package:task/task.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/card_detail_pet.dart';
import '../widgets/card_activity_history.dart';

class PetDescriptionPage extends StatefulWidget {
  final String petId;

  const PetDescriptionPage({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetDescriptionPage> createState() => _PetDescriptionPageState();
}

class _PetDescriptionPageState extends State<PetDescriptionPage> {
  PetEntity? pet;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnetimeInternetCheckCubit>(context)
        .onCheckConnectionOnetime();
    BlocProvider.of<GetPetDescBloc>(context)
        .add(FetchPetDesc(petId: widget.petId));
    BlocProvider.of<GetMonthlyTaskBloc>(context)
        .add(FetchMonthlyTask(petId: widget.petId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Pet Profile',
        actions: [
          PopupMenuButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Icon(
                Icons.more_vert,
                color: kPrimaryColor,
              ),
            ),
            onSelected: (val) {
              if (val == 1) {
                if (pet != null) {
                  Navigator.pushNamed(context, EDIT_PET_ROUTE_NAME,
                      arguments: pet);
                }
              } else if (val == 2) {
                showWarningDialog(context,
                    title: 'Are you sure to delete this pet?', onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LoadingView();
                    },
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    BlocProvider.of<GetPetDescBloc>(context)
                        .add(RemovePetEvent(petId: widget.petId));
                    Navigator.pop(context);
                  });
                });
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Edit Pet'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Remove Pet'),
                )
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child:
            BlocBuilder<OnetimeInternetCheckCubit, OnetimeInternetCheckState>(
          builder: (context, state) {
            if (state is OnetimeInternetCheckLoading) {
              return const LoadingView();
            } else if (state is OnetimeInternetCheckLost) {
              return const NoInternetPage();
            } else {
              return BlocListener<GetPetDescBloc, GetPetDescState>(
                listener: (context, state) {
                  if (state is RemovePetSuccess) {
                    Navigator.pop(context);
                  }
                  if (state is PetDescSuccess) {
                    pet = state.petEntity;
                  }
                },
                child: BlocBuilder<GetPetDescBloc, GetPetDescState>(
                    builder: (context, state) {
                  if (state is PetDescLoading) {
                    return const LoadingView();
                  } else if (state is PetDescSuccess) {
                    return _PetDescLayout(
                      pet: state.petEntity,
                    );
                  } else if (state is PetDescError) {
                    return ErrorView(message: state.message);
                  } else {
                    return Container();
                  }
                }),
              );
            }
          },
        ),
      ),
    );
  }
}

class _PetDescLayout extends StatelessWidget {
  final PetEntity pet;
  const _PetDescLayout({Key? key, required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.all(kPadding * 2),
          child: pet.petPictureUrl == "" || pet.petPictureUrl == null
              ? const NoImageCard(
                  borderRadius: 10,
                )
              : CachedNetworkImage(
                  imageUrl: pet.petPictureUrl!,
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
                  errorWidget: (context, url, error) => const NoImageCard(),
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
                          pet.petName ?? '-',
                          style: kTextTheme.headline4,
                        ),
                        Text(
                          pet.petTypeText ?? '-',
                          style: kTextTheme.bodyText2?.copyWith(
                              height: 1, fontSize: 14, color: kGreyTransparant),
                        ),
                      ],
                    ),
                  ),
                  pet.certificateUrl != "" && pet.certificateUrl != null
                      ? InkWell(
                          onTap: () async {
                            if (!await launchUrlString(
                              pet.certificateUrl!,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw 'Could not launch ${pet.certificateUrl!}';
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
                              'assets/icons/certificate_icon.svg',
                              color: kWhite,
                            ),
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
                  CardDetailPet(
                    type: 'Gender',
                    content: pet.gender ?? '-',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CardDetailPet(
                    type: 'Age',
                    content: pet.dateOfBirth != null ? _getAge() : '-',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CardDetailPet(
                    type: 'Breed',
                    content: pet.petBreed != '' && pet.petBreed != null
                        ? pet.petBreed!
                        : '-',
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              pet.petDescription == "" || pet.petDescription == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style:
                              kTextTheme.headline6?.copyWith(color: kDarkBrown),
                        ),
                        Text(
                          pet.petDescription!,
                          style: kTextTheme.bodyText2?.copyWith(fontSize: 14),
                        ),
                        const Divider(),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              CardActivityHistory(
                petId: pet.id!,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 13,
                        color: const Color(0xFF000000).withOpacity(.07)),
                    BoxShadow(
                        blurRadius: 5,
                        color: const Color(0xFF000000).withOpacity(.05))
                  ],
                ),
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Task History',
                        style:
                            kTextTheme.subtitle1?.copyWith(color: kDarkBrown),
                      ),
                      Text(
                        DateFormat.MMMM().format(DateTime.now()),
                        style:
                            kTextTheme.bodyText1?.copyWith(color: kDarkBrown),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.pink)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Incomplete',
                            style: kTextTheme.caption,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Complete',
                            style: kTextTheme.caption,
                          )
                        ],
                      ),
                      BlocBuilder<GetMonthlyTaskBloc, GetMonthlyTaskState>(
                        builder: (context, state) {
                          if (state is GetMonthlyTaskLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetMonthlyTaskSuccess) {
                            DateTime firstDayCurrentMonth = DateTime.utc(
                                DateTime.now().year, DateTime.now().month, 1);
                            DateTime lastDayCurrentMonth = DateTime.utc(
                              DateTime.now().year,
                              DateTime.now().month + 1,
                            ).subtract(const Duration(days: 1));
                            return SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: charts.TimeSeriesChart(
                                _getSeriesData(state.listTask),
                                animate: true,
                                defaultRenderer: charts.LineRendererConfig(
                                    includePoints: true),
                                behaviors: [
                                  charts.RangeAnnotation([
                                    charts.RangeAnnotationSegment(
                                        firstDayCurrentMonth,
                                        lastDayCurrentMonth,
                                        charts.RangeAnnotationAxisType.domain)
                                  ])
                                ],
                              ),
                            );
                          } else {
                            return const Center();
                          }
                        },
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  _getAge() {
    DateTime? born = pet.dateOfBirth?.toDate();
    DateTime today = DateTime.now();
    int yearDiff = today.year - (born?.year ?? 0);
    int monthDiff = today.month - (born?.month ?? 0);
    int dayDiff = today.day - (born?.day ?? 0);

    String age = '';
    if (yearDiff > 0) {
      age += yearDiff.toString();
      int percentMonth = (monthDiff / 12).round();
      age += percentMonth > 0 ? '.$percentMonth' : '';
      age += ' Year';
    } else if (monthDiff > 0) {
      age += '$monthDiff Month';
    } else {
      age += '$dayDiff Day';
    }
    return age;
  }

  _getTaskDate(List<TaskEntity> listTask, bool status) {
    final catList =
        listTask.where((element) => element.completeStatus == status).toList();
    final List<TaskData> listResult = [];
    if (catList.isNotEmpty) {
      final List<DateTime> listDt =
          catList.map((e) => e.time!.toDate()).toList();
      int value = 1;
      for (var i = 1; i < listDt.length; i++) {
        if (listDt[i].day == listDt[i - 1].day) {
          value++;
        } else {
          listResult.add(TaskData(
              DateTime(listDt[0].year, listDt[0].month, listDt[i - 1].day),
              value));
          value = 1;
        }
        if (i == listDt.length - 1) {
          listResult.add(TaskData(
              DateTime(listDt[0].year, listDt[0].month, listDt[i].day), value));
        }
      }
    }
    return listResult;
  }

  _getSeriesData(List<TaskEntity> listTask) {
    final completeTask = _getTaskDate(listTask, true);
    final uncompleteTask = _getTaskDate(listTask, false);

    List<charts.Series<TaskData, DateTime>> series = [
      charts.Series(
          id: "Complete Task",
          data: completeTask,
          domainFn: (TaskData series, _) => series.day,
          measureFn: (TaskData series, _) => series.finishTask,
          colorFn: (TaskData series, _) =>
              charts.MaterialPalette.indigo.shadeDefault),
      charts.Series(
          id: "Uncomplet Task",
          data: uncompleteTask,
          domainFn: (TaskData series, _) => series.day,
          measureFn: (TaskData series, _) => series.finishTask,
          colorFn: (TaskData series, _) =>
              charts.MaterialPalette.pink.shadeDefault),
    ];
    return series;
  }
}

class TaskData {
  final DateTime day;
  final int finishTask;

  TaskData(this.day, this.finishTask);
}
