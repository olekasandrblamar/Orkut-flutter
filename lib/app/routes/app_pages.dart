import 'package:orkut/app/view/bankDetail/bank_detail.dart';
import 'package:orkut/app/view/history/history_screen.dart';
import 'package:orkut/app/view/home/detail_screen.dart';
import 'package:orkut/app/view/home/exchange_screen.dart';
import 'package:orkut/app/view/home/home_screen.dart';
import 'package:orkut/app/view/home/portfolio_screen.dart';
import 'package:orkut/app/view/home/market_trend_screen.dart';
import 'package:orkut/app/view/home/tab/tab_market.dart';
import 'package:orkut/app/view/intro/intro_screen.dart';
import 'package:orkut/app/view/login/change_password.dart';
import 'package:orkut/app/view/login/forgot_password.dart';
import 'package:orkut/app/view/login/login_screen.dart';
import 'package:orkut/app/view/offer/offer_list.dart';
import 'package:orkut/app/view/price_alert/alert_create_screen.dart';
import 'package:orkut/app/view/price_alert/create_price_alert.dart';
import 'package:orkut/app/view/price_alert/price_alert_screen.dart';
import 'package:orkut/app/view/profile/edit_profile.dart';
import 'package:orkut/app/view/profile/my_profile.dart';
import 'package:orkut/app/view/profile/verification.dart';
import 'package:orkut/app/view/review_screen.dart';
import 'package:orkut/app/view/setting/help_screen.dart';
import 'package:orkut/app/view/setting/privacy_screen.dart';
import 'package:orkut/app/view/setting/setting_screen.dart';
import 'package:orkut/app/view/setting/support_screen.dart';
import 'package:orkut/app/view/setting/tickets_screen.dart';
import 'package:orkut/app/view/signup/select_country.dart';
import 'package:orkut/app/view/signup/signup_screen.dart';
import 'package:orkut/app/view/signup/verify_screen.dart';
import 'package:orkut/app/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:orkut/app/view/trade_request/p2p_trading.dart';

import '../view/create_timeline_screen.dart';
import '../view/offer/create_offer.dart';
import '../view/offer/search_offer_list.dart';
import '../view/profile/about_profile.dart';
import '../view/trade_request/create_trade_request.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.forgotRoute: (context) => const ForgotPassword(),
    Routes.changePasswordRoute: (context) => const ChangePassword(),
    Routes.signUpRoutes: (context) => const SignUpScreen(),
    Routes.selectCountryRoute: (context) => const SelectCountry(),
    Routes.verifyRoute: (context) =>  VerifyScreen(email:''),
    Routes.homeScreenRoute: (context) => const HomeScreen(),
    Routes.portfolioRoute: (context) => const PortfolioScreen(),
    Routes.marketTrendRoute: (context) => const MarketTrendScreen(),
    Routes.detailRoute: (context) => const DetailScreen(),
    Routes.exchangeRoute: (context) =>   ExchangeScreen(ModalRoute.of(context)?.settings.arguments),
    Routes.myProfileRoute: (context) => const MyProfile(),
    Routes.editProfileRoute: (context) => const EditProfile(),
    Routes.bankDetailRoute: (context) => const BankDetail(),
    Routes.historyRoute: (context) => const HistoryScreen(),
    Routes.settingRoute: (context) => const SettingScreen(),
    Routes.priceAlertRoute: (context) => const PriceAlertScreen(),
    Routes.createPriceAlertRoute: (context) => const CreatePriceAlert(),
    Routes.createOfferRoute: (context) => const CreateOfferScreen(),
    Routes.offerListRoute: (context) => const OfferListScreen(),
    Routes.searchOfferListRoute: (context) => const SearchOfferListScreen(),
    Routes.createTradeRequestRoute: (context) =>  CreateTradeRequest('','','','','','','','',
        '',
        '',
        '',''),
    Routes.p2pTradeRoute: (context) =>  P2PTrading('','','','','','','','',
        '',
        '',
        '',''),
    Routes.helpScreenRoute: (context) => const HelpScreen(),
    Routes.privacyScreenroute: (context) => const PrivacyScreen(),
    Routes.alertCreateRoute: (context) => const AlertCreateScreen(),
    Routes.tabMarketRoute: (context) => const TabMarket(),
    Routes.supportTicketRoute: (context) => const SupportScreen(),
    Routes.ticketsRoute: (context) => const TicketsScreen(),
    Routes.enableTwoStepVerificationRoute: (context) => const TicketsScreen(),
    Routes.verificationRoute: (context) => const VerificationScreen(),
    Routes.reviewScreen: (context) =>  ReviewScreen('',''),
    Routes.aboutProfileScreen: (context) =>  AboutProfileScreen("","",''),
    Routes.createTimelineScreen: (context) => const CreateTimelineScreen(),
  };
}
