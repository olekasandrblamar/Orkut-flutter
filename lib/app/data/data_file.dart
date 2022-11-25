import 'package:flutter/material.dart';
import 'package:orkut/app/models/coin_list.dart';
import 'package:orkut/app/models/intro_model.dart';
import 'package:orkut/app/models/model_chartdata.dart';
import 'package:orkut/app/models/model_country.dart';
import 'package:orkut/app/models/model_currency.dart';
import 'package:orkut/app/models/model_deposits.dart';
import 'package:orkut/app/models/model_history.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/app/models/model_offer.dart';
import 'package:orkut/app/models/model_payment.dart';
import 'package:orkut/app/models/model_portfolio.dart';
import 'package:orkut/app/models/model_seller.dart';
import 'package:orkut/app/models/model_slider.dart';
import 'package:orkut/app/models/model_ticket.dart';
import 'package:orkut/app/models/model_trade.dart';

import '../../base/color_data.dart';
import '../models/model_item.dart';
import '../models/model_price_alert.dart';
import '../models/model_trend.dart';

class DataFile {
  static List<ModelIntro> introList = [
    ModelIntro(
        1,
        intro1,
        "intro1.png",
        "Secure Crypto Wallet",
        "Deposit your tokens in the most secure wallet with different security layers",
        "Next"),
    ModelIntro(
        2,
        intro2,
        "intro2.png",
        "Trade Cryptocurrencies.",
        "Easily convert your tokens to fiat money by trading it in the mall. Get paid in your location",
        "Next"),
    ModelIntro(
        3,
        intro3,
        "intro3-new.png",
        "Withdraw Anytime",
        "Safely withdraw your crypto to any wallet, fast and securely and at the best rate possible.",
        "Get Started"),
  ];

  static List<ModelSlider> sliderList = [
    ModelSlider(
      "countries.png",
      "Move Money Globally",
      "Send money to any country",
      "Send now",
    ),
    ModelSlider(
      "cryptocurrency.png",
      "Safe and Secure Crypto",
      "Store your crypto in the safest vault",
      "Deposit Now",
    ),
    ModelSlider(
      "slider_image.png",
      "Trade and Make Money",
      "Start your earning journey trading",
      "Trade Now",
    ),
  ];

  static List<ModelCountry> countryList = [
    ModelCountry("image_fghanistan.jpg", "Afghanistan (AF)", "+93"),
    ModelCountry("image_ax.jpg", "Aland Islands (AX)", "+358"),
    ModelCountry("image_albania.jpg", "Albania (AL)", "+355"),
    ModelCountry("image_andora.jpg", "Andorra (AD)", "+376"),
    ModelCountry("image_islands.jpg", "Aland Islands (AX)", "+244"),
    ModelCountry("image_angulia.jpg", "Anguilla (AL)", "+1"),
    ModelCountry("image_armenia.jpg", "Armenia (AN)", "+374"),
    ModelCountry("image_austia.jpg", "Austria (AT)", "+372"),
  ];

  static List<ModelItem> itemList = [
    ModelItem("home.svg", "Home"),
    ModelItem("offer.svg", "Offers"),
    ModelItem("clock.svg", "Timeline"),
    ModelItem("profile.svg", "Profile")
  ];

  static List<ModelPortfolio> portfolioList = [
  ModelPortfolio(1,"United States Dollar","USD","74.52","-0.24"),
    ModelPortfolio(2,"Bitcoin","BTC","54.52","-0.34"),
  ];

  // static List<ModelSeller> sellerList = [
  //   ModelSeller("btc.svg", "Bitcoin"),
  //   ModelSeller("eth.svg", "Ethereum"),
  //   ModelSeller("eur.svg", "European Unicon"),
  //   ModelSeller("ltc.svg", "Litecoin"),
  //   ModelSeller("bnb.svg", "Binance Coin"),
  //   ModelSeller("usd.svg", "United States Dollar")
  // ];

  static List<ModelTrend> trendList = [
    ModelTrend("eur.svg", "European Union", "EUR", 56.55, "2.4%"),
    ModelTrend("usd.svg", "United States Dollar", "USD", 21.42, "-1.3%"),
    ModelTrend("bnb.svg", "Binance Coin", "BNB", 26.76, "4.3%"),
    ModelTrend("ltc.svg", "Litecoin", "LTC", 45.23, "-2.4%"),
    ModelTrend("eth.svg", "Ethereum", "ETH", 78.35, "5.6%"),
    ModelTrend("btc.svg", "Bitcoin", "BTC", 75.24, "-6.5%"),
    ModelTrend("usd.svg", "United States Dollar", "USD", 45.23, "8.3%"),
  ];

