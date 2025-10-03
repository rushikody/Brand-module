// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  LoginUser({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
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
  String? message;
  User? user;
  Tokens? tokens;

  Data({
    this.message,
    this.user,
    this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "tokens": tokens?.toJson(),
  };
}

class Tokens {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiresIn;

  Tokens({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  dynamic phone;
  dynamic dateOfBirth;
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
