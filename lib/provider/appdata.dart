import 'package:flutter/material.dart';

import '../model/address_model.dart';

class AppData extends ChangeNotifier {
  AddressModel? pickUpAddress;
  AddressModel? destinationAddress;
  void updatePickUpAddress(AddressModel pickUp) {
    pickUpAddress = pickUp;
    notifyListeners();
  }

  void updateDestinationAddress(AddressModel destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}
