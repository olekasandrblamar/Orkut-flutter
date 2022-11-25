
import 'dart:convert';
import 'dart:ui';

List<ModelSeller> sellerfromjson(String response){

  return List<ModelSeller>.from(jsonDecode(response)['users'].map((x) =>ModelSeller.fromJson(x)));
}

class ModelSeller {
  String name;
  String image;
  ModelSeller( this.name,this.image);
  factory ModelSeller.fromJson(Map<String,dynamic> data){
    return ModelSeller(data['name'].toString(),data['photo'].toString());
  }
}
