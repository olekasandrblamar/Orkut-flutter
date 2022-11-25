import 'package:orkut/app/models/model_seller.dart';
import 'dart:convert';
List<Modeldetails> blogdetailsfromjson(String response){
  print(jsonDecode(response)['blog']);
  return List<Modeldetails>.from( jsonDecode(response)['blog'].map((x) => Modeldetails.fromJson(x)));
}
class Modeldetails {
  String views;
  String likes;
  List<String> comments;
  Modeldetails(
      this.views,
      this.likes,
      this.comments,
      );
  factory Modeldetails.fromJson(Map<String,dynamic> data){
    print(data);
    return Modeldetails(data['views'].toString(),data['likes'].toString(),data['comments']['comment']);
  }
}
