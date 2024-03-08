class BloodRequestModel {
  String? uid;
  String? displayName;
  String? age;
  String? bloodGroup;
  String? city;
  String? hospital;
  String? location;
  String? phoneNumber;
  String? message;
  String? latitude;
  String? longitude;

  BloodRequestModel({
    required this.uid,
    required this.displayName,
    required this.age,
    required this.bloodGroup,
    required this.city,
    required this.hospital,
    required this.location,
    required this.phoneNumber,
    required this.message,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create an instance from a map
  factory BloodRequestModel.fromMap(Map<String, dynamic> map) {
    return BloodRequestModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      age: map['age'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      city: map['city'] ?? '',
      hospital: map['hospital'] ?? '',
      location: map['location'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      message: map['message'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'age': age,
      'bloodGroup': bloodGroup,
      'city': city,
      'hospital': hospital,
      'location': location,
      'phoneNumber': phoneNumber,
      'message': message,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
