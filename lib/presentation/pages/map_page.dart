import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_map/pet_map.dart';
import 'package:pet_map/presentation/pages/build_petmap_page.dart';
import 'package:user/domain/entities/user_entity.dart';

class PetMapPage extends StatefulWidget {
  final UserEntity userEntity;
  const PetMapPage({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<PetMapPage> createState() => _PetMapPageState();
}

class _PetMapPageState extends State<PetMapPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PetmapCubit>(context)
        .checkPetMapStatus(widget.userEntity.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                    color: const Color(0xFF000000).withOpacity(.05))
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pet Maps",
                style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
              ),
            ),
          ),
          BlocBuilder<InternetCheckCubit, InternetCheckState>(
            builder: (context, state) {
              if (state is RealtimeCheckLost) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_off_rounded,
                          size: 30,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Failed to Load Petmap',
                          style: kTextTheme.headline6
                              ?.copyWith(color: kGreyTransparant),
                        ),
                        Text(
                          'No Internet Access!',
                          style: kTextTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return BlocListener<PetmapCubit, PetmapState>(
                  listener: (context, state) {
                    if (state is CheckPetMapEmpty) {
                      Navigator.pushNamed(context, CHOICE_PET_MAP_ROUTE_NAME,
                          arguments: widget.userEntity.uid);
                    }
                  },
                  child: BlocBuilder<PetmapCubit, PetmapState>(
                    builder: (context, state) {
                      if (state is CheckPetMapExists) {
                        return Expanded(
                            child: BuildPetMapPage(
                          userId: widget.userEntity.uid!,
                        ));
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
