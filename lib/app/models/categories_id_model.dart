import 'dart:convert';
List<Modelcatid> catidfromjson(String response){
  return List<Modelcatid>.from( jsonDecode(response)['categories'].map((x) => Modelcatid.fromJson(x)));
}

class Modelcatid{
  String name;
  int id;


Modelcatid( this.name,this.id);
  factory Modelcatid.fromJson(Map<String,dynamic> data){
    return Modelcatid(data['name'],data['id']);
  }
}