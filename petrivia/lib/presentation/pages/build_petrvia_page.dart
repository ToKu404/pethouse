import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrivia/presentation/bloc/get_petrivia/get_petrivia_bloc.dart';
import 'package:petrivia/presentation/widget/card_petrivia.dart';

class BuildPetriviaPage extends StatefulWidget {
  const BuildPetriviaPage({Key? key}) : super(key: key);

  @override
  State<BuildPetriviaPage> createState() => _BuildPetriviaPageState();
}

class _BuildPetriviaPageState extends State<BuildPetriviaPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPetriviaBloc>(context).add(FetchListPetriviaEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
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
                onChanged: (query) {
                  BlocProvider.of<GetPetriviaBloc>(context)
                      .add(FetchSearchPetriviaEvent(query: query));
                },
                controller: searchController,
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
                    hintText: "Search petrivia",
                    fillColor: kWhite),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<GetPetriviaBloc, GetPetriviaState>(
              builder: (context, state) {
                if (state is GetPetriviaLoading) {
                  return const Expanded(child: LoadingView());
                } else if (state is GetPetriviaSuccess) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.listPetrivia.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardPetrivia(
                        petriviaEntity: state.listPetrivia[index],
                      );
                    },
                  );
                } else if (state is GetPetriviaError) {
                  return ErrorView(message: state.message);
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
