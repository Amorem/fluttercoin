import 'package:bitcoin_ticker/services/networking.dart';

const endpoint = "https://apiv2.bitcoinaverage.com/indices/global/ticker";

class BitCoin {
  Future<dynamic> getQuote(String currency) async {
    var url = "$endpoint/BTC$currency";
    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.getData();
  }
}
