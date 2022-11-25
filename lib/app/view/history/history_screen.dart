
import 'dart:io';

import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_history.dart';
import 'package:orkut/app/view/dialog/statement_dialog.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import '../../../base/pref_data.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
 // List<ModelHistory> historyLists = DataFile.historyList;
  List<ModelHistory> datalist=[];
  bool isdata=false;
  String device_token="";
  @override
  void initState(){
   super.initState();
   Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
     setState(() {
       device_token=value;
     });
   },
   );
  }
  Stream<List<ModelHistory>> fetchdata() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/transaction/history?page=1&per_page=10'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );
    if(response.statusCode==200){
      List<ModelHistory> history_response=historyfromjson(response.body);
   yield history_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(
                    FetchPixels.getPixelHeight(20),
                  ),
                streamBuilder(),
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

  Expanded emptyWidget(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage("browsers.svg"),
        getVerSpace(FetchPixels.getPixelHeight(26)),
        getCustomFont("No History Yet!", 20, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getMultilineCustomFont(
            "Go to crypto transaction and get started.", 16, Colors.black,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getButton(
            context, Colors.white, "Go to transaction", blueColor, () {}, 16,
            weight: FontWeight.w600,
            isBorder: true,
            borderColor: blueColor,
            borderWidth: FetchPixels.getPixelHeight(2),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelHeight(90)))
      ],
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
      title: getCustomFont("History", 22, Colors.black, 1,
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
        )
      ],
    );
  }
  StreamBuilder streamBuilder(){
    return  StreamBuilder<List<ModelHistory>>(
        stream: fetchdata(),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return const Center(child:CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('Error!');
          } else {

            return  historyList(snapshot.data!);
          }
        }
    );
  }
}
