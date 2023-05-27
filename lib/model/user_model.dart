class UserModel {
  late String? firstName;
  late String? lastName;
  late String? mobileNumber;
  late String? email;
  late String? profileImageUrl = '';
  bool? isLoggedin = false;
  late String? authProvider;

  UserModel({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.isLoggedin,
    this.authProvider,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobileNumber: json['mobileNumber'],
        email: json['email'],
        isLoggedin: json['isLoggedin'],
        authProvider: json['authProvider'],
        profileImageUrl: json['profielImageUrl']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['firstName'] = firstName;
    jsonMap['lastName'] = lastName;
    jsonMap['mobileNumber'] = mobileNumber;
    jsonMap['email'] = email;
    jsonMap['isLoggedin'] = isLoggedin;
    jsonMap['authProvider'] = authProvider;
    jsonMap['profileImageUrl'] = profileImageUrl;

    return jsonMap;
  }
}
