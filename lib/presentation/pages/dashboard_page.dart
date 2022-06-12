import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet/presentation/bloc/get_pet/get_pet_bloc.dart';
import 'package:user/domain/entities/user_entity.dart';
import '../widgets/adopt_banner_card.dart';
import '../widgets/card_petrivia.dart';
import '../widgets/dashboard_pet_card.dart';
import 'package:core/core.dart';

class DashboardPage extends StatefulWidget {
  final UserEntity user;
  const DashboardPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPetBloc>(context).add(FetchListPet());
  }

  final _listPetrivia = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            height: 60,
            width: double.infinity,
            color: kMainOrangeColor,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    kAppTitle,
                    style: kTextTheme.headline4?.copyWith(color: kWhite),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, NOTIFICATION_ROUT_NAME),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kWhite),
                    child: const Icon(
                      Icons.notifications,
                      color: kMainOrangeColor,
                    ),
                  ),
                ),
               
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Text(
                      "MY PETS",
                      style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                    ),
                  ),
                  Container(
                    height: 125,
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: kPadding * 2),
                    child: BlocBuilder<GetPetBloc, GetPetState>(
                        builder: ((context, state) {
                      if (state is GetPetLoading) {
                        return const SizedBox(
                          height: 105,
                          width: double.infinity,
                        );
                      } else if (state is GetPetSuccess) {
                        final pets = state.listPet;
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            scrollDirection: Axis.horizontal,
                            itemCount: pets.length + 1,
                            itemBuilder: ((context, index) {
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ADD_PET_ROUTE_NAME);
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
                                return DashboardPetCard(pet: pets[index - 1]);
                              }
                            }));
                      } else {
                        return const SizedBox(
                          height: 105,
                          width: double.infinity,
                        );
                      }
                    })),
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: const Color(0xFFE5E9F2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Text(
                      "SERVICE",
                      style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        bottom: kPadding, left: kPadding, right: kPadding),
                    child: Row(
                      children: [
                        _ServiceCard(
                          icon: FontAwesomeIcons.paw,
                          title: 'Adopt',
                          function: () =>
                              Navigator.pushNamed(context, ADOPT_ROUTE_NAME),
                        ),
                        const SizedBox(
                          width: kPadding,
                        ),
                        _ServiceCard(
                            icon: FontAwesomeIcons.store,
                            title: 'Store',
                            function: () {})
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: const Color(0xFFE5E9F2),
                  ),
                  // const AdoptBannerCard(),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Text(
                      "PETRIVIA",
                      style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                    ),
                  ),

                  Column(
                    children:
                        _listPetrivia.map((e) => const CardPetrivia()).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback function;
  const _ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: const Color(0xFFFFEAB6)),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: kMainOrangeColor),
                  child: Center(
                      child: Icon(
                    icon,
                    color: kWhite,
                    size: 25,
                  )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title, style: kTextTheme.subtitle1)
        ],
      ),
    );
  }
}
