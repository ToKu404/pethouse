import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:core/core.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:pet/presentation/widgets/card_detail_pet.dart';
import 'package:pet/presentation/widgets/card_medical_history.dart';
import 'package:pet/presentation/widgets/card_periodic_summary.dart';
import 'package:pet/presentation/widgets/daily_summary_card.dart';

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
      body: SafeArea(
        child: ListView(
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0x30000000)),
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 24,
                            color: kWhite,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => {},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0x30000000)),
                          child: Icon(
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
                              Icon(
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
                      Spacer(),
                      InkWell(
                        onTap: () => {},
                        child: Container(
                          height: 32,
                          width: 41,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kOrange,
                            boxShadow: [
                              BoxShadow(
                                color: kGreyTransparant,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(3),
                          child: Iconify(
                            Carbon.certificate,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: kTextTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  CardMedicalHistory(),
                  SizedBox(
                    height: 19,
                  ),
                  Text(
                    'Daily Summary',
                    style: kTextTheme.headline4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7 / 8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _dailySummary.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ds = _dailySummary[index];
                      return DailySummaryCard(
                          dailySummary : ds);
                    },
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Text(
                    'Periodic Summary',
                    style: kTextTheme.headline4,
                  ),
                  SizedBox(
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
                              iconfy: Iconify(
                                Noto.shower,
                                size: 36,
                              ),
                              titlePeriodic: 'Shower',
                              typePeriodic: 'Activity',
                              datePeriodic: '20 Agustus 2022'),
                          CardPeriodicWeight(
                            iconfy: Iconify(
                              Twemoji.man_lifting_weights,
                              size: 36,
                            ),
                            titlePeriodic: 'Weight',
                            typePeriodic: 'Measured',
                            datePeriodic: '20 September 2022',
                            weightValue: 4.3,
                          ),
                          CardPeriodicSummary(
                              iconfy: Iconify(
                                Twemoji.drop_of_blood,
                                size: 34,
                              ),
                              titlePeriodic: 'Weight',
                              typePeriodic: 'Measured',
                              datePeriodic: '18 Januari 2022'),
                          CardPeriodicSummary(
                              iconfy: Iconify(
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
        ),
      ),
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