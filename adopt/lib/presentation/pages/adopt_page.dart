import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/list_adopt_bloc/list_adopt_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<ListAdoptBloc, ListAdoptState>(
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
    );
  }

  Widget _buildAdoptPageData(List<AdoptEntity> listPet) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(kPadding * 2),
          child: Text(
            "Find New Pets!",
            style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kPadding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
            boxShadow: [
              BoxShadow(
                  blurRadius: 13,
                  color: const Color(0xFF000000).withOpacity(.07)),
              BoxShadow(
                  blurRadius: 5,
                  color: const Color(0xFF000000).withOpacity(.05))
            ],
          ),
          width: double.infinity,
          child: TextField(
            autofocus: false,
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
                fillColor: kWhite),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: (kPadding * 2) + 5),
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
                    horizontal: kPadding * 2, vertical: kPadding),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: listPet.length,
                itemBuilder: (context, index) {
                  return AdoptCard(
                    adoptEntity: listPet[index],
                  );
                },
              ),
      ],
    );
  }
}
