class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String city;
  final String address;
  final String image; // Added for user profile image
  final String video; // Added for (e.g.) user profile video or intro

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.city,
    required this.address,
    required this.image,
    required this.video,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',     // Assumes field 'image' in JSON
      video: json['video'] ?? '',     // Assumes field 'video' in JSON
    );
  }
}
