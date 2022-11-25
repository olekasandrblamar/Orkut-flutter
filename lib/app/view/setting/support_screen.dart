import 'dart:convert';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../base/pref_data.dart';
class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}
bool is_submit=false;
String message='';
String errors='';
String status='';
class _SupportScreenState extends State<SupportScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }
  final message_controller= TextEditingController();
  Future<String> postdata(String message) async{
    Future<String> _futuretoken= PrefData.getToken();
    String device_token="";
    await  _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );
    final response=await http.post(
      Uri.parse('https://orkt.one/api/open/ticket'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.authorizationHeader:'Bearer '+device_token,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
       'subject':message,
      }),
    );
    print(response.statusCode);
    print(response.body);
   setState(() {
     message=jsonDecode(response.body)['message'].toString();
     errors=jsonDecode(response.body)['errors'].toString();
     status=jsonDecode(response.body)['status'].toString();
   });
      return '';


  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      backToPrev();
                    },
                    istext: true,
                    title: "Support Tickets",
                    fontsize: 24,
                    weight: FontWeight.w700,
                    textColor: Colors.black,
                    isrightimage: true,
                    rightimage: "more.svg",
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(39)),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(
                              "Ticket Number:",
                              20,
                              Colors.black,
                              1,
                              fontWeight: FontWeight.w600,
                            ),
                            getVerSpace(
                              FetchPixels.getPixelHeight(10),
                            ),
                            getCustomFont(
                              "TKT2384923O94",
                              20,
                              successColor,
                              1,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.left,
                            ),
                            getVerSpace(
                              FetchPixels.getPixelHeight(30),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 7))
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                maxLines: 10,
                                controller:message_controller,
                                onTap: () {
                                  // function();
                                },
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: Constant.fontsFamily,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 30,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Type Your Message Here",
                                  hintStyle: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: Constant.fontsFamily,
                                  ),
                                ),
                              ),
                            ),
                            getVerSpace(
                              FetchPixels.getPixelHeight(40),
                            ),
                            Center(
                              child: getButton(
                                context,
                                blueColor,
                               is_submit==false? "Submit":"Wait",
                                Colors.white,
                                ()async {
                                  setState(() {
                                    is_submit=true;
                                  });
                                    await postdata(message_controller.text);
                                    if(status=='success'){
                                      setState(() {
                                        is_submit=false;
                                      });
                                      // set up the AlertDialog
                                      AlertDialog alert = AlertDialog(
                                        title: Icon(FontAwesomeIcons.circleCheck),
                                        content: Text(status),
                                      );

                                      // show the dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    }
                                    else {
                                      setState(() {
                                        is_submit=false;
                                      });
                                      AlertDialog alert = AlertDialog(
                                        title: Icon(FontAwesomeIcons.circleExclamation),
                                        content:
                                        Text(message+" "+errors),
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    }

                                    },
                                18,
                                buttonWidth: FetchPixels.getPixelWidth(140),
                                weight: FontWeight.w600,
                                borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(15),
                                ),
                                buttonHeight: FetchPixels.getPixelHeight(60),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }
}
