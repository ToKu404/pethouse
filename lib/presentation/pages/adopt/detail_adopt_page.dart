import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:core/core.dart';
import '../../widgets/card_detail_pet.dart';

class DetailAdoptPage extends StatelessWidget {
  const DetailAdoptPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "detail-adopt-page";

  @override
  Widget build(BuildContext context) {
    final String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, tristique turpis mauris, nunc adipiscing. Placerat turpis leo tristique tempus, purus.';

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: kGrey),
                child: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 18,
                  color: kWhite,
                ),
              ),
            ),
          ),
          title: Text(
            'Detail Pet',
            style: kTextTheme.headline5,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: kGrey,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kPadding * 2),
                    bottomRight: Radius.circular(kPadding * 2)),
                child: Image.network(
                  'https://www.washingtonian.com/wp-content/uploads/2020/03/sandie-clarke-C8uGiOanMY4-unsplash-2048x1365.jpg',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Neko',
                          style: kTextTheme.headline4,
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            height: 32,
                            width: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kOrange,
                              boxShadow: [
                                const BoxShadow(
                                  color: kGreyTransparant,
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                )
                              ],
                            ),
                            padding: const EdgeInsets.all(3),
                            child: const Iconify(
                              Carbon.certificate,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                  'https://renegadecinema.com/wp-content/uploads/2013/05/788A42CB-06F7-4EA2-9E1A-3EEA131084BC.jpg'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Abdul',
                                  style: kTextTheme.subtitle1,
                                ),
                                Text(
                                  'Nekos Owner',
                                  style: kTextTheme.caption?.copyWith(
                                      height: 1, color: kGreyTransparant),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(kPadding),
                            child: Icon(
                              Icons.whatsapp,
                              color: Colors.green[900],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[200]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Description',
                      style: kTextTheme.subtitle1,
                    ),
                    Text(
                      description,
                      style: kTextTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    GradientButton(
                        height: 52,
                        width: double.infinity,
                        onTap: () {},
                        text: 'Adopt')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
