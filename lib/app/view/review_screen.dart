import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../base/constant.dart';
import '../../base/emoji_utils.dart';
import '../../base/pref_data.dart';

class ReviewScreen extends StatefulWidget {
final  String trade_id;
final String user_id;

ReviewScreen(this.trade_id,this.user_id);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController payController = TextEditingController();
  void backToPrev() {
    Constant.backToPrev(context);
  }
String device_token='';
  String message='';
  String error='';
  bool is_submit=false;
@override
void initState(){
  Future<String> _futuretoken=PrefData.getToken();
  _futuretoken.then((value)async {
    setState(() {
      device_token=value;
    });
  });
}
  Future<void> createreview(
     String trade_id,
     String offer_user_id,
     String rating,
     String comment,
      ) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/trade/submit-review'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.authorizationHeader:'Bearer '+device_token,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'trade_id':trade_id,
        'offer_user_id': offer_user_id,
          'rating':rating,
        'comment':comment,
      }),
    );
    print(response.body);
      setState(() {
message=jsonDecode(response.body)['message'].toString();
      });


  }

String rating='';

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: horspace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(
                    context,
                    back: true,
                    onBackPress: () {
                     backToPrev();
                    },
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(23)),
                  Center(child: getCustomFont("How was your experience?", 18, Colors.black, 1,
                      fontWeight: FontWeight.w600)),
                  getVerSpace(FetchPixels.getPixelHeight(16)),
                  Center(child: EmojiFeedback(onChange: (v){
                    print(v.toString());
                    setState(() {
                      rating=v.toString();
                    });

                  })),
                  getVerSpace(FetchPixels.getPixelHeight(16)),

                  getDefaultTextFiledWithLabel(
                      context, "Start Writing Feedback", payController,
                      withprefix: false,
                      suffiximage: "message.svg",
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(180),
                       ),
                  getVerSpace(FetchPixels.getPixelHeight(50)),
                  Center(
                    child: getButton(context, blueColor, is_submit==false?"Submit":"Wait", Colors.black, () async{
                      setState(() {
                        is_submit=true;
                      });
print(widget.trade_id);
print(widget.user_id);
print(rating);
print(payController.text);
                    await  createreview(widget.trade_id, widget.user_id, rating, payController.text);
                    if(message=="success") {
                      setState(() {
                        is_submit=false;
                      });
                      AlertDialog alert = AlertDialog(
                        title: Icon(FontAwesomeIcons.circleCheck),
                        content:
                            Text(message),

                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                    else{
                      setState(() {
                        is_submit=false;
                      });
                      AlertDialog alert = AlertDialog(
                        title: Icon(FontAwesomeIcons.circleCheck),
                        content:
                            Text(message),
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                    }, 16,
                        weight: FontWeight.w600,
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                        buttonWidth: FetchPixels.getWidthPercentSize(30),
                        buttonHeight: FetchPixels.getPixelHeight(50)),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }


  Widget appBar(BuildContext context, {back = false, onBackPress}) {
    return getPaddingWidget(
      EdgeInsets.all(5),
      gettoolbarMenu(
        context,
        "back.svg",
            () {
          onBackPress();
        },
        istext: true,
        title: "Write a Review",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: back,
        isrightimage: true,
        rightimage: "more.svg",
      ),
    );
  }

  Widget commentScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 30,
            bottom: 10,
          ),
          child: getCustomFont(
            "All Comments",
            20,
            Colors.black,
            1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: getDefaultTextFiledWithLabel(
            context,
            "Write a Comment...",
            TextEditingController(),
            withSufix: true,
            suffiximage: "send.svg",
            onSuffixPress: () {},
            height: FetchPixels.getPixelHeight(60),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  getVerSpace(
                    20,
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget blogCard(ModelNews news, {onPress}) {
    return Container(
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          35,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        child: InkWell(
          onTap: onPress,
          child: Column(children: [
            Container(
              height: FetchPixels.getPixelHeight(220),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/${news.image}",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      FetchPixels.getPixelHeight(
                        30,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            getHorSpace(5),
                            getCustomFont(
                              news.hour,
                              16,
                              Colors.white,
                              1,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                40,
                              ),
                            ),
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(30),
                vertical: FetchPixels.getPixelHeight(15),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: getCustomFont(
                        news.name,
                        20,
                        Colors.black,
                        2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    getHorSpace(
                      20,
                    ),
                    getCustomFont(
                      news.readingTime,
                      15,
                      textColor,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                getVerSpace(
                  5,
                ),
                getCustomFont(
                  news.description,
                  15,
                  textColor,
                  4,
                  fontWeight: FontWeight.w400,
                ),
                getVerSpace(
                  20,
                ),
                Container(
                  color: textColor.withOpacity(0.5),
                  height: 1,
                ),
                getVerSpace(
                  20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: AssetImage(
                            news.author,
                          ),
                        ),
                        getHorSpace(
                          5,
                        ),
                        getCustomFont(
                          news.author,
                          16,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                          size: 20,
                        ),
                        getHorSpace(5),
                        getCustomFont(
                          news.views,
                          14,
                          textColor,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      ]),
                    ),
                  ],
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
