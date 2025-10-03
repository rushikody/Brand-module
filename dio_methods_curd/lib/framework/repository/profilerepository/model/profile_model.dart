import 'dart:convert';

Userprofile userprofileFromJson(String str) => Userprofile.fromJson(json.decode(str));

String userprofileToJson(Userprofile data) => json.encode(data.toJson());

class Userprofile {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  Userprofile({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  factory Userprofile.fromJson(Map<String, dynamic> json) => Userprofile(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "timestamp": timestamp,
  };
}

class Data {
  User? user;
  List<dynamic>? addresses;

  Data({
    this.user,
    this.addresses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    addresses: json["addresses"] == null ? [] : List<dynamic>.from(json["addresses"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x)),
  };
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? dateOfBirth;
  dynamic profileImage;
  int? isActive;
  int? isVerified;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.dateOfBirth,
    this.profileImage,
    this.isActive,
    this.isVerified,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    dateOfBirth: json["date_of_birth"],
    profileImage: json["profile_image"],
    isActive: json["is_active"],
    isVerified: json["is_verified"],
    lastLogin: json["last_login"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "date_of_birth": dateOfBirth,
    "profile_image": profileImage,
    "is_active": isActive,
    "is_verified": isVerified,
    "last_login": lastLogin,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
