import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.screensizer.screen_sizer";

  static String introAvailable = "${prefName}isIntroAvailable";
  static String isLoggedIn = "${prefName}isLoggedIn";
  static String getTheme = "${prefName}isSelectedTheme";
  static String isCode = "${prefName}isCode";
  static String isImage = "${prefName}isImage";
  static String isTrendName = "${prefName}isTrendName";
  static String isTrendImage = "${prefName}isTrendImage";
  static String isTrendCurrency = "${prefName}isTrendCurrency";
  static String isTrendPrice = "${prefName}isTrendPrice";
  static String isTrendProfit = "${prefName}isTrendProfit";
  static String isFirstName = "${prefName}isFirstName";
  static String isLastName = "${prefName}isLastName";
  static String isEmail = "${prefName}isEmail";
  static String isPhoneNo = "${prefName}isPhoneNo";
  static String Token="${prefName}isToken";
  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static setLogIn(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(isLoggedIn, avail);
  }
  static setToken(String token) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(Token,token);
  }
  static Future<String> getToken() async {
    SharedPreferences preferences = await getPrefInstance();
    String isToken = preferences.getString(Token) ?? "";
    return isToken;
  }
  static Future<bool> isLogIn() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isIntroAvailable = preferences.getBool(isLoggedIn) ?? false;
    return isIntroAvailable;
  }

  static setCode(String code) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isCode, code);
  }

  static Future<String> getCode() async {
    SharedPreferences preferences = await getPrefInstance();
    String isCodeAvailable = preferences.getString(isCode) ?? "";
    return isCodeAvailable;
  }

  static setImage(String image) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isImage, image);
  }

  static Future<String> getImage() async {
    SharedPreferences preferences = await getPrefInstance();
    String isImageAvailable = preferences.getString(isImage) ?? "";
    return isImageAvailable;
  }

  static setTrendName(String name) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isTrendName, name);
  }

  static Future<String> getTrendName() async {
    SharedPreferences preferences = await getPrefInstance();
    String isTrendNameAvailable = preferences.getString(isTrendName) ?? "";
    return isTrendNameAvailable;
  }

  static setTrendImage(String image) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isTrendImage, image);
  }

  static Future<String> getTrendImage() async {
    SharedPreferences preferences = await getPrefInstance();
    String isTrendImageAvailable = preferences.getString(isTrendImage) ?? "";
    return isTrendImageAvailable;
  }

  static setTrendCurrency(String currency) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isTrendCurrency, currency);
  }

  static Future<String> getTrendCurrency() async {
    SharedPreferences preferences = await getPrefInstance();
    String isTrendCurrencyAvailable =
        preferences.getString(isTrendCurrency) ?? "";
    return isTrendCurrencyAvailable;
  }

  static setTrendPrice(double price) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setDouble(isTrendPrice, price);
  }

  static Future<double> getTrendPrice() async {
    SharedPreferences preferences = await getPrefInstance();
    double isTrendPriceAvailable = preferences.getDouble(isTrendPrice) ?? 0.00;
    return isTrendPriceAvailable;
  }

  static setTrendProfit(String profit) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isTrendProfit, profit);
  }

  static Future<String> getTrendProfit() async {
    SharedPreferences preferences = await getPrefInstance();
    String isTrendProfitAvailable = preferences.getString(isTrendProfit) ?? "";
    return isTrendProfitAvailable;
  }

  static setFirstName(String firstName) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isFirstName, firstName);
  }

  static Future<String> getFirstName() async {
    SharedPreferences preferences = await getPrefInstance();
    String isFirstNameAvailable =
        preferences.getString(isFirstName) ?? "example";
    return isFirstNameAvailable;
  }

  static setLastName(String lastName) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isLastName, lastName);
  }

  static Future<String> getLastName() async {
    SharedPreferences preferences = await getPrefInstance();
    String isLastNameAvailable = preferences.getString(isLastName) ?? "demo";
    return isLastNameAvailable;
  }

  static setEmail(String email) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isEmail, email);
  }

  static Future<String> getEmail() async {
    SharedPreferences preferences = await getPrefInstance();
    String isEmailAvailable =
        preferences.getString(isEmail) ?? "example@gmail.com";
    return isEmailAvailable;
  }

  static setPhoneNo(String phoneNo) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(isPhoneNo, phoneNo);
  }

  static Future<String> getPhoneNo() async {
    SharedPreferences preferences = await getPrefInstance();
    String isPhoneAvailable = preferences.getString(isPhoneNo) ?? "9000454510";
    return isPhoneAvailable;
  }
}
