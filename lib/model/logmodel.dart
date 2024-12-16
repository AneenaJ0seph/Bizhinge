// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? companyName;
  String? contactPerson;
  String? phone;
  dynamic uploadedFile;
  dynamic referralCode;
  String? cashbackAmount;

  UserModel({
    this.id,
    this.companyName,
    this.contactPerson,
    this.phone,
    this.uploadedFile,
    this.referralCode,
    this.cashbackAmount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    companyName: json["company_name"],
    contactPerson: json["contact_person"],
    phone: json["phone"],
    uploadedFile: json["uploaded_file"],
    referralCode: json["referral_code"],
    cashbackAmount: json["cashback_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "contact_person": contactPerson,
    "phone": phone,
    "uploaded_file": uploadedFile,
    "referral_code": referralCode,
    "cashback_amount": cashbackAmount,
  };
}