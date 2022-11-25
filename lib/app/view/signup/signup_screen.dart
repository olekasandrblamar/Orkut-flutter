import 'dart:convert';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/profile/verification.dart';
import 'package:orkut/app/view/signup/verify_screen.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../base/color_data.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var ispass = false;
  bool agree = false;
  String? image;
  String? code;

  Future<void> doSomeAsyncStuff() async {
    image = await PrefData.getImage();

    code = await PrefData.getCode();
  }
  String message='';
  String status='';
  bool issignup=false;
  String error='';
  Future<void> postdata(String name, String email, String password, String country, String dial_code, String phone) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/signup'),
      headers: {
      HttpHeaders.acceptHeader:'application/json',
     HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
          'name':name,
        'email':email,
        'password':password,
        'country':country,
        'dial_code':dial_code,
        'phone':phone,
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
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(20)),
              children: [
                getVerSpace(FetchPixels.getPixelHeight(98)),
                getCustomFont("Sign Up", 24, Colors.black, 1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    "Welcome to Örkt! Enter your detail for sign up!", 15, Colors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    txtHeight: FetchPixels.getPixelHeight(1.3)),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getDefaultTextFiledWithLabel(context, "Name", nameController,
                    height: FetchPixels.getPixelHeight(60), isEnable: false),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(context, "Email", emailController,
                    height: FetchPixels.getPixelHeight(60), isEnable: false),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.selectCountryRoute)
                          .then((value) {
                        setState(() {
                          doSomeAsyncStuff();
                        });

                      });
                    },
                    child: getCountryTextField(context, "Phone Number",
                        phoneNumberController, code ?? "+1",
                        function: () {},
                        height: FetchPixels.getPixelHeight(60),
                        isEnable: false,
                        minLines: true,
                        image: image ?? 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg')),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(
                    context, "Password", passwordController,
                    height: FetchPixels.getPixelHeight(60),
                    withSufix: true,
                    suffiximage: "eye.svg",
                    isEnable: false,
                    isPass: ispass, imagefunction: () {
                  setState(() {
                    !ispass ? ispass = true : ispass = false;
                  });
                }),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          agree = !agree;
                        });
                      },
                      child: Container(
                        height: FetchPixels.getPixelHeight(24),
                        width: FetchPixels.getPixelHeight(24),
                        decoration: BoxDecoration(
                            color: (agree) ? blueColor : Colors.white,
                            border: (agree)
                                ? null
                                : Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(6))),
                        padding: EdgeInsets.symmetric(
                            vertical: FetchPixels.getPixelHeight(6),
                            horizontal: FetchPixels.getPixelWidth(4)),
                        child: (agree) ? getSvgImage("done.svg") : null,
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    getCustomFont(
                        "I agree with Terms & Privacy", 16, Colors.black, 1,
                        fontWeight: FontWeight.w400)
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, issignup==false?"Sign up":"wait..", Colors.white, () async{
                  setState(() {
                    issignup=true;
                  });
             await  postdata(nameController.text,emailController.text,passwordController.text,'Belgium',code.toString(),phoneNumberController.text);
                  if(message=="Verification Code sent to email"){
                    setState(() {
                      issignup=false;
                    });
                    AlertDialog alert = AlertDialog(
                      title:  Icon(FontAwesomeIcons.solidCircleCheck),
                      content: Container(
                        height: 200,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(message+"\nGo to Verification page"),
                            getButtonWithIcon(context, blueColor, "Verification", Colors.white,(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(email:emailController.text)));
                            },15,
                                buttonHeight: 50,
                                buttonWidth: 140,
                              suffixImage: "arrow_right.svg",
                              suffix_color: Colors.white
                            )
                          ],
                        ),
                      ),
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );

                  }
                  else{
                    setState(() {
                      issignup=false;
                    });
                    AlertDialog alert = AlertDialog(
                      title: Icon(FontAwesomeIcons.circleExclamation),
                      content: message==null?Text(status):Text(message+error),
                    );
                    // show the dialog
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
                    buttonHeight: FetchPixels.getPixelHeight(60)),
      getVerSpace(FetchPixels.getPixelHeight(20)),
    getButton(context, blueColor, "Verification", Colors.white, () async{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(email:emailController.text)));
    },
        16,
        weight: FontWeight.w600,
        borderRadius:
        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
        buttonHeight: FetchPixels.getPixelHeight(60)
    ),
                getVerSpace(FetchPixels.getPixelHeight(136)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont(
                        "Already have an account? ", 15, Colors.black, 1,
                        fontWeight: FontWeight.w400),
                    GestureDetector(
                      onTap: () {
                        Constant.sendToNext(context, Routes.loginRoute);
                      },
                      child: getCustomFont("Login", 15, blueColor, 1,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
