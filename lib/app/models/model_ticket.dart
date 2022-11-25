import 'dart:convert';

List<ModelTicket> ticketfromjson(String response){
  return List<ModelTicket>.from(jsonDecode(response)['tickets']['data'].map((x) =>ModelTicket.fromJson(x)));
}



class ModelTicket {
  String code, date;
String subject;
  ModelTicket(this.code, this.date,this.subject);
  factory ModelTicket.fromJson(Map<String,dynamic> data){

    return ModelTicket(data['ticket_num'],data['created_at'],data['subject']);
  }
}
