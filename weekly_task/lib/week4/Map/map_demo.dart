import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as prefix;
// import 'package:google_maps_webservice/geolocation.dart';
// import 'package:google_maps_webservice/places.dart' as prefix;
// import 'package:search_map_location/search_map_location.dart';
// import 'package:search_map_location/utils/google_search/geo_location.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/utils/google_search/place_type.dart';

const googleApikey = "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk";

class Mapdemo extends StatefulWidget {
  const Mapdemo({Key? key}) : super(key: key);

  @override
  State<Mapdemo> createState() => _MapdemoState();
}

class _MapdemoState extends State<Mapdemo> {
  late GoogleMapController mapController;

  String location = "Search Location";

//textfield controller
  TextEditingController startController = new TextEditingController();
  TextEditingController destiController = new TextEditingController();

//marker List

  int id = 1;

  Set<Marker> markersList = {};

//camera position
  static const _initposition = CameraPosition(
    zoom: 15.0,
    target: LatLng(21.2335705, 72.8551871),
  );

//api keys for polylines place
  prefix.GoogleMapsPlaces _places =
      prefix.GoogleMapsPlaces(apiKey: googleApikey);
  PolylinePoints _polylinePoints = PolylinePoints();

//polyline list
  Map<PolylineId, Polyline> polylineRoute = {};
  List<LatLng> routeCoords = [];

  late Marker _origin;
  late Marker _destination;

  prefix.PlaceDetails? startingLoc;
  prefix.PlaceDetails? destinationLoc;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool isLongpress = false;

  //start location prediction
  Future<Null> startpoint(prefix.Prediction p) async {
    // startingLoc = null;
    if (p != null) {
      // get detail (lat/lng)
      prefix.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId.toString());
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      startingLoc = detail.result;
      startController.text = detail.result.name;

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 10.0)));

      markersList.add(Marker(
          markerId: MarkerId('startLoc'),
          infoWindow: InfoWindow(
              title: "${lat} , ${lng} ${detail.result.formattedAddress} ",
              snippet: 'starting point'),
          position: LatLng(lat, lng)));

      computePath();
      setState(() {});
    }
  }

  //destination location prediction
  Future<Null> destinationpoint(prefix.Prediction p) async {
    // destinationLoc = null;
    if (p != null) {
      // get detail (lat/lng)
      prefix.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId.toString());
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      destinationLoc = detail.result;
      destiController.text = detail.result.name;

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 10.0)));

      markersList.add(Marker(
          markerId: MarkerId('destinationLoc'),
          infoWindow: InfoWindow(
              title: "${lat} , ${lng} ${detail.result.formattedAddress} ",
              snippet: 'destination'),
          position: LatLng(lat, lng)));

      // if(startingLoc != null){
      //   polylineRoute.remove(PolylineId("poly"));
      //   setState(() {
      //
      //   });
      computePath();
      setState(() {});
      // }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text("Map demo"),
      //   backgroundColor: Colors.black87,
      // ),
      body: Container(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  markers: Set.from(markersList),
                  polylines: Set<Polyline>.of(polylineRoute.values),
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  // onLongPress: _addmarker,
                  onTap: (LatLng latlng) {
                    Marker newMarker = Marker(
                        markerId: MarkerId('$id'),
                        position: LatLng(latlng.latitude, latlng.longitude),
                        infoWindow: InfoWindow(title: '${latlng}'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRose));
                    markersList.add(newMarker);
                    id++;
                    setState(() {});
                    print("our first and last : $latlng");
                  },
                  onMapCreated: (GoogleMapController googleMapController) {
                    mapController = googleMapController;
                  },
                  initialCameraPosition: _initposition,
                  mapType: MapType.normal,
                ),
              ),
              Positioned(
                  top: 40.0,
                  right: 15.0,
                  left: 15.0,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                      hintText: 'start',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15.0, top: 15.0),
                                      suffixIcon: Icon(Icons.search)),
                                  controller: startController,
                                  onTap: () async {
                                    polylineRoute.clear();

                                    prefix.Prediction? p =
                                        await PlacesAutocomplete.show(
                                            context: context,
                                            apiKey: googleApikey,
                                            mode: Mode.overlay,
                                            types: [],
                                            strictbounds: false,
                                            language: "en",
                                            components: [
                                              new prefix.Component(
                                                  prefix.Component.country,
                                                  "ind")
                                            ]);
                                    startpoint(p!);
                                  },
                                  //onEditingComplete: searchAndNavigate,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                      hintText: 'destination',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15.0, top: 15.0),
                                      suffixIcon: Icon(Icons.search)),
                                  controller: destiController,
                                  onTap: () async {
                                    polylineRoute.clear();
                                    prefix.Prediction? p =
                                        await PlacesAutocomplete.show(
                                            context: context,
                                            apiKey: googleApikey,
                                            mode: Mode.overlay,
                                            language: "en",
                                            types: [],
                                            strictbounds: false,
                                            components: [
                                              new prefix.Component(
                                                  prefix.Component.country,
                                                  "ind")
                                            ]);
                                    destinationpoint(p!);
                                  },
                                  //onEditingComplete: searchAndNavigate,
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
              // Positioned(
              //   //search input bar
              //   top: 10,
              //   child: InkWell(
              //     onTap: () async {
              //       Prediction place = await PlacesAutocomplete.show(
              //           context: context,
              //           apiKey: googleApikey,
              //           mode: Mode.overlay,

              //           // offset: 0,
              //           hint: "type location",
              //           // radius: 1000,
              //           types: [],
              //           // components: [Component(Component.country, 'ind')],
              //           onError: (err) {
              //             print(err);
              //           });
              //           didpla

              //       // if (place != null) {
              //       //   setState(() {
              //       //     location = place.description.toString();
              //       //   });

              //       //   //         //form google_maps_webservice package
              //       //   final plist = GoogleMapsPlaces(
              //       //     apiKey: googleApikey,
              //       //     apiHeaders: await GoogleApiHeaders().getHeaders(),
              //       //     //from google_api_headers package
              //       //   );
              //       //   final placeid = place.placeId;
              //       //   final detail = await plist.getDetailsByPlaceId(placeid);
              //       //   final geometry = detail.result.geometry!;
              //       //   final lat = geometry.location.lat;
              //       //   final lang = geometry.location.lng;
              //       //   var newlatlang = LatLng(lat, lang);

              //       //   //         //move map camera to selected place with animation
              //       //   setState(() {
              //       //     mapController.animateCamera(
              //       //         CameraUpdate.newCameraPosition(
              //       //             CameraPosition(target: newlatlang, zoom: 17)));
              //       //   });
              //       // }
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.all(15),
              //       child: Card(
              //         child: Container(
              //             padding: EdgeInsets.all(0),
              //             width: MediaQuery.of(context).size.width - 40,
              //             child: ListTile(
              //               title: Text(
              //                 location,
              //                 style: TextStyle(fontSize: 18),
              //               ),
              //               trailing: Icon(Icons.search),
              //               dense: true,
              //             )),
              //       ),
              //     ),
              //   ),
              // )
              //google_map_webservice package

              // Positioned(
              //   left: 20,
              //   top: 35,
              //   child: SearchLocation(
              //     hasClearButton: true,
              //     placeType: PlaceType.address,
              //     placeholder: "Enter Address",
              //     apiKey: "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk",
              //     onSelected: (Place place) async {
              //       Geolocation? geolocation = await place.geolocation;

              //       mapController.animateCamera(
              //           CameraUpdate.newLatLng(geolocation!.coordinates));

              //       mapController.animateCamera(CameraUpdate.newLatLngBounds(
              //           geolocation.coordinates, 15));
              //     },
              //   ),
              // ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await _determinePosition();
          var lati = position.latitude;
          var longi = position.longitude;

          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));

          markersList.add(Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(position.latitude, position.longitude)));

          setState(() {});
        },
        child: Icon(
          Icons.center_focus_strong,
        ),
      ),
    );
  }

  Future<void> computePath() async {
    routeCoords.clear();
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      googleApikey,
      PointLatLng(startingLoc!.geometry!.location.lat,
          startingLoc!.geometry!.location.lng),
      PointLatLng(destinationLoc!.geometry!.location.lat,
          destinationLoc!.geometry!.location.lng),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addpoly(routeCoords);
  }

