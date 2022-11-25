import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../drawer/mydrawer.dart';


class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
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
              Padding(padding: EdgeInsets.all(10),
              child:getDefaultTextFiledWithLabel(context, "Withdraw amount ",deposit_controler )),
              getVerSpace(FetchPixels.getPixelHeight(35)),
              getVerSpace(FetchPixels.getPixelHeight(35)),
              Container(
                  width: FetchPixels.getWidthPercentSize(35),
                  child: getButtonWithIcon(
                      context, blueColor,"Withdraw", Colors.white,
                          () async{
                      }, 15,
                      weight: FontWeight.bold,
                      borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      buttonHeight: FetchPixels.getPixelHeight(48),
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg",
                    suffix_color: blueColor,
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
              title: "Withdraw",
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
