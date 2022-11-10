import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class MapDemo extends StatefulWidget {
  const MapDemo({Key? key}) : super(key: key);

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  GoogleMapController? mapController;
  final addressController = TextEditingController();

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

  Uri? renderUrl;
  static const String googleMapsApiKey = "AIzaSyDdm-Ywb7OBY-aehPYvhYKiZZjIDn4kRAM";
  static const int defaultWidth = 600;
  static const int defaultHeight = 400;
  static const Map<String, String> defaultLocation = {"latitude": '37.0902', "longitude": '-95.7192'};

  _buildUrl() {
    try {
      var baseUri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {
          'size': '${defaultWidth}x$defaultHeight',
          'center': '${defaultLocation['latitude']},${defaultLocation['longitude']}',
          'zoom': '4',
          '${googleMapsApiKey}': ''
        },
      );
      setState(() {
        renderUrl = baseUri;
        print("renderUrl--------$renderUrl");
      });
    } catch (e) {
      print("renderUrl----error----$renderUrl");
    }
  }

  String data = "";
  var imageBytesMap;
  final Set<Marker> HomeMarkers = {};
  static const LatLng homeShowLocation = LatLng(53.350140, -6.266155);
  String mapPreviewImage({double? latitude, double? longitude}) {
    data = 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,'
        '$longitude&zoom=16&size=600x300&maptype=terrain&markers=color:green%7Clabel:A%7C$latitude,'
        '$longitude&key=AIzaSyARWer5afygEbBQHWBDTpZVdmSw5sz1rY4';
    print("mapPreviewImage===>>>$data");
    return data;
  }

  Set<Marker> getHomeMarkers() {
    setState(() {
      HomeMarkers.add(Marker(
        // anchor: const Offset(0.5, 0.5),
        // flat: true,
        // draggable: true,
        // visible: true,
        // consumeTapEvents: true,
        markerId: MarkerId(homeShowLocation.toString()),
        position: const LatLng(53.350140, -6.266155),
        //position of marker
        infoWindow: const InfoWindow(
          // anchor: const Offset(0.5, 0.5),
          title: 'Home Office',
          snippet: '7080 Donlon Way, Suite 200, Dublin CA 94568',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    return HomeMarkers;
  }

  final markers = <Marker>{};
  MarkerId markerId = const MarkerId("YOUR-MARKER-ID");
  LatLng latLng = const LatLng(43.2994, 74.2179);
  @override
  void initState() {
    markers.add(
      Marker(
        markerId: markerId,
        position: latLng,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildUrl();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: Get.height * 0.3,
              // padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    cameraTargetBounds: CameraTargetBounds.unbounded,

                    onMapCreated: (controller) async {
                      print("mapController----${mapController?.mapId}");
                      mapController = controller;
                      mapController?.setMapStyle(mapStyle);
                      await Future.delayed(const Duration(seconds: 1));
                      mapController?.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          const LatLng(21.233481, 72.863687),
                          // const LatLng(53.350140, -6.266155),
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
                      // }53.350140, -6.266155
                      mapPreviewImage(latitude: 21.233481, longitude: 72.863687);
                    },
                    onCameraMove: (position) {
                      setState(() {
                        markers.add(Marker(markerId: markerId, position: position.target));
                      });
                    },
                    buildingsEnabled: false,
                    // liteModeEnabled: true,
                    // tiltGesturesEnabled: true,
                    // indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    // myLocationButtonEnabled: false,
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
            const SizedBox(
              height: 20,
            ),
            Image.network(data),
            SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: 20,
            //       ),
            //     ),
            //     controller: addressController,
            //     onTap: () async {
            //       await showOkDialog(
            //         context,
            //         "Picker Map",
            //       );
            //       Get.to(
            //         () => PlacePicker(
            //           onMapCreated: (controller) {
            //             // mapController.
            //             mapController = controller;
            //             final imageBytes = mapController?.takeSnapshot();
            //
            //             setState(() {
            //               imageBytesMap = imageBytes;
            //             });
            //             print("PlacePicker ---------${imageBytesMap.toString()}- ");
            //           },
            //           hidePlaceDetailsWhenDraggingPin: true,
            //           autocompleteLanguage: 'en',
            //           apiKey: "AIzaSyARWer5afygEbBQHWBDTpZVdmSw5sz1rY4",
            //           onPlacePicked: (result) {
            //             print("PlacePicker ---------result- ");
            //             //
            //             // addressController.text = result.formattedAddress ?? '';
            //             // final imageBytes = mapController?.takeSnapshot();
            //             //
            //             // setState(() {
            //             //   imageBytesMap = imageBytes;
            //             // });
            //             print("result------$result");
            //             // currentAddress = PostAddress(
            //             //   fullAddress: result.formattedAddress!,
            //             //   streetAddress: result.formattedAddress!,
            //             //   city: result.formattedAddress!,
            //             //   state: result.formattedAddress!,
            //             //   country: result.formattedAddress!,
            //             //   position:
            //             //   ),
            //             // );
            //             GeoPoint(
            //               result.geometry!.location.lat,
            //               result.geometry!.location.lng,
            //             );
            //             Get.back();
            //           },
            //           initialMapType: MapType.hybrid,
            //           usePinPointingSearch: true,
            //           initialPosition: const LatLng(30.669777, 73.657004),
            //           useCurrentLocation: true,
            //         ),
            //       );
            //     },
            //     validator: (String? s) {
            //       if (s == null || s.isEmpty) {
            //         return "aaaaaa";
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // SizedBox(height: 50),
            // Image.network(renderUrl.toString()),
            // SizedBox(height: 20),
            // SizedBox(
            //   height: 250,
            //   width: 350,
            //   child: imageBytesMap != null
            //       ? Image.memory(
            //           imageBytesMap,
            //           fit: BoxFit.cover,
            //         )
            //       : const Text("Loading Image..."),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     mapController?.animateCamera(
            //       CameraUpdate.newLatLngZoom(
            //         const LatLng(21.233481, 72.863687),
            //         // const LatLng(53.350140, -6.266155),
            //         15,
            //       ),
            //     );
            //     final imageBytes = await mapController?.takeSnapshot();
            //
            //     setState(() {
            //       imageBytesMap = imageBytes;
            //     });
            //     // Get.to(const StaticMapDemo());
            //   },
            //   child: Text("StaticMapDemo"),
            // ),
            /*     TextFormField(
              controller: addressController,
              onTap: () async {
                await showOkDialog(
                  context,
                  "Picker Map",
                );
                Get.to(
                  () => PlacePicker(
                    initialPosition: const LatLng(
                      21.233481,
                      72.863687,
                    ),
                    apiKey: 'AIzaSyDdm-Ywb7OBY-aehPYvhYKiZZjIDn4kRAM',
                  ),
                );
              },
              validator: (String? s) {
                if (s == null || s.isEmpty) {
                  return "aaaaaa";
                }
                return null;
              },
            ),*/
          ]),
        ),
      ),
    );
  }

  // void showPlacePicker() async {
  //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //             initialMapType: MapType.hybrid,
  //             usePinPointingSearch: true,
  //             automaticallyImplyAppBarLeading: true,
  //             autocompleteOnTrailingWhitespace: true,
  //             initialPosition: const LatLng(
  //               21.233481,
  //               72.863687,
  //             ),
  //             apiKey: 'AIzaSyAF-ck0hICD1ji1klRX_J8Tsv3Zz7PU6vk',
  //           )));
  //
  //   // Handle the result in your way
  //   print("result----1--$result");
  // }

  Future showOkDialog(BuildContext context, String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF606A82)),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
