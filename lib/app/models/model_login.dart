// import 'package:orkut/app/models/coin_list.dart';
// import 'package:orkut/app/models/model_seller.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// List<Login> loginfromjson(String response){
//   var data=jsonDecode(response)['token'];
//   //print(data);
//   print(data.map((x)=>Login.fromJson(x)));
//   return List<Login>.from(data.map((x)=>Login.fromJson(x))
//   );
// }
// class Login {
//  // String status;
//  String token;
// //   int id;
// //   String email;
// //   String name;
// // String photo;
// // String phone;
// // String country;
// // String city;
// // String address;
// // String zip;
// // String balance;
// // int status;
// // int email_verified;
// // int phone_verified;
// // String verification_link;
// // String verify_code;
// // int kyc_status;
// // String kyc_info;
// // String kyc_reject_reason;
// // int two_fa_status;
// // int two_fa;
// // String two_fa_code;
// // String device_token;
// // String best_seller;
// // String created_at;
// // String updated_at;
//   Login(
//     //  this.status,
//   this.token,
//   // this.id,
//   // this.email,
//   // this.name,
//   // this.photo,
//   // this.phone,
//   // this.country,
//   // this.city,
//   // this.address,
//   // this.zip,
//   // this.balance,
//   // this.status,
//   // this.email_verified,
//   // this.phone_verified,
//   // this.verification_link,
//   // this. verify_code,
//   // this.kyc_status,
//   // this. kyc_info,
//   // this. kyc_reject_reason,
//   // this.two_fa_status,
//   // this.two_fa,
//   // this.two_fa_code,
//   // this.device_token,
//   // this.best_seller,
//   // this.created_at,
//   // this.updated_at,
//  );
//   factory Login.fromJson(Map<String,dynamic> data){
//    return Login(data['token']);
//    // return Login(data['id'],data['email'],data['name'],data['photo'],data['phone'],data['country'],data['city'],data['address'],data['zip'],data['balance'],data['status'],data['email_verified'],data['phone_verified'],data['verification_link'],data['verify_code'],data['kyc_status'],data['kyc_info'],data['kyc_reject_reason'],data['two_fa_status'],data['two_fa'],data['two_fa_code'],data['device_token'],data['best_seller'],data['created_at'],data['updated_at']);
//   }
//
// }