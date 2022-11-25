import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  Future<void> getData() async {
    firstNameController.text = await PrefData.getFirstName();
    lastNameController.text = await PrefData.getLastName();
    emailController.text = await PrefData.getEmail();
    phoneNoController.text = await PrefData.getPhoneNo();
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
            child: Row(
              children: [
                Expanded(
                  child: getButton(
                    context,
                    const Color.fromARGB(255, 251, 192, 45),
                    "Verify Phone",
                    Colors.white,
                    () {
                      Navigator.pushNamed(
                        context,
                        Routes.verificationRoute,
                      );
                    },
                    16,
                    weight: FontWeight.w600,
                    borderRadius: BorderRadius.circular(
                      FetchPixels.getPixelHeight(15),
                    ),
                    buttonHeight: FetchPixels.getPixelHeight(60),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: getButton(
                    context,
                    blueColor,
                    "Save",
                    Colors.white,
                    () {
                      PrefData.setFirstName(firstNameController.text);
                      PrefData.setLastName(lastNameController.text);
                      PrefData.setEmail(emailController.text);
                      PrefData.setPhoneNo(phoneNoController.text);
                      backToPrev();
                      backToPrev();
                    },
                    16,
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
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(29)),
                  profileImageWidget(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "First Name", firstNameController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Last Name", lastNameController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Phone No", phoneNoController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
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
