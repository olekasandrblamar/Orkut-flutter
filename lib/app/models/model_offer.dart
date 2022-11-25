import 'package:orkut/app/models/coin_list.dart';
import 'package:orkut/app/models/model_seller.dart';
import 'dart:convert';
List<Offers> offersfromjson(String response){
   return List<Offers>.from( jsonDecode(response)['offers']['data'].map((x) => Offers.fromJson(x)));
}
class Offers {
  String user_id;
  String currency;
  String duration;
  String price;
  String priceType;
  String payWith;
  String cryp_id;
  String fiat_id;
  String offer_id;
  String type;
  String fixed_rate;
  String minimum;
  String maximum;
  String photo;
  String terms;
  String instructions;
  String name;
  String code;
  Offers(
      this.user_id,
      this.currency,
      this.duration,
      this.price,
      this.priceType,
      this.payWith,
      this.cryp_id,
      this.fiat_id,
      this.offer_id,
      this.type,
      this.fixed_rate,
      this.minimum,
      this.maximum,
      this.photo,
      this.terms,
      this.instructions,
      this.name,
      this.code,
      );
  factory Offers.fromJson(Map<String,dynamic> data){
    return Offers(data['id'].toString(),data['crypto']['curr_name'].toString(),data['trade_duration'].toString(),data['crypto']['rate'].toString(),data['price_type'].toString(),data['gateway']['name'].toString(),data['cryp_id'].toString(),data['fiat_id'].toString(),data['id'].toString(),data['type'].toString(),data['fixed_rate'].toString(),data['minimum'].toString(),data['maximum'].toString(),data['crypto']['icon'].toString(),data['offer_terms'].toString(),data['trade_instructions'].toString(),'',data['crypto']['code'].toString());
  }
}