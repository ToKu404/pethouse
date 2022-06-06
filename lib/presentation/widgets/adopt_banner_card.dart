import 'package:adopt/presentation/pages/adopt_page.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/core.dart';

class AdoptBannerCard extends StatelessWidget {
  const AdoptBannerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPadding),
      padding: const EdgeInsets.all(kPadding * 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kDarkBrown, width: 1),
        gradient: const LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/vectors/adopt_banner_pet.svg",
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Let\'s Make',
                style:
                    kTextTheme.bodyText1?.copyWith(color: kWhite, fontSize: 15),
              ),
              Text(
                'New Friend!',
                style: kTextTheme.headline5?.copyWith(height: 1.2),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, ADOPT_ROUTE_NAME),
                child: const Text(
                  "Adopt Now",
                ),
                style: ElevatedButton.styleFrom(
                    primary: kWhite,
                    onPrimary: kDarkBrown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
