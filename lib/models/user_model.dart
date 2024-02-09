// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  dynamic createdAt;
  String? name;
  String? phoneNumber;
  String? email;
  String? id;

  Users({
    this.createdAt,
    this.name,
    this.phoneNumber,
    this.email,
    this.id,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        createdAt: json["createdAt"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "id": id,
      };
}
