import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:riders/helpers/requestHelper.dart';
import 'package:riders/provider/appdata.dart';
import 'package:riders/utils/global_variables.dart';

import '../model/address_model.dart';
import '../model/directionDetails.dart';

class HelperMethods {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = '';
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
      AddressModel pickUpAddress = new AddressModel();
      pickUpAddress.longitude = position.longitude;
      pickUpAddress.latitude = position.latitude;
      pickUpAddress.placeName = placeAddress;
      Provider.of<AppData>(context, listen: false)
          .updatePickUpAddress(pickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return null;
    }
    print(response);
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.durationText =
        response["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];
    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];
    return directionDetails;
  }

  static int estimateFares(DirectionDetails directionDetails) {
    //per km = €0.7
    //per minute = €0.3
    //base fare = €3
    double baseFare = 3;
    double distanceFare = (directionDetails.distanceValue! / 1000) * 0.7;
    double timeFare = (directionDetails.durationValue! / 60) * 0.3;
    double totalFare = baseFare + distanceFare + timeFare;
    return totalFare.truncate();
  }
}
