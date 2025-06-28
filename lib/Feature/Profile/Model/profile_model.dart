// class ProfileModel {
//   final int userId;
//   final String? displayNumber;
//   final String? token;

//   final String? firstname;
//   final String? lastname;
//   final String? email;
//   final String? phoneNumber;
//   final String? address;
//   final String role;
//   final String? profilePicture;
//   final String? registrationDate;
//   final String createdAt;
//   final String updatedAt;

//   ProfileModel({
//     required this.userId,
//     this.displayNumber,
//     this.token,
//     this.firstname,
//     this.lastname,
//     this.email,
//     this.phoneNumber,
//     this.address,
//     required this.role,
//     this.profilePicture,
//     this.registrationDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       token: json["access_token"] ?? "",
//       userId: json['user_id'],
//       displayNumber: json['display_number'] ?? "",
//       firstname: json['firstname'],
//       lastname: json['lastname'],
//       email: json['email'],
//       phoneNumber: json['phone_number'] ?? "",
//       address: json['address'],
//       role: json['role'],
//       profilePicture: json['profile_picture'],
//       registrationDate: json['registration_date'],
//       createdAt: json['created_at'] ?? "",
//       updatedAt: json['updated_at'] ?? "",
//     );
//   }
// }
class ProfileModel {
  final int userId;
  final String? displayNumber;
  final String? token;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String role;
  final String? profilePicture;
  final String? registrationDate;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.userId,
    this.displayNumber,
    this.token,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.address,
    required this.role,
    this.profilePicture,
    this.registrationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Handle case where user data is nested under 'user' key
    final userData = json['user'] ?? json;

    return ProfileModel(
      token: json["access_token"] as String?,
      userId: userData['user_id'] as int,
      displayNumber: userData['display_number'] as String?,
      firstname: userData['firstname'] as String?,
      lastname: userData['lastname'] as String?,
      email: userData['email'] as String?,
      phoneNumber: userData['phone_number'] as String?,
      address: userData['address'] as String?,
      role: userData['role'] as String,
      profilePicture: userData['profile_picture'] as String?,
      registrationDate: userData['registration_date'] as String?,
      createdAt: (userData['created_at'] ?? "") as String,
      updatedAt: (userData['updated_at'] ?? "") as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'access_token': token,
      'display_number': displayNumber,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'role': role,
      'profile_picture': profilePicture,
      'registration_date': registrationDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
