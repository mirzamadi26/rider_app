class RideRequestModel {
  final String createdAt;
  final String riderName;
  final String riderPhone;
  final String pickUpAddress;
  final String destinationAddress;
  final Map<String, dynamic> location;
  final Map<String, dynamic> destination;
  final String paymentMethod;
  final String driverId;

  RideRequestModel({
    required this.createdAt,
    required this.riderName,
    required this.riderPhone,
    required this.pickUpAddress,
    required this.destinationAddress,
    required this.location,
    required this.destination,
    required this.paymentMethod,
    required this.driverId,
  });

  factory RideRequestModel.fromJson(Map<String, dynamic> json) {
    return RideRequestModel(
      createdAt: json['created_at'],
      riderName: json['riderName'],
      riderPhone: json['rider_phone'],
      pickUpAddress: json['pickUp_address'],
      destinationAddress: json['destination_address'],
      location: json['location'],
      destination: json['destination'],
      paymentMethod: json['payment_method'],
      driverId: json['driver_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'riderName': riderName,
      'rider_phone': riderPhone,
      'pickUp_address': pickUpAddress,
      'destination_address': destinationAddress,
      'location': location,
      'destination': destination,
      'payment_method': paymentMethod,
      'driver_id': driverId,
    };
  }
}
