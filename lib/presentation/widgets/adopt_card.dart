import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pethouse/presentation/pages/detail_adopt_page.dart';
import 'package:core/core.dart';

class AdoptCard extends StatelessWidget {
  const AdoptCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetailAdoptPage.ROUTE_NAME),
      child: Container(
        padding: EdgeInsets.all(8),
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
                child: Image.network(
                  'https://media.istockphoto.com/photos/ginger-cat-sitting-on-floor-in-living-room-and-looking-at-camera-pet-picture-id1149347768?b=1&k=20&m=1149347768&s=170667a&w=0&h=eYqyMdhTK02QUU0miN0-ka-Dk37hNU8uTpF4z1k-t3A=',
                  height: 135,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: kWhite),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/cat_icon_outline.svg',
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
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesu',
                    style: kTextTheme.subtitle1?.copyWith(color: kDarkBrown),
                  ),
                  Text(
                    'Ras: Persia',
                    style: kTextTheme.overline
                        ?.copyWith(color: kGreyTransparant, height: 1),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFCDDDF6),
                        ),
                        child: Text(
                          'Jantan',
                          style: kTextTheme.overline?.copyWith(
                            color: Color(0xFF578EE0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFFFF5E3),
                        ),
                        child: Text(
                          '10 Bulan',
                          style: kTextTheme.overline?.copyWith(
                            color: Color(0xFF85634D),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
