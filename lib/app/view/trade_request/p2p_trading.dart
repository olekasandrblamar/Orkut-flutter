import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';
import 'create_trade_request.dart';

class P2PTrading extends StatefulWidget {
  final String type;
  final String cryp_id;
  final String fiat_id;
  final String user_id;
  final String price;
  final String minimum;
  final String maximum;
  final String currency;
  final String terms;
  final String instruction;
  final String photo;
  final String code;
  P2PTrading(this.type,this.cryp_id,this.fiat_id,this.user_id,this.price,this.minimum,this.maximum,this.currency,this.terms,this.instruction,this.photo,this.code);

  @override
  State<P2PTrading> createState() => _P2PTradingState();
}

class _P2PTradingState extends State<P2PTrading> {
  var horspace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
        body: SafeArea(child: Column(
          children: [
            getVerSpace(FetchPixels.getPixelHeight(14)),
            appBar(
              context,
            ),
            getVerSpace(FetchPixels.getPixelHeight(14)),
            Center(
              child: getCustomFont("Do's and Dont's",
                  18, Colors.amber, 1,
                  fontWeight: FontWeight.w700),
            ),
            getVerSpace(FetchPixels.getPixelHeight(14)),
            getAssetImage("p2p.png",
                width: FetchPixels.width*0.7,
                height: FetchPixels.height*0.3),
            getDos('01',Colors.red, 'Each order has a specific payment time window, please make payment within the time window'),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getDos('02',Colors.amber, 'Click on "Transferred, Notify seller" before the countdown timer ends. Failure to do so wil lead tp tje cancellation of order and may result in a financial loss'),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getDos('03',Colors.green, 'To avoid financial loss, do not cancel tje order after payment'),

            Expanded(child: getVerSpace(FetchPixels.getPixelHeight(14))),
            
            Container(
              width: FetchPixels.width*0.7,
              child: getButtonWithIcon(
                  context, blueColor, "Trade Now", Colors.white,
                      () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTradeRequest(widget.type,widget.cryp_id,widget.fiat_id,widget.user_id,widget.price,widget.minimum,widget.maximum,widget.currency,widget.terms,widget.instruction,widget.photo,widget.code)));
  }, 18,
                  weight: FontWeight.bold,
                  borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                  buttonHeight: FetchPixels.getPixelHeight(48),
                  sufixIcon: true,
                  suffixImage: "arrow_right.svg",
                suffix_color: Colors.white,
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),


          ],
        ),

        ));
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(
        context,
        "back.svg",
            () {    Constant.backToPrev(context);
            },
        istext: true,
        title: "P2P Trading",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: true,
        isrightimage: true,
        rightimage: "more.svg",
      ),
    );
  }
  Widget getDos(no,color,text){
    return SizedBox(
      width: FetchPixels.width*0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,height:50,decoration: BoxDecoration(
            color: color,shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25),right: Radius.elliptical(5,25)),

          ),child: Center(child: getCustomFont(no, 20, Colors.white, 1)),),
          getHorSpace(FetchPixels.getPixelWidth(10)),
          Expanded(
            child: getCustomFont(text,
                18, Colors.grey, 5,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
