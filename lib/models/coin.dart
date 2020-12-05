/// id : "90"
/// symbol : "BTC"
/// name : "Bitcoin"
/// nameid : "bitcoin"
/// rank : 1
/// price_usd : "6456.52"
/// percent_change_24h : "-1.47"
/// percent_change_1h : "0.05"
/// percent_change_7d : "-1.07"
/// price_btc : "1.00"
/// market_cap_usd : "111586042785.56"
/// volume24 : 3997655362.9586277
/// volume24a : 3657294860.710187
/// csupply : "17282687.00"
/// tsupply : "17282687"
/// msupply : "21000000"

class Coin {
  String _id;
  String _symbol;
  String _name;
  String _nameid;
  int _rank;
  String _priceUsd;
  String _percentChange24h;
  String _percentChange1h;
  String _percentChange7d;
  String _priceBtc;
  String _marketCapUsd;
  double _volume24;
  double _volume24a;
  String _csupply;
  String _tsupply;
  String _msupply;

  String get id => _id;
  String get symbol => _symbol;
  String get name => _name;
  String get nameid => _nameid;
  int get rank => _rank;
  String get priceUsd => _priceUsd;
  String get percentChange24h => _percentChange24h;
  String get percentChange1h => _percentChange1h;
  String get percentChange7d => _percentChange7d;
  String get priceBtc => _priceBtc;
  String get marketCapUsd => _marketCapUsd;
  double get volume24 => _volume24;
  double get volume24a => _volume24a;
  String get csupply => _csupply;
  String get tsupply => _tsupply;
  String get msupply => _msupply;

  Coin(
      {String id,
      String symbol,
      String name,
      String nameid,
      int rank,
      String priceUsd,
      String percentChange24h,
      String percentChange1h,
      String percentChange7d,
      String priceBtc,
      String marketCapUsd,
      double volume24,
      double volume24a,
      String csupply,
      String tsupply,
      String msupply}) {
    _id = id;
    _symbol = symbol;
    _name = name;
    _nameid = nameid;
    _rank = rank;
    _priceUsd = priceUsd;
    _percentChange24h = percentChange24h;
    _percentChange1h = percentChange1h;
    _percentChange7d = percentChange7d;
    _priceBtc = priceBtc;
    _marketCapUsd = marketCapUsd;
    _volume24 = volume24;
    _volume24a = volume24a;
    _csupply = csupply;
    _tsupply = tsupply;
    _msupply = msupply;
  }

  Coin.fromJson(dynamic json) {
    _id = json["id"];
    _symbol = json["symbol"];
    _name = json["name"];
    _nameid = json["nameid"];
    _rank = json["rank"];
    _priceUsd = json["price_usd"];
    _percentChange24h = json["percent_change_24h"];
    _percentChange1h = json["percent_change_1h"];
    _percentChange7d = json["percent_change_7d"];
    _priceBtc = json["price_btc"];
    _marketCapUsd = json["market_cap_usd"];
    _volume24 = json["volume24"];
    _volume24a = json["volume24a"];
    _csupply = json["csupply"];
    _tsupply = json["tsupply"];
    _msupply = json["msupply"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["symbol"] = _symbol;
    map["name"] = _name;
    map["nameid"] = _nameid;
    map["rank"] = _rank;
    map["price_usd"] = _priceUsd;
    map["percent_change_24h"] = _percentChange24h;
    map["percent_change_1h"] = _percentChange1h;
    map["percent_change_7d"] = _percentChange7d;
    map["price_btc"] = _priceBtc;
    map["market_cap_usd"] = _marketCapUsd;
    map["volume24"] = _volume24;
    map["volume24a"] = _volume24a;
    map["csupply"] = _csupply;
    map["tsupply"] = _tsupply;
    map["msupply"] = _msupply;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
