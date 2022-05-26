import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/presentation/widgets/card_detail_pet.dart';
import 'package:pethouse/presentation/widgets/card_medical_history.dart';
import 'package:pethouse/presentation/widgets/card_periodic_summary.dart';
import 'package:pethouse/utils/styles.dart';

class PetDescriptionPage extends StatelessWidget {
  final String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, tristique turpis mauris, nunc adipiscing. Placerat turpis leo tristique tempus, purus.';
  static const ROUTE_NAME = "pet_description";

  const PetDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x30000000)),
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
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x30000000)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                            CardPeriodicSummary(),
                            CardPeriodicSummary(),
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
      ),
    );
  }
}