//   Future<Null> displayPrediction(Prediction p) async {
//   if (p != null) {
//     // get detail (lat/lng)
//     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
//         p.placeId);
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;

//     setState(() {
//       placeController.text = detail.result.name;
//       Marker marker = Marker(
//           markerId: MarkerId('destinationlocMarker'),
//           draggable: false,
//           infoWindow: InfoWindow(
//             title: "This is where you searched",
//           ),
//           position: LatLng(lat, lng)
//       );
//       markersList.add(marker);
//     });
// }

  // Future<void> _showsearchdialog() async {
  //   var place = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: googleApikey,
  //     mode: Mode.fullscreen,
  //     language: "eng",
  //     offset: 0,
  //     hint: "type location",
  //     radius: 1000,
  //     types: [],
  //   );

  //   _getLocationFromPlaceId(place!.placeId);
  //   print("-------------------");
  //   print(place.placeId);
  // }

  // Future<void> _getLocationFromPlaceId(String placeId) async {
  //   GoogleMapsPlaces _places = GoogleMapsPlaces(
  //     apiKey: googleApikey,
  //     apiHeaders: await GoogleApiHeaders().getHeaders(),
  //   );
  //   PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

  //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(detail.result.geometry!.location.lat,
  //         detail.result.geometry!.location.lng),
  //   )));
  //   print("-----------------");
  //   print(placeId);
  // }

  // void _addmarker(LatLng pos) {
  //   print("Longpress");
  //   print(pos);
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     setState(() {
  //       _origin = Marker(
  //           markerId: MarkerId('origin'),
  //           infoWindow: InfoWindow(title: 'Origin'),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(
  //               BitmapDescriptor.hueGreen),
  //           position: pos);
  //     });
  //   } else {
  //     setState(() {
  //       _destination = Marker(
  //           markerId: MarkerId('destination'),
  //           infoWindow: InfoWindow(title: 'destination'),
  //           icon:
  //               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //           position: pos);
  //     });
  //   }
  //   markersList.add(_origin);
  //   markersList.add(_destination);

  //   setState(() {});
  // }

  void addpoly(List<LatLng> routeCoords) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Color.fromARGB(255, 0, 64, 255),
        points: routeCoords,
        width: 8);
    polylineRoute[id] = polyline;
    setState(() {});
  }
}



//runnning file