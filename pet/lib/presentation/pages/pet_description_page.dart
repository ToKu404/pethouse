import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:core/core.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/get_pet_desc/get_pet_desc_bloc.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/card_detail_pet.dart';
import '../widgets/card_periodic_summary.dart';
import '../widgets/daily_summary_card.dart';

class PetDescriptionPage extends StatefulWidget {
  final String petId;

  const PetDescriptionPage({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetDescriptionPage> createState() => _PetDescriptionPageState();
}

class _PetDescriptionPageState extends State<PetDescriptionPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPetDescBloc>(context)
        .add(FetchPetDesc(petId: widget.petId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          color: kDarkBrown,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Description',
          style: kTextTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 24,
              color: kDarkBrown,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GetPetDescBloc, GetPetDescState>(
            builder: (context, state) {
          if (state is PetDescLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetDescSuccess) {
            return _PetDescLayout(
              pet: state.petEntity,
              listTask: state.listTask,
            );
          } else {
            return const Center();
          }
        }),
      ),
    );
  }
}

class _PetDescLayout extends StatelessWidget {
  final PetEntity pet;
  final List<TaskEntity> listTask;
  _PetDescLayout({Key? key, required this.pet, required this.listTask})
      : super(key: key);

  final taskType = [
    'Feed',
    'Walk',
    'Pee',
    'Vitamin',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.all(kPadding * 2),
          decoration: BoxDecoration(
            color: kGrey,
            borderRadius: BorderRadius.circular(10),
            image: pet.petPictureUrl != "" && pet.petPictureUrl != null
                ? DecorationImage(
                    image: NetworkImage(pet.petPictureUrl ?? ''),
                    fit: BoxFit.cover)
                : null,
          ),
          child: pet.petPictureUrl == "" || pet.petPictureUrl == null
              ? const Icon(Icons.image)
              : null,
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
                          pet.petType ?? '-',
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
                              color: kOrange,
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
                  CardDetailPet(
                    type: 'Age',
                    content: pet.dateOfBirth != null ? _getAge() : '-',
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
              Text(
                pet.petDescription!,
                style: kTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 19,
              ),
              // const CardMedicalHistory(),
              const SizedBox(
                height: 19,
              ),
              Text(
                'Daily Summary',
                style: kTextTheme.headline5,
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 7 / 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: taskType.length,
                itemBuilder: (BuildContext context, int index) {
                  return DailySummaryCard(
                      dailySummary: _buildDailySummary(taskType[index]));
                },
              ),
              const SizedBox(
                height: 19,
              ),
              Text(
                'Periodic Summary',
                style: kTextTheme.headline5,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: kMainOrangeColor, borderRadius: kBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    children: [
                      CardPeriodicSummary(
                          iconfy: const Iconify(
                            Noto.shower,
                            size: 36,
                          ),
                          titlePeriodic: 'Shower',
                          typePeriodic: 'Activity',
                          datePeriodic: '20 Agustus 2022'),
                      CardPeriodicWeight(
                        iconfy: const Iconify(
                          Twemoji.man_lifting_weights,
                          size: 36,
                        ),
                        titlePeriodic: 'Weight',
                        typePeriodic: 'Measured',
                        datePeriodic: '20 September 2022',
                        weightValue: 4.3,
                      ),
                      CardPeriodicSummary(
                          iconfy: const Iconify(
                            Twemoji.drop_of_blood,
                            size: 34,
                          ),
                          titlePeriodic: 'Weight',
                          typePeriodic: 'Measured',
                          datePeriodic: '18 Januari 2022'),
                      CardPeriodicSummary(
                          iconfy: const Iconify(
                            Noto.toothbrush,
                            size: 34,
                          ),
                          titlePeriodic: 'Weight',
                          typePeriodic: 'Measured',
                          datePeriodic: '3 Februari 2023'),
                    ],
                  ),
                ),
              )

              // CardDetailPet(type: 'Feeds',content: 'Thanks',),
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

  _buildDailySummary(String taskType) {
    Map<String, dynamic> dailySummary = {};
    dailySummary['title'] = taskType;
    dailySummary['icon'] = kTaskVector[taskType];
    final choiceTask =
        listTask.where((element) => element.activity == taskType);
    if (choiceTask.isEmpty) {
      dailySummary['progress'] = 0.0;
      dailySummary['time'] = 'No Task Today';
    } else {
      int completeTask =
          choiceTask.where((element) => element.status == 'complete').length;
      dailySummary['progress'] = (completeTask / choiceTask.length).toDouble();
      DateTime now = DateTime.now();
      for (var task in listTask) {
        if (now.isBefore(task.startTime!.toDate())) {
          now = task.startTime!.toDate();
          break;
        }
      }
      dailySummary['time'] = DateFormat.jm().format(now);
    }
    return dailySummary;
  }
}
