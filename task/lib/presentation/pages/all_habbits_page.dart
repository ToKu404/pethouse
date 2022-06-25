import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:task/presentation/blocs/get_habbit_bloc/get_habbit_bloc.dart';

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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetHabbitSuccess) {
                return ListView.builder(
                    itemCount: state.listHabbit.length,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 13,
                                color:
                                    const Color(0xFF000000).withOpacity(.07)),
                            BoxShadow(
                                blurRadius: 5,
                                color: const Color(0xFF000000).withOpacity(.05))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.listHabbit[index].activityType ?? '-',
                              style: kTextTheme.subtitle2
                                  ?.copyWith(color: kPrimaryColor),
                            ),
                            Text(
                              state.listHabbit[index].title ?? '-',
                              style: kTextTheme.subtitle1,
                            ),
                            Text(
                              state.listHabbit[index].repeat == 'Custom'
                                  ? _getDayRepeat(
                                      state.listHabbit[index].dayRepeat!)
                                  : state.listHabbit[index].repeat,
                              style: kTextTheme.bodyText1,
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return const Text('Failed');
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

  _getDayRepeat(List<String> dayRepeat) {
    String repeatDays = '';
    for (var element in dayRepeat) {
      repeatDays += ("${element.toUpperCase()} ");
    }
    return repeatDays;
  }
}
