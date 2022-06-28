import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  height: 120,
                  width: double.infinity,
                  child: adoptEntity.petPictureUrl != null &&
                          adoptEntity.petPictureUrl != ''
                      ? CachedNetworkImage(
                          imageUrl: adoptEntity.petPictureUrl!,
                          placeholder: (context, url) =>
                              const ShimmerLoadingView(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const NoImageCard(),
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
              width: 125,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adoptEntity.petName ?? 'Pet Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                                TextGeneratorHelper.dateToAge(
                                    adoptEntity.dateOfBirth!.toDate()),
                                style: kTextTheme.overline?.copyWith(
                                  fontSize: 11,
                                  color: kDarkBrown,
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
}
