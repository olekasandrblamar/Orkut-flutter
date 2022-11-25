
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/model_history.dart';
import '../dialog/statement_dialog.dart';
import 'package:http/http.dart' as http;


class Withdraw_history extends StatefulWidget {
  const Withdraw_history({Key? key}) : super(key: key);

  @override
  State<Withdraw_history> createState() => _Withdraw_historyState();
}

class _Withdraw_historyState extends State<Withdraw_history> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelHistory> datalist=[];
  bool isdata=false;
  @override
  void initState(){
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async{
    Future<String> _futuretoken=PrefData.getToken();
    String device_token="";
    await  _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );

    final response=await http.get(Uri.parse('https://orkt.one/api/transaction/history?page=1&per_page=10'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      List<ModelHistory> history_response=historyfromjson(response.body);
      setState(() {
        datalist=history_response;
        isdata=true;
      });

    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
      FetchPixels(context);
    return WillPopScope(
      onWillPop: () async {
        backToPrev();
        return false;
      },
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
    body: SafeArea(
      child: getPaddingWidget(
        EdgeInsets.all(0),
          Column(
            children: [
              getVerSpace(
                FetchPixels.getPixelHeight(20),
              ),Container(
                height: FetchPixels.getPixelHeight(250),
                width: FetchPixels.getPixelWidth(500),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.deepPurple,blueColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                child:Column(
                  children:[
                    getVerSpace(FetchPixels.getPixelHeight(36)),
                    getCustomFont("Withdraw History", 25, Colors.white, 1),
                    getVerSpace(FetchPixels.getPixelHeight(26)),
                    getCustomFont("Total amount", 20, Colors.blueGrey, 1),
                    getHorSpace(FetchPixels.getPixelHeight(14)),
                    getCustomFont("\$912", 25, Colors.yellow, 1),
                  ],
                ),
              ),
                    isdata==true?
                    historyList(datalist)
                        :
                    CircularProgressIndicator(),
            ],
          ),
        ),
    ),
    ),
    );
  }

  Expanded historyList(List<ModelHistory> historyLists) {
    return Expanded(
        flex: 1,
        child: AnimationLimiter(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: historyLists.length,
            itemBuilder: (context, index) {
              ModelHistory modelHistory = historyLists[index];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 200),
                  child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  builder: (context) {
                                    return const StatementDialog();
                                  },
                                  context: context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: horSpace),
                              padding: EdgeInsets.symmetric(
                                  horizontal: FetchPixels.getPixelHeight(16),
                                  vertical: FetchPixels.getPixelHeight(16)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: shadowColor,
                                        blurRadius: 23,
                                        offset: const Offset(0, 7))
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(14))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      getNetworkImage(modelHistory.image ?? "",
                                          height: FetchPixels.getPixelHeight(50),
                                          width: FetchPixels.getPixelHeight(50)),
                                      getHorSpace(FetchPixels.getPixelHeight(14)),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          getCustomFont(modelHistory.name ?? "", 15,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w600),
                                          getVerSpace(
                                              FetchPixels.getPixelHeight(3)),
                                          getCustomFont(modelHistory.btc ?? "", 15,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      getCustomFont(
                                          modelHistory.date ?? "",
                                          12,
                                          modelHistory.date == "Failed"
                                              ? error
                                              : textColor,
                                          1,
                                          fontWeight: FontWeight.w400),
                                      getVerSpace(FetchPixels.getPixelHeight(3)),
                                      getCustomFont(
                                          modelHistory.price ?? "",
                                          15,
                                          modelHistory.price == "Need Help?"
                                              ? blueColor
                                              : success,
                                          1,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))));
            },
          ),
        ));
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: FetchPixels.getPixelHeight(66),
      leading: getPaddingWidget(
          EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(21)),
          GestureDetector(
            child: getSvgImage("back.svg"),
            onTap: () {
              backToPrev();
            },
          )),
      title: getCustomFont("", 22, Colors.black, 1,
          fontWeight: FontWeight.w700),
      centerTitle: true,
      actions: [
        Row(
          children: [
            getSvgImage("statement.svg"),
            getHorSpace(FetchPixels.getPixelHeight(1)),
            getCustomFont("STATEMENT", 16, blueColor, 1,
                fontWeight: FontWeight.w600),
            getHorSpace(FetchPixels.getPixelHeight(20))
          ],
        ),
      ],
    );
  }
}
