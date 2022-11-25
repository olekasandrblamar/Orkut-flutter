import 'dart:convert';
List<ModelChat> portfoliofromjson(String response){
  return List<ModelChat>.from(jsonDecode(response)['portfolio'].map((x) =>ModelChat.fromJson(x)));
}

class ModelChat {
 String message;
  ModelChat(this.message);
  factory ModelChat.fromJson(Map<String,dynamic> data){
    return ModelChat(data['message']);
  }
}
