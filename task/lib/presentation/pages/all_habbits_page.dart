import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:task/presentation/blocs/get_habbit_bloc/get_habbit_bloc.dart';

import '../widgets/habbit_card.dart';

class AllHabbitPage extends StatefulWidget {
  final PetEntity petEntity;
  const AllHabbitPage({Key? key, required this.petEntity}) : super(key: key);

  @override
  State<AllHabbitPage> createState() => _AllHabbitPageState();
}

class _AllHabbitPageState extends State<AllHabbitPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetHabbitBloc>(context)
        .add(FetchHabbits(petId: widget.petEntity.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: '${widget.petEntity.petName} Tasks',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<GetHabbitBloc, GetHabbitState>(
            builder: (context, state) {
              if (state is GetHabbitLoading) {
                return const LoadingView();
              } else if (state is GetHabbitSuccess) {
                return ListView.builder(
                    itemCount: state.listHabbit.length,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      return HabbitCard(
                        habbit: state.listHabbit[index],
                      );
                    });
              } else if (state is GetHabbitError) {
                return ErrorView(message: state.message);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ADD_HABBIT_ROUTE_NAME,
            arguments: widget.petEntity),
        foregroundColor: kWhite,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
