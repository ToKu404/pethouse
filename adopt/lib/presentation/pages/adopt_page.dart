import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/list_adopt_bloc/list_adopt_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/adopt_card.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({Key? key}) : super(key: key);

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListAdoptBloc>(context).add(FetchListPetAdopt());
  }

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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Adopt',
          style: kTextTheme.headline5,
        ),
        elevation: 1,
        shadowColor: kGrey,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: kWhite,
          ),
          onPressed: () => Navigator.pushNamed(context, OPEN_ADOPT_ROUTE_NAME)),
      body: SafeArea(
        child: BlocBuilder<ListAdoptBloc, ListAdoptState>(
          builder: (context, state) {
            if (state is ListAdoptLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ListAdoptError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ListPetAdoptLoaded) {
              return _buildAdoptPageData(
                state.listAdoptEntity,
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAdoptPageData(List<AdoptEntity> listPet) {
    return ListView(
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: kPadding),
          width: double.infinity,
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
                fillColor: const Color(0xFFF6F6F6)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 90,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(5),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/cat_icon_outline.svg',
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
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
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/dog_icon_outline.svg',
                      fit: BoxFit.cover,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
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
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/fish_icon_outline.svg',
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
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
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/hamster_icon_outline.svg',
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
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
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bird_icon_outline.svg',
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
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
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding + 5),
          child: Text(
            '${listPet.length} Pet\'s Found',
            style: kTextTheme.subtitle1,
          ),
        ),
        listPet.isEmpty
            ? const Expanded(
                child: Center(
                child: Text("Empty"),
              ))
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .72,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: listPet.length,
                itemBuilder: (context, index) {
                  return AdoptCard(
                    adoptEntity: listPet[index],
                  );
                },
              )
      ],
    );
  }
}
