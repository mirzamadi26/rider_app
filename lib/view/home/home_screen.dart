import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as loc;
import 'package:riders/helpers/helperMethods.dart';
import 'package:riders/model/directionDetails.dart';
import 'package:riders/view/home/searchPage_screen.dart';
import '../../model/address_model.dart';
import '../../model/ride_request_model.dart';
import '../../provider/appdata.dart';
import '../../services/database_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/global_variables.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/drawer_icon.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/textfield_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TextEditingController whereToController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  LatLng? pickLocation;
  loc.Location location = loc.Location();

  Position? currentPosition;

  List<LatLng> polyLineCoordinates = [];
  Set<Polyline> polyLines = {};
  Set<Marker> _Markers = {};
  Set<Circle> _Circles = {};
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _percent = 0.0;
  double h = 100;
  double w = double.maxFinite;
  Color? color;
  var readableAddress;
  User? user = FirebaseAuth.instance.currentUser;
  bool drawerCanOpen = true;

  double rideContainerHeight = 0;
  double rideDetailsSheetHeight = 0;
  double rideDetailsSheetMaxHeight = 0;

  double searchSheetHeight = 0.15;
  double confirmRideHeight = 0;
  double driveConnectSheetHeight = 0;
  int index = 1;
  List cars = [
    {'id': 0, 'name': 'Uber Go', 'price': 15},
    {'id': 1, 'name': 'Go Saden', 'price': 230},
    {'id': 2, 'name': 'UberXL', 'price': 400},
    {'id': 3, 'name': 'Uber Auto', 'price': 150},
    {'id': 4, 'name': "Rider", 'price': 150},
  ];

  DirectionDetails? tripDirectionDetails;
  DatabaseService databaseService = DatabaseService();

  void showDetailSheet() {
    setState(() {
      searchSheetHeight = 0;
      rideDetailsSheetHeight = 0.4;
      rideDetailsSheetMaxHeight = 0.9;
      rideContainerHeight = MediaQuery.of(context).size.height / 6.5;
      drawerCanOpen = false;
    });
  }

  void showDriverConnectSheet() async {
    setState(() {
      rideDetailsSheetHeight = 0;
      rideDetailsSheetMaxHeight = 0;
      rideContainerHeight = 0;
      driveConnectSheetHeight = 0.35;
    });

    String rideRequestId = await databaseService.createRideRequest(context);
  }

  var geolocator = Geolocator();
  void setupPositionLocator() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cp));
    String address =
        await HelperMethods.findCoordinateAddress(position, context);
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.68,
        child: SingleChildScrollView(
          child: Column(
            children: const [MyDrawerHeader()],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              polylines: polyLines,
              markers: _Markers,
              circles: _Circles,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleMapController = controller;
                setupPositionLocator();
              },
              onCameraMove: (CameraPosition? position) {
                if (pickLocation != position!.target) {
                  setState(() {
                    pickLocation = position.target;
                  });
                }
              },
              initialCameraPosition: cameraPosition,
            ),

            // Menu Button
            Positioned(
              left: 20,
              top: 10,
              child: InkWell(
                onTap: () {
                  if (drawerCanOpen) {
                    scaffoldKey.currentState!.openDrawer();
                  } else {
                    resetApp();
                  }
                },
                child: Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 21,
                    child: Icon((drawerCanOpen) ? Icons.menu : Icons.arrow_back,
                        size: 20, color: Colors.black),
                  ),
                ),
              ),
            ),

            //Confirm Order

            // Select Desitination

            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: DraggableScrollableSheet(
                  minChildSize: searchSheetHeight,
                  initialChildSize: searchSheetHeight,
                  maxChildSize: 0.15,
                  builder: ((context, scrollController) {
                    return Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Divider(
                                    thickness: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var response = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchLocationScreen()));
                                    if (response == 'getDirection') {
                                      await getDirection();
                                      showDetailSheet();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              spreadRadius: 0.5,
                                              offset: Offset(0.7, 0.7)),
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Search Destination")
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  })),
            ),
            //Ride Detail sheet
            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: DraggableScrollableSheet(
                  minChildSize: rideDetailsSheetHeight,
                  initialChildSize: rideDetailsSheetHeight,
                  maxChildSize: rideDetailsSheetMaxHeight,
                  builder: ((context, scrollController) {
                    return Container(
                        color: Colors.white,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: cars.length,
                          itemBuilder: ((context, index) {
                            final car = cars[index];
                            if (index == 0) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Divider(
                                      thickness: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.mainColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              color = Colors.green[100];
                                            });
                                          },
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          leading:
                                              Icon(Icons.time_to_leave_sharp),
                                          subtitle: Text(
                                            (tripDirectionDetails != null)
                                                ? tripDirectionDetails!
                                                    .durationText!
                                                    .toString()
                                                : '',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          title: Text(car['name'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                          trailing: Text(
                                            (tripDirectionDetails != null)
                                                ? '€${HelperMethods.estimateFares(tripDirectionDetails!)}'
                                                : '',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.3,
                                  )
                                ],
                              ),
                            );
                          }),
                        ));
                  })),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 5,
                child: Container(
                  height: rideContainerHeight,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.payment_rounded,
                              color: AppColors.mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Cash",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Icon(Icons.keyboard_arrow_down_sharp)
                                  ],
                                ),
                                Text(
                                  "Personal Trip",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonWidget(
                            backgroundColor: AppColors.mainColor,
                            text: "Book Go Saden",
                            textColor: Colors.white,
                            function: () {
                              showDriverConnectSheet();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),

            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 150),
              child: DraggableScrollableSheet(
                  minChildSize: driveConnectSheetHeight,
                  initialChildSize: driveConnectSheetHeight,
                  maxChildSize: 0.4,
                  builder: ((context, scrollController) {
                    return Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 15, right: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Divider(
                                    thickness: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Connection to your driver",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "The driver will be on their way as soon as they confirm",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                              color: AppColors.mainColor,
                                              size: 30),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          databaseService.fetchRideRequestId();

                                          resetApp();
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          size: 40,
                                        )),
                                    SizedBox(height: 10),
                                    Text("Cancel trip"),
                                    SizedBox(height: 20),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.payment_rounded,
                                                color: AppColors.mainColor,
                                              ),
                                              label: Text("Cash")),
                                          Text(
                                            "12.40£",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                    ButtonWidget(
                                        backgroundColor: AppColors.mainColor,
                                        text: "Complete Ride",
                                        textColor: Colors.white,
                                        function: () {
                                          databaseService
                                              .completeRide(user!.uid);
                                          resetApp();
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  })),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getDirection() async {
    var pickUp = Provider.of<AppData>(context, listen: false).pickUpAddress;
    var destination =
        Provider.of<AppData>(context, listen: false).destinationAddress;
    var pickLatLng = LatLng(pickUp!.latitude!, pickUp.longitude!);
    var destinationLatLng =
        LatLng(destination!.latitude!, destination.longitude!);
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: 'Please wait...'));
    var thisDetails =
        await HelperMethods.getDirectionDetails(pickLatLng, destinationLatLng);
    setState(() {
      tripDirectionDetails = thisDetails;
    });
    Navigator.pop(context);
    print(thisDetails!.encodedPoints);
    PolylinePoints polyLinePoints = PolylinePoints();
    List<PointLatLng> results =
        polyLinePoints.decodePolyline(thisDetails.encodedPoints!);
    polyLineCoordinates.clear();
    if (results.isNotEmpty) {
      results.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    polyLines.clear();
    setState(() {
      Polyline polyLine = Polyline(
        polylineId: PolylineId('polyId'),
        color: Color.fromARGB(255, 95, 109, 237),
        points: polyLineCoordinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polyLines.add(polyLine);
    });
    LatLngBounds bounds;
    if (pickLatLng.latitude > destinationLatLng.latitude &&
        pickLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickLatLng);
    } else if (pickLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
          northeast: LatLng(destinationLatLng.latitude, pickLatLng.longitude));
    } else if (pickLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
          northeast: LatLng(pickLatLng.latitude, destinationLatLng.longitude));
    } else {
      bounds =
          LatLngBounds(southwest: pickLatLng, northeast: destinationLatLng);
    }
    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

    Marker pickUpMarker = Marker(
        markerId: MarkerId('pickUp'),
        position: pickLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow:
            InfoWindow(title: pickUp.placeName, snippet: 'My Location'));
    Marker destinationMarker = Marker(
        markerId: MarkerId('destination'),
        position: destinationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:
            InfoWindow(title: destination.placeName, snippet: 'Destination'));
    setState(() {
      _Markers.add(pickUpMarker);
      _Markers.add(destinationMarker);
    });
    Circle pickUpCircle = Circle(
        circleId: CircleId('pickUp'),
        strokeColor: Colors.green,
        strokeWidth: 3,
        radius: 12,
        center: pickLatLng,
        fillColor: AppColors.mainColor);
    Circle destinationCircle = Circle(
      circleId: CircleId('destination'),
      strokeColor: Colors.purpleAccent,
      strokeWidth: 3,
      radius: 12,
      center: destinationLatLng,
      fillColor: Colors.purpleAccent,
    );
  }

  resetApp() {
    setState(() {
      polyLineCoordinates.clear();
      polyLines.clear();
      _Markers.clear();
      _Circles.clear();
      rideDetailsSheetHeight = 0;
      rideContainerHeight = 0;
      driveConnectSheetHeight = 0;
      rideDetailsSheetMaxHeight = 0;
      searchSheetHeight = 0.15;
      drawerCanOpen = true;
    });
  }
}
