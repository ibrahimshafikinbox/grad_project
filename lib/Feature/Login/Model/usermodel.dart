class UserModel {
  final int userId;
  final String? displayNumber;
  final String firstname;
  final String lastname;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String role;
  final String? profilePicture;
  final String? registrationDate;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.userId,
    this.displayNumber,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.phoneNumber,
    this.address,
    required this.role,
    this.profilePicture,
    this.registrationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      displayNumber: json['display_number'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      role: json['role'],
      profilePicture: json['profile_picture'],
      registrationDate: json['registration_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
