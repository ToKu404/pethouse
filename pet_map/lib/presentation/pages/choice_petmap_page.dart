import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pet/presentation/bloc/get_pet/get_pet_bloc.dart';
import 'package:pet_map/pet_map.dart';

class ChoicePetPage extends StatefulWidget {
  final String userId;
  const ChoicePetPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ChoicePetPage> createState() => _ChoicePetPageState();
}

class _ChoicePetPageState extends State<ChoicePetPage> {
  String petName = '';
  String petPictureUrl = '';
  int selectedPet = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPetBloc>(context).add(FetchListPet());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PetmapCubit, PetmapState>(
      listener: (context, state) {
        if (state is CheckPetMapExists) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            color: kPrimaryColor,
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choice One Of Your Pet to Use this Feature',
                  style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<GetPetBloc, GetPetState>(
                  builder: (context, state) {
                    if (state is GetPetLoading) {
                      return const LoadingView();
                    } else if (state is GetPetSuccess) {
                      petName = state.listPet[0].petName!;
                      petPictureUrl = state.listPet[0].petPictureUrl ?? '';
                      return SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: state.listPet.length,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final petMap = state.listPet[index];
                            return InkWell(
                              onTap: () {
                                petName = petMap.petName!;
                                petPictureUrl = petMap.petPictureUrl ?? '';
                                selectedPet = index;
                                setState(() {});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: index == selectedPet
                                          ? Border.all(
                                              width: 2, color: kPrimaryColor)
                                          : null,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              petMap.petPictureUrl!),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Text(
                                    state.listPet[index].petName ?? '-',
                                    style: kTextTheme.bodyText1
                                        ?.copyWith(color: kDarkBrown),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is GetAllPetMapError) {
                      return const ErrorView(message: 'Error when get pet map');
                    } else {
                      return Container();
                    }
                  },
                ),
                DefaultButton(
                    height: 50,
                    width: double.infinity,
                    onTap: () async {
                      LatLng initPosition = await _deteriminePostion();
                      _onSubmitPetmap(initPosition);
                    },
                    isClicked: false,
                    text: 'Continue')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitPetmap(LatLng initPosition) {
    PetMapEntity petMapEntity = PetMapEntity(
        id: widget.userId,
        latitude: initPosition.latitude,
        longitude: initPosition.longitude,
        petPhotoUrl: petPictureUrl,
        name: petName);
    BlocProvider.of<PetmapCubit>(context).onCreatePetMap(petMapEntity);
  }

  Future<LatLng> _deteriminePostion() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Service Are Disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission Denied Permanently');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
