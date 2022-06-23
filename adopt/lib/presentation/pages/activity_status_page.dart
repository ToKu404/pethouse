import 'package:adopt/presentation/blocs/open_adopt_status_bloc/open_adopt_status_bloc.dart';
import 'package:adopt/presentation/widgets/pet_adopt_owner_card.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/adopt_enitity.dart';

class ActivityStatusPage extends StatefulWidget {
  const ActivityStatusPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ActivityStatusPage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ActivityStatusPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OpenAdoptStatusBloc>(context).add(FetchListOpenAdopt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F9),
      appBar: const DefaultAppBar(title: 'Activity Status',),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            BlocBuilder<OpenAdoptStatusBloc, OpenAdoptStatusState>(
              builder: (context, state) {
                if (state is ActivityStatusLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListOpenAdoptLoaded) {
                  return _buildOpenAdoptStatus(state.adoptList);
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildOpenAdoptStatus(List<AdoptEntity> adoptList) {
    if (adoptList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Open Adopt Status',
            style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: adoptList.length,
                itemBuilder: (context, index) {
                  return PetAdoptOwnerCard(
                    adopt: adoptList[index],
                  );
                }),
          )
        ],
      );
    } else {
      return Container();
    }
  }

}
