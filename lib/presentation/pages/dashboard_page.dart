import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pethouse/presentation/pages/pet/add_pet.dart';
import 'package:pethouse/presentation/widgets/adopt_banner_card.dart';
import 'package:pethouse/presentation/widgets/card_petrivia.dart';
import 'package:pethouse/presentation/widgets/dashboard_pet_card.dart';
import 'package:core/core.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final List _dummyDataPets = [
    {
      'name': 'Iza',
      'assets': 'assets/vectors/dog.svg',
      'age': '2 years 1 month',
    },
    {
      'name': 'Hanan',
      'assets': 'assets/vectors/fish.svg',
      'age': '2 years 4 month',
    },
    {
      'name': 'Adi',
      'assets': 'assets/vectors/dog.svg',
      'age': '2 years 3 month',
    },
    {
      'name': 'Ikhsan',
      'assets': 'assets/vectors/cat.svg',
      'age': '2 years 2 month',
    }
  ];

  final _listPetrivia = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/bg_dashboard.png",
            height: 220,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Text(
              "MyPets",
              style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
            ),
          ),
          SizedBox(
            height: 105,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: ((context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddPet.ROUTE_NAME);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 10, bottom: .4),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          color: kDarkBrown,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 105,
                              width: 120,
                              color: kWhite,
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                size: 40,
                                color: kDarkBrown,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    String name = _dummyDataPets[index - 1]["name"];
                    String assets = _dummyDataPets[index - 1]["assets"];
                    String age = _dummyDataPets[index - 1]["age"];
                    return DashboardPetCard(
                      name: name,
                      type: assets,
                      age: age,
                    );
                  }
                })),
          ),
          const SizedBox(
            height: 20,
          ),
          const AdoptBannerCard(),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Text(
              "Petrivia!",
              style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
            ),
          ),
          Column(
            children: _listPetrivia.map((e) => const CardPetrivia()).toList(),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
