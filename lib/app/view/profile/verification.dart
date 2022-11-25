import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  TextEditingController phoneController = TextEditingController();

  String? image;
  String? code;

  Future<void> doSomeAsyncStuff() async {
    image = await PrefData.getImage();

    code = await PrefData.getCode();
  }

  Future<void> getData() async {
    phoneController.text = await PrefData.getPhoneNo();
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
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horSpace, vertical: FetchPixels.getPixelHeight(30)),
            child: getButton(context, blueColor, "Save", Colors.white, () {
              PrefData.setFirstName(phoneController.text);
              backToPrev();
              backToPrev();
            }, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)),
          ),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
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
                          phoneController, code ?? "+1",
                          function: () {},
                          height: FetchPixels.getPixelHeight(60),
                          isEnable: false,
                          minLines: true,
                          image: image ?? "image_albania.jpg")),
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          getAssetImage("profile_photo.png",
              height: FetchPixels.getPixelHeight(105),
              width: FetchPixels.getPixelHeight(105)),
          Positioned(
              child: Container(
            height: FetchPixels.getPixelHeight(34),
            width: FetchPixels.getPixelHeight(34),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(30)),
                boxShadow: [
                  BoxShadow(
                      color: containerShadow,
                      blurRadius: 18,
                      offset: const Offset(0, 4))
                ]),
            padding: EdgeInsets.all(FetchPixels.getPixelHeight(5)),
            child: getSvgImage("edit.svg"),
          ))
        ],
      ),
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
      title: "Edit Profile",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