  static List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53, 3.3),
    ChartData(2011, 9.5, 5.4),
    ChartData(2012, 10, 2.65),
    ChartData(2013, 9.4, 2.62),
    ChartData(2014, 5.8, 1.99),
    ChartData(2015, 4.9, 1.44),
    ChartData(2016, 4.5, 2),
    ChartData(2017, 3.6, 1.56),
    ChartData(2018, 3.43, 2.1),
  ];

  static List<ModelNews> newsList = [
    ModelNews(
      "1",
      "new1.png",
      "What happen to Bitcoin and Ethereum?",
      "4 Hours Ago",
      "Bitcoin and Ethereum is gaining strength day by day as market rate increases. Bitcoin and Ethereum is gaining strength day by day as market rate increases.",
      "2.5K",
     "",
      "6 min read",
      '',
      ''
    ),
    ModelNews(
      "2",
      "new2.png",
      "What happen to Bitcoin and Ethereum?",
      "3 Hours Ago",
      "Bitcoin and Ethereum is gaining strength day by day as market rate increases. Bitcoin and Ethereum is gaining strength day by day as market rate increases.",
      "1.5K",
    "",
      "4 min read",
      '',
      ''
    ),
  ];

  // static List<ModelDeposits> myDeposits = sellerList
  //     .map((int element) => ModelDeposits(element, 0))
  //     .toList();

  static List<ModelTrade> tradesList = [
    ModelTrade("A42d5", "abcd", "\$200", 1,''),
    ModelTrade("A42d5", "abcd", "\$200", 1,''),
    ModelTrade("A42d5", "abcd", "\$200", 1,''),
    ModelTrade("A42d5", "abcd", "\$200", 1,''),
  ];

  static List<ModelTicket> ticketList = [
    ModelTicket('',"TK346U20D", "07-10-22"),
    ModelTicket('',"TK248U30D", "08-09-22"),
    ModelTicket('',"TK149U20D", "11-08-22"),
    ModelTicket('',"TK37U20D", "11-10-21"),
    ModelTicket('',"TK4694U20D", "11-01-20"),
    ModelTicket('',"TK4694U20D", "01-02-19"),
    ModelTicket('',"TK4694U20D", "03-01-19"),
  ];

  static List<Offers> offerList = [
    Offers(
      "1",
      "",
      "25",
      '44470.60',
      "2",
      "Paypal",
"1",
      "2",
'',
      '',
      '',
      '',
      '',
      '',
        '',
        '',
        '',
      ''
    ),
    Offers(
      "2",
      "",
      "25",
      '44470.60',
     " 4",
      "Paytm",
      "1",
      "2",
'',
      '',
      '',
      '',
          '',
      '',
      '',
        '',
        '',
        ''
    ),
    Offers(
      "3",
      "",
      "25",
     ' 44470.60',
      "3",
      "Paypal",
    "1",
      "2",
'',
      '',
      '',
      '',
      '',
      '',
          '',
        '',
        '',
      ''
    ),
  ];

  static List<String> categoryList = [
    "All",
    "Watchlist",
    "Top Gainers",
    "Trending"
  ];

  static List<String> timelineCategoryList = [

    "Trending",
    "Advertisment",
    "Following",
  ];

  static List<String> homeActions = ["Buy", "Sell", "Deposit", "Withdraw"];

  static List<ModelPayment> paymentList = [
    ModelPayment("paypal.svg", "Paypal", "xxxx xxxx xxxx 5416"),
    ModelPayment("mastercard.svg", "Master Card", "xxxx xxxx xxxx 8624"),
    ModelPayment("visa.svg", "Visa", "xxxx xxxx xxxx 4565"),
  ];

  static List<ModelHistory> historyList = [
    ModelHistory(
        "history1.png", "Received BTC", "0.22 BTC", "16 July, 2022", "\$56.00"),
    ModelHistory("history2.png", "Purchased BTC", "0.00254 BTC",
        "12 July, 2022", "\$56.00"),
    ModelHistory("history2.png", "Purchased BTC", "0.145 BTC", "10 July, 2022",
        "\$76.33"),
    ModelHistory("history2.png", "Purchased BTC", "0.00254 BTC",
        "12 July, 2022", "\$42.32"),
    ModelHistory("history2.png", "Purchased BTC", "0.145 BTC", "10 July, 2022",
        "\$76.00"),
    ModelHistory(
        "history3.png", "INR Deposit+", "0.22 BTC", "Failed", "Need Help?"),
    ModelHistory(
        "history1.png", "Received BTC", "0.14 BTC", "08 July, 2022", "\$56.32"),
  ];

  static List<ModelCurrency> currencyList = [
    ModelCurrency("btc.svg", "Bitcoin"),
    ModelCurrency("eth.svg", "Ethereum"),
    ModelCurrency("ltc.svg", "Litecoin"),
    ModelCurrency("bnb.svg", "Binance Coin"),

  ];

  static List<ModelPriceAlert> priceAlertList = [
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$575.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$386.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$785.02"),
    ModelPriceAlert("eth.svg", "Ethereum", "Price rises to", "\$547.02")
  ];
}
