import 'dart:convert';
import 'dart:io';

import 'package:orkut/app/models/model_profile.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);

  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNo = "";

  Future<void> getData() async {
    firstName = await PrefData.getFirstName();
    lastName = await PrefData.getLastName();
    email = await PrefData.getEmail();
    phoneNo = await PrefData.getPhoneNo();
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horspace, vertical: FetchPixels.getPixelHeight(30)),
            child: getButton(context, blueColor, "Edit Profile", Colors.white,
                () {
              Navigator.pushNamed(context, Routes.editProfileRoute)
                  .then((value) {
                getData().then((value) {
                  setState(() {});
                });
              });
            }, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)),
          ),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horspace),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(29)),
                  profileImageWidget(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getCustomFont("First Name", 15, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(4)),
                  getCustomFont(firstName, 15, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(12)),
                  getDivider(deviderColor, 0, FetchPixels.getPixelHeight(1)),
                  getVerSpace(FetchPixels.getPixelHeight(24)),
                  getCustomFont("Last Name", 15, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(4)),
                  getCustomFont(lastName, 15, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(12)),
                  getDivider(deviderColor, 0, FetchPixels.getPixelHeight(1)),
                  getVerSpace(FetchPixels.getPixelHeight(24)),
                  getCustomFont("Email", 15, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(4)),
                  getCustomFont(email, 15, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(12)),
                  getDivider(deviderColor, 0, FetchPixels.getPixelHeight(1)),
                  getVerSpace(FetchPixels.getPixelHeight(24)),
                  getCustomFont("Phone No", 15, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(4)),
                  getCustomFont(phoneNo, 15, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(12)),
                  getDivider(deviderColor, 0, FetchPixels.getPixelHeight(1)),
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

  Align profileImageWidget() {
    return Align(
      alignment: Alignment.center,
      child: getAssetImage("profile_photo.png",
          height: FetchPixels.getPixelHeight(105),
          width: FetchPixels.getPixelHeight(105)),
    );
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "My Profile",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
