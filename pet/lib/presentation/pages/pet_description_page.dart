import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:core/core.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../widgets/card_detail_pet.dart';
import '../widgets/card_periodic_summary.dart';
import '../widgets/daily_summary_card.dart';

class PetDescriptionPage extends StatelessWidget {
  final String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, tristique turpis mauris, nunc adipiscing. Placerat turpis leo tristique tempus, purus.';
  static const ROUTE_NAME = "pet_description";

  const PetDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DailySummary> _dailySummary = [
      DailySummary('Feeds', '09:00', 'assets/icons/icon_feeds.svg', .9),
      DailySummary('Walks', '10:00', 'assets/icons/icon_walks.svg', .8),
      DailySummary('Pee', '11:00', 'assets/icons/icon_pee.svg', .65),
      DailySummary('Vitamin', '12:00', 'assets/icons/icon_vitamin.svg', .4),
    ];
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
        ),
      body: SafeArea(
        child: _PetDescLayout(description: description, dailySummary: _dailySummary),
      ),
    );
  }
}

class _PetDescLayout extends StatelessWidget {
  const _PetDescLayout({
    Key? key,
    required this.description,
    required List<DailySummary> dailySummary,
  }) : _dailySummary = dailySummary, super(key: key);

  final String description;
  final List<DailySummary> _dailySummary;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 362,
              child: Image.asset(
                'assets/images/image_cat.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0x30000000)),
                      child: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 24,
                        color: kWhite,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => {},
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0x30000000)),
                      child: const Icon(
                        Icons.more_vert,
                        size: 24,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 4, left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Ikhsan',
                        style: kTextTheme.headline4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.cake,
                            color: kOrange,
                            size: 18,
                          ),
                          Text(
                            '17 May 2020',
                            style: kTextTheme.overline,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => {},
                    child: Container(
                      height: 32,
                      width: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kOrange,
                        boxShadow: const [
                          BoxShadow(
                            color: kGreyTransparant,
                            offset: const Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const Iconify(
                        Carbon.certificate,
                        color: kWhite,
                      ),
                    ),
                  ),
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
                    content: 'Male',
                  ),
                  CardDetailPet(
                    type: 'Age',
                    content: '2 Year',
                  ),
                  CardDetailPet(
                    type: 'Breed',
                    content: 'Scottish',
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
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
                style: kTextTheme.headline4,
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 7 / 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _dailySummary.length,
                itemBuilder: (BuildContext context, int index) {
                  final ds = _dailySummary[index];
                  return DailySummaryCard(dailySummary: ds);
                },
              ),
              const SizedBox(
                height: 19,
              ),
              Text(
                'Periodic Summary',
                style: kTextTheme.headline4,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: kOrange, borderRadius: kBorderRadius),
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
}

class DailySummary {
  final String title;
  final String time;
  final String icon;
  final double progress;

  DailySummary(this.title, this.time, this.icon, this.progress);
}
