import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetMapPage extends StatefulWidget {
  const PetMapPage({Key? key}) : super(key: key);

  @override
  State<PetMapPage> createState() => _PetMapPageState();
}

class _PetMapPageState extends State<PetMapPage> {
  late GoogleMapController mapController;
  final LatLng _myLocation = const LatLng(-5.1544064, 119.4491904);

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
    setState(() {
      _markers.add(Marker(
          markerId: const MarkerId('id-1'),
          position: _myLocation,
          infoWindow:
              const InfoWindow(title: 'Location', snippet: 'A Location')));
    });
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
          Expanded(
              child: Stack(
            children: [
              GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _onMapCreated(controller);
                  },
                  markers: _markers,
                  initialCameraPosition:
                      CameraPosition(target: _myLocation, zoom: 15)),
              Positioned(
                top: 10,
                left: 10,
                child: InkWell(
                  onTap: () async {
                    Position position = await _deteriminePostion();
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 15)));
                    _markers.removeWhere(
                        (element) => element.markerId == MarkerId('id-1'));
                    _markers.add(Marker(
                        markerId: const MarkerId('id-1'),
                        position:
                            LatLng(position.latitude, position.longitude)));
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 13,
                          color: const Color(0xFF000000).withOpacity(.07)),
                      BoxShadow(
                          blurRadius: 5,
                          color: const Color(0xFF000000).withOpacity(.05))
                    ], shape: BoxShape.circle, color: kWhite),
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.my_location_outlined,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Future<Position> _deteriminePostion() async {
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

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
