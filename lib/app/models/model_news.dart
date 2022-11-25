import 'package:orkut/app/models/model_seller.dart';
import 'dart:convert';
List<ModelNews> blogfromjson(String response){
  return List<ModelNews>.from( jsonDecode(response)['blogs']['data'].map((x) => ModelNews.fromJson(x)));
}
class ModelNews {
  String id;
  String image, name, description, views, hour, readingTime;
  String author,likes;
String comment;
  ModelNews(
      this.id,
    this.image,
    this.name,
    this.hour,
    this.description,
    this.views,
    this.author,
    this.readingTime,
  this.comment,
      this.likes,
  );
  factory ModelNews.fromJson(Map<String,dynamic> data){
    return ModelNews(data['id'].toString(),data['photo'],data['title'],"2",data['description'],data['views'].toString(),"asheer","3",'',data['likes'].toString());
  }
}
