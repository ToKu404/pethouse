import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdoptCard extends StatelessWidget {
  final AdoptEntity adoptEntity;
  const AdoptCard({Key? key, required this.adoptEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DETAIL_ADOPT_ROUTE_NAME,
          arguments: adoptEntity.adoptId),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 135,
                  width: double.infinity,
                  child: adoptEntity.petPictureUrl != null &&
                          adoptEntity.petPictureUrl != ''
                      ? Image.network(
                          adoptEntity.petPictureUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: kGrey,
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            '${kPetTypeIcon[adoptEntity.petType?.toLowerCase()]}',
                            color: kGreyTransparant,
                            height: 80,
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: kWhite),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: SvgPicture.asset(
                      '${kPetTypeIcon[adoptEntity.petType?.toLowerCase()]}',
                      color: kPrimaryColor,
                      width: 15,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ]),
            Container(
              width: 140,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adoptEntity.petName ?? 'Pet Name',
                    style: kTextTheme.subtitle1?.copyWith(color: kDarkBrown),
                  ),
                  adoptEntity.petBreed != ''
                      ? Text(
                          '${adoptEntity.petBreed}',
                          maxLines: 1,
                          style: kTextTheme.caption?.copyWith(
                            color: kGreyTransparant,
                            height: 1,
                          ),
                        )
                      : const SizedBox(
                          height: 10,
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      adoptEntity.gender != null && adoptEntity.gender != ''
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: adoptEntity.gender == 'Male'
                                    ? const Color(0xFF4663C9)
                                    : const Color(0xFFF94A93),
                              ),
                              child: Text(
                                adoptEntity.gender ?? '',
                                style: kTextTheme.overline
                                    ?.copyWith(fontSize: 11, color: kWhite),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        width: 4,
                      ),
                      adoptEntity.dateOfBirth != null
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFFFEAD1),
                              ),
                              child: Text(
                                getAge(),
                                style: kTextTheme.overline?.copyWith(
                                  fontSize: 11,
                                  color: const Color(0xFF747474),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  String getAge() {
    DateTime? born = adoptEntity.dateOfBirth?.toDate();
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
}
