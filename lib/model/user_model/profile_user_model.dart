class ProfileUserModel {
  final String uid;
  final String email;
  final String displayName;
  final String bloodGroup;
  final int phoneNumber;
  final int age;
  final String?
      photoURL; // It's optional in case the UserModel doesn't have a photo.

  ProfileUserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.age,
    required this.bloodGroup,
    required this.phoneNumber,
    this.photoURL,
  });

  // Create a method to convert the UserModel object to a map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'age': age,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroup,
    };
  }

  // Create a factory method to create a UserModel object from Firestore data.
  factory ProfileUserModel.fromMap(Map<String, dynamic> map) {
    return ProfileUserModel(
      uid: map['uid'],
      email: map['email'],
      age: map['age'],
      bloodGroup: map['bloodGroup'],
      phoneNumber: map['phoneNumber'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }
}
