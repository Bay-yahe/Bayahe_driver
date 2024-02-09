class UserModel {
  String firstname;
  String lastname;
  String email;
  String address;
  String birthday;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.birthday,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      address: map['address'] ?? '',
      birthday: map['birthday'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "uid": uid,
      "address": address,
      "birthday": birthday,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}
