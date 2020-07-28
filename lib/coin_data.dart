import 'package:http/http.dart';
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    Map<String,String> cryptoCurrencyValues = {};
    for(String crypt in cryptoList){
      Response response = await get('https://rest.coinapi.io/v1/exchangerate/$crypt/$currency?&apikey=749A910A-303D-4CD9-BB85-016BF91A00BE');
      if(response.statusCode == 200) {
        var jsonDecoderData = jsonDecode(response.body);
        double price = jsonDecoderData['rate'].toDouble();
        cryptoCurrencyValues[crypt] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }


    return cryptoCurrencyValues;
  }
}
