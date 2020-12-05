import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../shared/common_utils.dart';
import '../shared/hive_store.dart';
import 'coin.dart';

class MainRepository {
  final HiveStore _hiveStore;
  static initHiveStore(hiveBox) => HiveStore(hiveBox: hiveBox);
  MainRepository({Box hiveBox}) : _hiveStore = initHiveStore(hiveBox);

  HiveStore get hiveStore => _hiveStore;

  Future<List<Coin>> apiGetCoins({String start, String limit}) async {
    List<Coin> coins = List();

    // https://www.coinlore.com/cryptocurrency-data-api
    // Tickers (All coins)
    // Request Method: GET
    // Desc: Information about all coins, maximum result 100 coins per request, you should use start and limit
    // Test URL: https://api.coinlore.net/api/tickers/ (First 100 Coins)
    // Test URL: https://api.coinlore.net/api/tickers/?start=100&limit=100
    // Test URL: https://api.coinlore.net/api/tickers/?start=200&limit=100

    String reqUrl = "https://api.coinlore.net/api/tickers/";
    if (CommonUtils.nullSafe(start).isNotEmpty) {
      reqUrl += "?" + "start=" + start.trim();
    }
    if (CommonUtils.nullSafe(limit).isNotEmpty) {
      reqUrl += reqUrl.contains("?") ? "&" : "?" + "limit=" + limit.trim();
    }
    try {
      final response = await http.get(reqUrl);
      if (response.statusCode <= 201) {
        Map<String, dynamic> responseMap = json.decode(response.body);
        if (responseMap.containsKey("data")) {
          List<dynamic> dataItems = responseMap["data"] as List;
          dataItems.forEach((dataItem) {
            coins.add(Coin.fromJson(dataItem));
          });
        }
      }
    } catch (ex) {
      print(ex);
    }

    return coins;
  }

  Future<Coin> apiGetCoin({String id}) async {
    Coin coin;

    // https://www.coinlore.com/cryptocurrency-data-api
    // Ticker (Specific Coin)
    // Request Method: GET
    // Desc: Get information for specific coin, you should pass coin id (You should use id from tickers endpoint)
    // Test URL: https://api.coinlore.net/api/ticker/?id=90 (BTC)
    // Test URL: https://api.coinlore.net/api/ticker/?id=80 (ETH)

    return coin;
  }
}
