
import 'dart:convert';

List<ModelPortfolio> portfoliofromjson(String response){
    return List<ModelPortfolio>.from(jsonDecode(response)['portfolio'].map((x) =>ModelPortfolio.fromJson(x)));
}

class ModelPortfolio {
  int id;
  String code;
  String currency;
  String price;
  String balance;
  ModelPortfolio(this.id,  this.code,this.currency, this.price, this.balance);
  factory ModelPortfolio.fromJson(Map<String,dynamic> data){

    return ModelPortfolio(data['crypto_id'],data['curr_code'],data['curr_name'],data['rate'],data['balance']);
  }
}
