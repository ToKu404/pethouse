import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';

import '../../widgets/adopt_card.dart';

class AdoptPage extends StatelessWidget {
  const AdoptPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "adopt-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: kGrey),
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 18,
                color: kWhite,
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Adopt',
          style: kTextTheme.headline5,
        ),
        elevation: 1,
        shadowColor: kGrey,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Text(
              "Find New Pets!",
              style: GoogleFonts.poppins(
                  color: kGreyTransparant,
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.grey[400],
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        hintText: "Search for breed, race, or gender",
                        fillColor: Color(0xFFF6F6F6)),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: kBorderRadius, color: Color(0xFFF6F6F6)),
                  child: MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      FontAwesomeIcons.sliders,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 90,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(5),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/cat_icon_outline.svg',
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Cat',
                        style: kTextTheme.subtitle2
                            ?.copyWith(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/dog_icon_outline.svg',
                        fit: BoxFit.cover,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Dog',
                        style: kTextTheme.subtitle2
                            ?.copyWith(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/fish_icon_outline.svg',
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Fish',
                        style: kTextTheme.subtitle2
                            ?.copyWith(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/hamster_icon_outline.svg',
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Hamster',
                        style: kTextTheme.subtitle2
                            ?.copyWith(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bird_icon_outline.svg',
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Bird',
                        style: kTextTheme.subtitle2
                            ?.copyWith(color: Colors.grey[600]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding + 5),
            child: Text(
              '120 Pet\'s Found',
              style: kTextTheme.subtitle1,
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .72,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: 20,
            itemBuilder: (context, index) {
              return AdoptCard();
            },
          )
        ],
      )),
    );
  }
}
