import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDemo extends StatefulWidget {
  const MapDemo({Key? key}) : super(key: key);

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  String mapStyle = """[
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]""";
  final Set<Marker> HomeMarkers = new Set();
  static const LatLng homeShowLocation = LatLng(53.350140, -6.266155);
  Set<Marker> getHomeMarkers() {
    setState(() {
      HomeMarkers.add(Marker(
        markerId: MarkerId(homeShowLocation.toString()),
        position: const LatLng(53.350140, -6.266155), //position of marker
        infoWindow: const InfoWindow(
          title: 'Home Office',
          snippet: '7080 Donlon Way, Suite 200, Dublin CA 94568',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    return HomeMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            height: Get.height * 0.30,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                  ),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  onMapCreated: (controller) async {
                    mapController = controller;
                    mapController?.setMapStyle(mapStyle);
                    await Future.delayed(const Duration(seconds: 1));
                    mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        // const LatLng(21.233481, 72.863687),
                        const LatLng(53.350140, -6.266155),
                        15,
                      ),
                    );
                    // if (post.addresses.length > 1) {
                    //   mapController?.animateCamera(
                    //     CameraUpdate.newLatLngBounds(
                    //       post.boundsFromLatLngList!,
                    //       50,
                    //     ),
                    //   );
                    // } else {
                    //   mapController?.animateCamera(
                    //     CameraUpdate.newLatLngZoom(
                    //       LatLng(
                    //         post.addresses[0].position.latitude,
                    //         post.addresses[0].position.longitude,
                    //       ),
                    //       15,
                    //     ),
                    //   );
                    // }
                  },
                  buildingsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  // polylines: {
                  //   Polyline(
                  //     polylineId: const PolylineId('1'),
                  //     color: Theme.of(context).primaryColor,
                  //     patterns: const [PatternItem.dot],
                  //     width: 6,
                  //     points: post.addresses
                  //         .map(
                  //           (e) => LatLng(
                  //             e.position.latitude,
                  //             e.position.longitude,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // },
                  // markers: post.addresses
                  //     .map(
                  //       (e) => Marker(
                  //         markerId: MarkerId(
                  //           e.position.latitude.toString(),
                  //         ),
                  //         position: LatLng(
                  //           e.position.latitude,
                  //           e.position.longitude,
                  //         ),
                  //         anchor: const Offset(0.5, 0.5),
                  //         icon: Data.mapPin ?? BitmapDescriptor.defaultMarker,
                  //         onTap: () {
                  //           postAddress(e);
                  //         },
                  //       ),
                  //     )
                  //     .toSet(),
                  markers: getHomeMarkers(),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      color: const Color(0xFFFAFAFA),
                      width: 40,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await mapController?.animateCamera(CameraUpdate.zoomIn());
                            },
                          ),
                          const SizedBox(height: 2),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () async {
                              await mapController?.animateCamera(CameraUpdate.zoomOut());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
