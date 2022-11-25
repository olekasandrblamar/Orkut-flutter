import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orkut/app/view/extra_screens/start_trade.dart';
import 'package:orkut/base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';



class Trade_select extends StatefulWidget {
  final String   type_trade;
  final String     crypid;
  final String       fiatid;
  final String       user_id;
  final String       price;
  final String       minimum;
  final String       maximum;
  Trade_select(this.type_trade,this.crypid,this.fiatid,this.user_id,this.price,this.minimum,this.maximum);
  @override
  State<Trade_select> createState() => _Trade_selectState();
}

class _Trade_selectState extends State<Trade_select> {

  String type='';
  String cryp_id='';
  String fiat_id='';
  String user_id='';
  String price='';
  String minimum='';
  String maximum='';
  final fiat_amount_controller=TextEditingController();
  void backToPrev() {
    Constant.backToPrev(context);
  }
  String device_token="";
  @override
  void initState(){
    super.initState();
    type=widget.type_trade;
    cryp_id=widget.crypid;
    fiat_id=widget.fiatid;
    user_id=widget.user_id;
    price=widget.price;
    minimum=widget.minimum;
    maximum=widget.maximum;
  }






  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(14)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getCustomFont("Total amount:$price ", 25, orangeColor, 1,),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getCustomFont("Limit:${minimum}-${maximum} ", 14, orangeColor, 1,),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getDefaultTextFiledWithLabel(
                  context, "Type the amount here between the limit",fiat_amount_controller,
                  withprefix: false,

                  image: "message.svg",

                  isEnable: false,
                  height: FetchPixels.getPixelHeight(60),
                ),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getButton(
                  context,
                  const Color.fromRGBO(251, 192, 45, 1),
                  "Start trade",
                  Colors.black,
                      () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Trade_start(type,cryp_id,fiat_id,fiat_amount_controller.text, user_id, price)));
                  },
                  18,
                  buttonWidth: FetchPixels.getPixelWidth(140),
                  weight: FontWeight.w600,
                  borderRadius: BorderRadius.circular(
                    FetchPixels.getPixelHeight(15),
                  ),
                  buttonHeight: FetchPixels.getPixelHeight(60),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }



  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(

            width: 320,
            height: 40,
            child:
            gettoolbarMenu(
              context,
              "back.svg",
                  () {
                backToPrev();
              },
              istext: true,
              title: "Select limit",
              fontsize: 24,
              weight: FontWeight.w700,
              textColor: Colors.black,
              isleftimage: true,
            ),
          ),
        ],
      ),
    );
  }



}
