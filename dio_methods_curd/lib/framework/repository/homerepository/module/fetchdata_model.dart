// To parse this JSON data, do
//
//     final fetchData = fetchDataFromJson(jsonString);

import 'dart:convert';

FetchData fetchDataFromJson(String str) => FetchData.fromJson(json.decode(str));

FetchData fetchDataFromJsonSingle(String str) => FetchData.fromJsonSingle(json.decode(str));


String fetchDataToJson(FetchData data) => json.encode(data.toJson());

class FetchData {
  bool? success;
  String? message;
  List<Datum>? data;
  Datum? singleData;
  Pagination? pagination;
  String? timestamp;

  FetchData({
    this.success,
    this.message,
    this.data,
    this.pagination,
    this.timestamp,
    this.singleData,
  });

  factory FetchData.fromJson(Map<String, dynamic> json) => FetchData(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "timestamp": timestamp,
  };

  // for single Object
  factory FetchData.fromJsonSingle(Map<String, dynamic> json) => FetchData(
    success: json["success"],
    message: json["message"],
    singleData: json["data"] == null ? null : Datum.fromJson(json["data"]),
    timestamp: json["timestamp"],
  );
}

class Datum {
  int? id;
  String? name;
  String? description;
  dynamic logoUrl;
  String? website;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.website,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    logoUrl: json["logo_url"],
    website: json["website"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "logo_url": logoUrl,
    "website": website,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;
  bool? hasNext;
  bool? hasPrev;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPages: json["totalPages"],
    hasNext: json["hasNext"],
    hasPrev: json["hasPrev"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
    "hasNext": hasNext,
    "hasPrev": hasPrev,
  };
}
