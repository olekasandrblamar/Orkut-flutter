import 'dart:convert';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/models/model_login.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/home/home_screen.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var ispass = false;
  String message='';
  String errors='';

  Future <List<String>>? _futureLogin;
  Future<List<String>> postdata(
      String email,
      String password,
    ) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/login'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'device_name':'Samsung',
        'email':email,
        'password':password,
        'device_token':'32423423423423423423sdfasfsdf'
      }),
    );
     print(response.statusCode);
     print(jsonDecode(response.body)['token']);
     print(jsonDecode(response.body)['user']);
     print(response.body);
     print(response.request);
      String token_response=(jsonDecode(response.body)['token'].toString());
      String status_response=(jsonDecode(response.body)['status'].toString());
      setState(() {
        errors=jsonDecode(response.body)['errors'].toString();
        message=jsonDecode(response.body)['message'].toString();
      });
      List<String> full_response=[token_response,status_response];
     // print(full_response);
      return full_response;
  }
  bool is_submit=false;
  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                primary: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(98)),
                  getCustomFont("Login", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Hello ninja, welcome to Örkt.", 15, Colors.black,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      txtHeight: FetchPixels.getPixelHeight(1.3)),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController,
                      isEnable: false, height: FetchPixels.getPixelHeight(60)),
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
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  GestureDetector(
                    onTap: () {
                      Constant.sendToNext(context, Routes.forgotRoute);
                    },
                    child: getCustomFont("Forgot Password?", 15, blueColor, 1,
                        fontWeight: FontWeight.w600, textAlign: TextAlign.end),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, blueColor, is_submit==false?"Login":"Wait", Colors.white, ()async {

                    setState(() {
                      is_submit=true;
                    });
                    List<String> token=[];
                    _futureLogin= postdata(emailController.text, passwordController.text);
                    _futureLogin?.then((value) {
                      setState(() {
                        token = value;
                      });
                      if(token[1]=="success"){
                        setState(() {
                          is_submit=false;
                        });
                       PrefData.setToken(token[0]);
                        PrefData.setLogIn(true);
                        Constant.sendToNext(context, Routes.homeScreenRoute);
                      }
                      else {
                        setState(() {
                          is_submit=false;
                        });
                        AlertDialog alert = AlertDialog(
                          title: Icon(FontAwesomeIcons.circleCheck),
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
                    }
                    );
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                  // FutureBuilder<List<String>>(
                  //     future: _futureLogin,
                  //     builder: (context,snapshot){
                  //       if(snapshot.hasData){
                  //         if(snapshot.data![1]=="success") {
                  //        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  //         }
                  //         else{
                  //           return Text("User not found");
                  //         }
                  //       }
                  //       else if (snapshot.hasError) {
                  //         print(snapshot.error);
                  //         return Text('Sorry${snapshot.error}');
                  //       }
                  //       return const CircularProgressIndicator();
                  //     }),
                  getVerSpace(FetchPixels.getPixelHeight(50)),
                  getCustomFont("Or sign in with", 15, Colors.black, 1,
                      fontWeight: FontWeight.w400, textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    children: [
                      Expanded(
                        child: getButton(context, Colors.white, "FingerPrint",
                            Colors.black, () {}, 14,
                            weight: FontWeight.w600,
                            isIcon: true,
                            image: "fingerprint.png",
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: containerShadow,
                                  blurRadius: 18,
                                  offset: const Offset(0, 4))
                            ],
                            buttonHeight: FetchPixels.getPixelHeight(60)),
                      ),
                      getHorSpace(FetchPixels.getPixelHeight(20)),
                      Expanded(
                        child: getButton(context, Colors.white, "Pattern",
                            Colors.black, () {}, 14,
                            weight: FontWeight.w600,
                            isIcon: true,
                            image: "pattern.png",
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: containerShadow,
                                  blurRadius: 18,
                                  offset: const Offset(0, 4))
                            ],
                            buttonHeight: FetchPixels.getPixelHeight(60)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(147)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(
                          "Don’t have an account? ", 15, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.signUpRoutes);
                        },
                        child: getCustomFont("Sign Up", 15, blueColor, 1,
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
