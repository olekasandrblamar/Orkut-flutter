
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orkut/app/view/extra_screens/Chat_screen.dart';
import 'package:orkut/app/view/extra_screens/deposit.dart';
import 'package:orkut/app/view/extra_screens/withdraw.dart';
import 'package:orkut/app/view/home/exchange_screen.dart';
import 'package:orkut/app/view/home/home_screen.dart';
import 'package:orkut/app/view/home/tab/tab_home.dart';
import 'package:orkut/app/view/offer/create_offer.dart';
import 'package:orkut/app/view/offer/my-offers.dart';
import 'package:orkut/app/view/offer/offer_list.dart';
import 'package:orkut/app/view/offer/search_offer_list.dart';
import 'package:orkut/app/view/setting/help_screen.dart';
import 'package:orkut/app/view/setting/privacy_screen.dart';
import 'package:orkut/app/view/trade_request/create_trade_request.dart';
import 'package:orkut/app/view/trade_request/my-trades.dart';
import 'package:orkut/app/view/trade_request/trade_requests.dart';
import 'package:orkut/base/color_data.dart';

import '../../../base/widget_utils.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 210,
         child: DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(

                  colors: [blueColor,Colors.blue,Colors.lightBlueAccent],
              )
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      backgroundImage:AssetImage("assets/images/profile_image.png")
                    ),
                    SizedBox(height: 30,),
                    Text("Asheer butt",
                    style: GoogleFonts.barlow(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight:FontWeight.bold,
                    ),
                    ),
                    Text("@username",
                      style: GoogleFonts.barlow(
                        fontSize: 12,
                        color: Colors.white,

                      ),
                    ),
                    SizedBox(height: 5,),
                    Text("iamasheer007@gmail.com",
                      style: GoogleFonts.barlow(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
          ),
          ),
          ListTile(
            title:getCustomFont("Dashboard", 14, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.bars,
            size: 20,
            ),
            onTap: (){
               Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("Offers list", 15, Colors.black, 1),
            leading: Icon(Icons.list),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferListScreen()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: getCustomFont("Create offer", 15, Colors.black, 1),
            leading: Icon(Icons.create),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOfferScreen()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: getCustomFont("My offers", 15, Colors.black, 1),
            leading: Icon(Icons.local_offer),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Myoffers()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("Trade request", 15, Colors.black, 1),
            leading: Icon(Icons.request_page_sharp),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Trade_requests()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: getCustomFont("My Trades", 15, Colors.black, 1),
            leading: Icon(Icons.my_library_books_rounded),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Mytrades()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:   getCustomFont("Exchange", 15, Colors.black, 1),
            leading: Icon(Icons.currency_exchange_outlined),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExchangeScreen(null)));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: getCustomFont("Deposit", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.moneyBillTransfer),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Deposit()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("Withdraw", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.moneyCheckDollar),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          SizedBox(height: 40,),
          Divider(
          thickness: 2,
          ),
          ListTile(
            title:   getCustomFont("Exchange", 15, Colors.black, 1),
            leading: Icon(Icons.currency_exchange_outlined),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExchangeScreen(null)));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:   getCustomFont("Send money", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.moneyCheck),
            onTap: (){
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          Divider(
            thickness: 2,
          ),
SizedBox(height: 40,),
          ListTile(

            title:getCustomFont("Terms & Conditions", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.code),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyScreen()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("FAQ", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.questionCircle),
            onTap: (){
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("Support", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.circleInfo),
            onTap: (){
    Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title:getCustomFont("Tell a freind", 15, Colors.black, 1),
            leading: Icon(FontAwesomeIcons.shareNodes),
            onTap: (){
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),

        ],
      ),
    );
  }
}
