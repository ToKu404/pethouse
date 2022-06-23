import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:petrivia/presentation/pages/build_petrvia_page.dart';

class PetrviaPage extends StatefulWidget {
  const PetrviaPage({Key? key}) : super(key: key);

  @override
  State<PetrviaPage> createState() => _PetrviaPageState();
}

class _PetrviaPageState extends State<PetrviaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                    color: const Color(0xFF000000).withOpacity(.05))
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Petrivia",
                style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
              ),
            ),
          ),
          const Expanded(child: BuildPetriviaPage())
        ],
      ),
    );
  }
}
