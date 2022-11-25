
import 'dart:convert';

List<ModelHistory> historyfromjson(String response){
  return List<ModelHistory>.from(jsonDecode(response)['transactions']['data'].map((x) =>ModelHistory.fromJson(x)));
}


class ModelHistory {
  String image;
  String name;
  String btc;
  String date;
  String price;

  ModelHistory(this.image, this.name, this.btc, this.date, this.price);
  factory ModelHistory.fromJson(Map<String,dynamic> data){
    return ModelHistory(data['currency']['icon'],data['currency']['code'],data['charge'],data['currency']['created_at'],data['amount']);
  }
}
