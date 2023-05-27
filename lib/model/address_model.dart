class AddressModel {
  String? placeName;
  double? latitude;
  double? longitude;
  String? placeId;
  String? placeFormattedAddress;

  AddressModel(
      {this.placeId,
      this.latitude,
      this.longitude,
      this.placeName,
      this.placeFormattedAddress});
}
