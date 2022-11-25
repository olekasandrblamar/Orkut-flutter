import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiService {
  // url
  static const String ENDPOINT =
  "https://rest.coinapi.io/v1/exchangerate/";
      // "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/";

// get amount function used for call api and return value
  static Future<Response?> getConvertedAmount(url) async {
    try {
//cal api
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'X-CoinAPI-Key': '645FDC31-6610-43B4-9922-F1108BB2807F'
      };
      final response = await get(Uri.parse(url),headers:requestHeaders );
// get response
      print('response');
      print(response);
      return response;
    } catch (e) {
// catch er
      if (kDebugMode) {
        print("fetch get err $e");
      }
    }
    return null;
  }
}