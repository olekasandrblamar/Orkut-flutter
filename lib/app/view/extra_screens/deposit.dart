import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../drawer/mydrawer.dart';


class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  var horspace = FetchPixels.getPixelHeight(20);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final deposit_controler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        endDrawer: Mydrawer(),
        body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
        children: [
        getVerSpace(FetchPixels.getPixelHeight(14)),
    appBar(
    context,
    ),
    getVerSpace(FetchPixels.getPixelHeight(23)),
          getDefaultTextFiledWithLabel(context, "Deposit amount ",deposit_controler ),
          getVerSpace(FetchPixels.getPixelHeight(35)),
          getVerSpace(FetchPixels.getPixelHeight(35)),
          Container(
              width: FetchPixels.getWidthPercentSize(30),
              child: getButtonWithIcon(
                  context, blueColor,"Deposit", Colors.white,
                      () async{

                  }, 15,
                  weight: FontWeight.bold,
                  borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                  buttonHeight: FetchPixels.getPixelHeight(48),
                  sufixIcon: true,
                  suffixImage: "arrow_right.svg",
                suffix_color: Colors.white,
              )
          ),
    ],
    ),
    ),
    ),
    );
  }
  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(
            width: FetchPixels.getPixelWidth(250),
            height: 40,
            child:
            gettoolbarMenu(
              context,
              "back.svg",
                  () {},
              istext: true,
              title: "Deposit",
              fontsize: 24,
              weight: FontWeight.w400,
              textColor: Colors.black,
              isleftimage: false,
            ),
          ),
          IconButton(onPressed: (){
            _scaffoldKey.currentState!.openEndDrawer();
          },
              icon:Icon(Icons.more_vert,
                size: 40,
              )
          ),
        ],
      ),
    );
  }
}
