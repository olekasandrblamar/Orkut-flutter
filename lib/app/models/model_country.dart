import 'dart:convert';
List<ModelCountry> countryfromjson(String response){
  return List<ModelCountry>.from( jsonDecode(response)['countries'].map((x) => ModelCountry.fromJson(x)));
}

class ModelCountry{
  String image;
  String name;
  String code;

  ModelCountry(this.image, this.name, this.code);
  factory ModelCountry.fromJson(Map<String,dynamic> data){
    return ModelCountry(data['flag'],data['name'],data['dial_code']);
  }
}