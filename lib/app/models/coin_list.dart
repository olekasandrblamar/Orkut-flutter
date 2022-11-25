class CoinList {
  List<Coins>? coins;

  CoinList({this.coins});

  CoinList.fromJson(Map<String, dynamic> json) {
    if (json['coins'] != null) {
      coins = <Coins>[];
      json['coins'].forEach((v) {
        coins!.add(Coins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coins != null) {
      data['coins'] = coins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coins {
  String? id;
  String? icon;
  String? name;
  String? symbol;
  late final rank;
  late final price;
  late final priceBtc;
  late final volume;
  late final marketCap;
  late final availableSupply;
  late final totalSupply;
  late final priceChange1h;
  late final priceChange1d;
  late final priceChange1w;
  String? websiteUrl;
  String? twitterUrl;
  List<String>? exp;
  String? contractAddress;
  int? decimals;
  String? redditUrl;

  Coins(
      {this.id,
      this.icon,
      this.name,
      this.symbol,
      this.rank,
      this.price,
      this.priceBtc,
      this.volume,
      this.marketCap,
      this.availableSupply,
      this.totalSupply,
      this.priceChange1h,
      this.priceChange1d,
      this.priceChange1w,
      this.websiteUrl,
      this.twitterUrl,
      this.exp,
      this.contractAddress,
      this.decimals,
      this.redditUrl});

  Coins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    symbol = json['symbol'];
    rank = json['rank'];
    price = json['price'];
    priceBtc = json['priceBtc'];
    volume = json['volume'];
    marketCap = json['marketCap'];
    availableSupply = json['availableSupply'];
    totalSupply = json['totalSupply'];
    priceChange1h = json['priceChange1h'];
    priceChange1d = json['priceChange1d'];
    priceChange1w = json['priceChange1w'];
    websiteUrl = json['websiteUrl'];
    twitterUrl = json['twitterUrl'];
    exp = json['exp'].cast<String>();
    contractAddress = json['contractAddress'];
    decimals = json['decimals'];
    redditUrl = json['redditUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['name'] = name;
    data['symbol'] = symbol;
    data['rank'] = rank;
    data['price'] = price;
    data['priceBtc'] = priceBtc;
    data['volume'] = volume;
    data['marketCap'] = marketCap;
    data['availableSupply'] = availableSupply;
    data['totalSupply'] = totalSupply;
    data['priceChange1h'] = priceChange1h;
    data['priceChange1d'] = priceChange1d;
    data['priceChange1w'] = priceChange1w;
    data['websiteUrl'] = websiteUrl;
    data['twitterUrl'] = twitterUrl;
    data['exp'] = exp;
    data['contractAddress'] = contractAddress;
    data['decimals'] = decimals;
    data['redditUrl'] = redditUrl;
    return data;
  }
}
