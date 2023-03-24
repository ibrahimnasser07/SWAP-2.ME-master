class UserModel {
  String email;
  String firstName;
  String lastName;
  String uId;
  String image;
  String phone;
  String? governorate;
  String? city;
  String? area;
  String? gender;
  late bool isEmailVerified;

  UserModel({
    this.uId = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.isEmailVerified,
    this.gender,
    this.governorate,
    this.city,
    this.area,
  });

  UserModel.fromFireStore(Map<String, dynamic> data)
      : this(
          uId: data['uId'],
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          image: data['image'],
          phone: data['phone'],
          isEmailVerified: data['isEmailVerified'],
          gender: data['gender'] ?? "",
          governorate: data['governorate'] ?? "",
          city: data['city'] ?? "",
          area: data['area'] ?? "",
        );

  Map<String, dynamic> toFireStore() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'uId': uId,
      'image': image,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'gender': gender,
      'governorate': governorate,
      'city': city,
      'area': area,
    };
  }
}
