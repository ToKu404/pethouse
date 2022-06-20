// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pet_map/pet_map.dart';

class BuildPetMapPage extends StatefulWidget {
  final String userId;
  const BuildPetMapPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BuildPetMapPage> createState() => _BuildPetMapPageState();
}

class _BuildPetMapPageState extends State<BuildPetMapPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late MapController mapController;
  final MAPBOX_TOKEN =
      'pk.eyJ1IjoidG9rdTQwNCIsImEiOiJjbDNib3g3eHIwYmV5M2VsN3Via29iaHc4In0.4RY23MMPBuWzBLcZSWIZ_A';
  final MAPBOX_STYLE = 'mapbox/light-v10';

  final _pageController = PageController();

  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPetMapBloc>(context).add(FetchPetMap(id: widget.userId));
    BlocProvider.of<GetAllPetMapBloc>(context).add(FetchAllPetMap());
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mapController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  _buildMap(MapController mc, PetMapEntity pm) async {
    mapController = mc;
    LatLng myPostion = await _deteriminePostion();
    mapController.move(myPostion, 15);
    markers.removeWhere(
      (element) => element.key == const Key('myPosition'),
    );
    Marker myLocationMarker = Marker(
      point: myPostion,
      height: 60,
      key: const Key('myPosition'),
      width: 60,
      builder: (_) {
        return _MyLocationMarker(_animationController);
      },
    );
    markers.add(myLocationMarker);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllPetMapBloc, GetAllPetMapState>(
      listener: (context, state) {
        if (state is GetAllPetMapSuccess) {
          List<PetMapEntity> petMaps = state.petMap;
          petMaps.removeWhere((element) => element.id == widget.userId);
          for (var pm in petMaps) {
            final mr = Marker(
                height: 40,
                width: 40,
                point: LatLng(pm.latitude!, pm.longitude!),
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      print('test');
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kGrey,
                      ),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: pm.petPhotoUrl ?? '',
                          placeholder: (context, url) => Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.person),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                });
            markers.add(mr);
          }
        }
      },
      child: BlocBuilder<GetPetMapBloc, GetPetMapState>(
        builder: (context, state) {
          if (state is GetPetMapLoading) {
            return const Center(child: const CircularProgressIndicator());
          } else if (state is GetPetMapSuccess) {
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                      center: LatLng(state.petMapEntity.latitude!,
                          state.petMapEntity.longitude!),
                      zoom: 15,
                      maxZoom: 15,
                      minZoom: 10,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      onMapCreated: (MapController mc) {
                        _buildMap(mc, state.petMapEntity);
                      }),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: {
                        'accessToken': MAPBOX_TOKEN,
                        'id': MAPBOX_STYLE,
                      },
                    ),
                    MarkerLayerOptions(
                      markers: markers,
                    )
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () async {
                      LatLng myPostion = await _deteriminePostion();
                      mapController.move(myPostion, 15);
                      markers.removeWhere(
                        (element) => element.key == const Key('myPosition'),
                      );
                      Marker myLocationMarker = Marker(
                        point: myPostion,
                        height: 60,
                        key: const Key('myPosition'),
                        width: 60,
                        builder: (_) {
                          return _MyLocationMarker(_animationController);
                        },
                      );
                      markers.add(myLocationMarker);
                      final newPm = PetMapEntity(
                          id: state.petMapEntity.id,
                          latitude: myPostion.latitude,
                          longitude: myPostion.longitude);
                      BlocProvider.of<PetmapCubit>(context)
                          .updatePetMap(newPm);
                      // setState(() {});
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: kWhite),
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.my_location_outlined,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: 20,
                //   height: MediaQuery.of(context).size.height * .2,
                //   child: PageView.builder(itemBuilder: ((context, index) {
                //     return _MapItemDetails();
                //   })),
                // )
              ],
            );
          } else {
            return const Text('Error');
          }
        },
      ),
    );
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

// ignore: unused_element
class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    const size = 60.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size * value,
              width: size * value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor.withOpacity(.5),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                  border: Border.all(width: 2, color: kWhite)),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/pethouse_icon.svg',
                  color: kWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
