// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PetMapPage extends StatefulWidget {
  const PetMapPage({Key? key}) : super(key: key);

  @override
  State<PetMapPage> createState() => _PetMapPageState();
}

class _PetMapPageState extends State<PetMapPage> {
  late MapController mapController;
  final MAPBOX_TOKEN =
      'pk.eyJ1IjoidG9rdTQwNCIsImEiOiJjbDNib3g3eHIwYmV5M2VsN3Via29iaHc4In0.4RY23MMPBuWzBLcZSWIZ_A';
  final MAPBOX_STYLE = 'mapbox/light-v10';

  final List<Marker> markers = [
    Marker(
        height: 40,
        width: 40,
        point: LatLng(-5.1393895, 119.4869864),
        builder: (context) {
          return InkWell(
            onTap: () {
              print('test');
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kDarkBrown,
              ),
              padding: const EdgeInsets.all(5),
              child: const CircleAvatar(
                backgroundColor: kPrimaryColor,
                backgroundImage: NetworkImage(
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpicfiles.alphacoders.com%2F311%2F311202.jpg&f=1&nofb=1'),
              ),
            ),
          );
        }),
    Marker(
        height: 40,
        width: 40,
        point: LatLng(-5.1373, 119.4282),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kDarkBrown,
            ),
            padding: const EdgeInsets.all(5),
            child: const CircleAvatar(
              backgroundColor: kPrimaryColor,
              backgroundImage: NetworkImage(
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpicfiles.alphacoders.com%2F311%2F311202.jpg&f=1&nofb=1'),
            ),
          );
        }),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }

  _buildMap(MapController mc) async {
    mapController = mc;
    LatLng myPostion = await _deteriminePostion();
    mapController.move(myPostion, 15);
    markers.removeWhere(
      (element) => element.key == const Key('myPosition'),
    );
    Marker myLocationMarker = Marker(
      point: myPostion,
      height: 40,
      key: const Key('myPosition'),
      width: 40,
      builder: (_) {
        return CachedNetworkImage(
          imageUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpicfiles.alphacoders.com%2F311%2F311202.jpg&f=1&nofb=1',
          placeholder: (context, url) => Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/user_location.png'))),
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: kPrimaryColor),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      },
    );
    markers.add(myLocationMarker);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pet Maps",
                  style: kTextTheme.headline5?.copyWith(color: kDarkBrown),
                ),
                InkWell(
                  onTap: () async {
                    print(markers.length);
                    LatLng myPostion = await _deteriminePostion();
                    mapController.move(myPostion, 15);
                    markers.removeWhere(
                      (element) => element.key == const Key('myPosition'),
                    );
                    Marker myLocationMarker = Marker(
                      point: myPostion,
                      height: 40,
                      key: const Key('myPosition'),
                      width: 40,
                      builder: (_) {
                        return CachedNetworkImage(
                          imageUrl:
                              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpicfiles.alphacoders.com%2F311%2F311202.jpg&f=1&nofb=1',
                          placeholder: (context, url) => Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user_location.png'))),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1, color: kPrimaryColor),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                    );
                    markers.add(myLocationMarker);
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
                )
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                  center: LatLng(-5.1544064, 119.4491904),
                  zoom: 15,
                  maxZoom: 15,
                  minZoom: 10,
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  onMapCreated: (MapController mc) {
                    _buildMap(mc);
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
          )
        ],
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
