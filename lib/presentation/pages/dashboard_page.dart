
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet/presentation/bloc/get_pet/get_pet_bloc.dart';
import '../widgets/adopt_banner_card.dart';
import '../widgets/card_petrivia.dart';
import '../widgets/dashboard_pet_card.dart';
import 'package:core/core.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final List _dummyDataPets = [

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPetBloc>(context).add(FetchListPet());
  }

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
          BlocBuilder<GetPetBloc, GetPetState>(builder: ((context, state) {
            if (state is GetPetLoading) {
              return const SizedBox(
                height: 105,
                width: double.infinity,
              );
            } else if (state is GetPetSuccess) {
              final pets = state.listPet;
              return SizedBox(
                height: 105,
                width: double.infinity,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    scrollDirection: Axis.horizontal,
                    itemCount: pets.length + 1,
                    itemBuilder: ((context, index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ADD_PET_ROUTE_NAME);
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
                        return DashboardPetCard(pet: pets[index-1]);
                      }
                    })),
              );
            } else {
              return const SizedBox(
                height: 105,
                width: double.infinity,
              );
            }
          })),
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
