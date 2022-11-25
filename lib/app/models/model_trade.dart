import 'dart:convert';
List<ModelTrade> tradefromjson(String response){
  return List<ModelTrade>.from(jsonDecode(response)['trades']['data'].map((x) =>ModelTrade.fromJson(x)));
}

class ModelTrade {
String id;
  String code;
  String type;
  String amount;
  int status;

  ModelTrade(this.code, this.type, this.amount, this.status,this.id);

  factory ModelTrade.fromJson(Map<String,dynamic> data){

    return ModelTrade(data['trade_code'],data['trade_type'],data['crypto_amount'],data['status'],data['id'].toString());
  }

}
