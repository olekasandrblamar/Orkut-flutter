import 'dart:convert';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/view/dialog/verify_dialog.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import '../../../base/color_data.dart';

class VerifyScreen extends StatefulWidget {
final String email;
VerifyScreen({required this.email});
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  FocusNode myFocusNode = FocusNode();
  Color color = borderColor;
  final code_controller=TextEditingController();
String email_user='';
@override
initState(){
  super.initState();
 setState(() {
   email_user=widget.email;
 });
}
bool grey_out=false;
  Future<void> sendcode(String email) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/send-verification/code'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email':email,
      }),
    );
print(response.statusCode);
print(response.body);
    if(response.statusCode==200){

    }
    else{
      throw Exception('Failed to send  data');
    }
  }
String message='';
  String status='';
  String error='';
  Future<void> verifycode(String code,String email) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/verify/code'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'code':code,
        'email':email
      }),
    );
    print(response.body);
    setState(() {
      message=jsonDecode(response.body)['message'].toString();
      status=jsonDecode(response.body)['status'].toString();
      error=jsonDecode(response.body)['errors'].toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(60),
      margin: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(5)),
      textStyle: TextStyle(
        fontSize: FetchPixels.getPixelHeight(24),
        color: blueColor,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: color, width: FetchPixels.getPixelHeight(1)),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    );
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(26)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      finishView();
                    },
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(46)),
                  getCustomFont("Verify", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Enter code sent to your email!", 15, Colors.black,
                      fontWeight: FontWeight.w400,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "Enter code here", code_controller,
                      height: FetchPixels.getPixelHeight(60),
                      isEnable: false,
                     ),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, blueColor, "Verify", Colors.white, () async{
                     await verifycode(code_controller.text,email_user);
                     AlertDialog alert = AlertDialog(
                       title: Icon(FontAwesomeIcons.circleExclamation),
                       content: Text(message+error),
                     );
                     // show the dialog
                     showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return alert;
                       },
                     );
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(80)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(
                          "Didn’t recieve code? ", 15, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          print(email_user);
                          sendcode(email_user);
                        },
                        child: getCustomFont("Resend", 15, blueColor, 1,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
