class UserModel {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String? userType;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.phoneNumber,
    this.photoURL,
    this.userType,
  });

  // Create a method to convert the UserModel object to a map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'userType': userType,
    };
  }

  // Create a factory method to create a UserModel object from Firestore data.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoURL: map['photoURL'] ?? '',
      userType: map['userType'] ?? '',
    );
  }
}
