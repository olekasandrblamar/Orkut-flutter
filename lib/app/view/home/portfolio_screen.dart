import 'dart:io';

import 'package:orkut/app/models/model_portfolio.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import '../../../base/constant.dart';
import '../../data/data_file.dart';
import '../../routes/app_routes.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();
 // List<ModelPortfolio> newPortfolioList = List.from(DataFile.portfolioList);

  onItemChanged(String value) {
    setState(() {
     datalist = DataFile.portfolioList
          .where((string) =>
              string.currency!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
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
  List<ModelPortfolio> datalist=[];
  Stream<List<ModelPortfolio>> fetchdata() async*{

    final response=await http.get(Uri.parse('https://orkt.one/api/portfolio'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );
    print(response.body);
    if(response.statusCode==200){
      List<ModelPortfolio> portfolio_response=portfoliofromjson(response.body);

      yield portfolio_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children:<Widget> [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(20)),
                  searchWidget(context),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                StreamBuilder<List<ModelPortfolio>>(
                    stream: fetchdata(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return const Text('Error!');
                      } else {
                        return portfolioList(snapshot.data);
                      }
                    }
                    ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  Expanded portfolioList(List<ModelPortfolio>? data) {
    return Expanded(
        flex: 1,
        child: AnimationLimiter(
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              ModelPortfolio modelPortfolio = data![index];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 200),
                  child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: (){
                             // Constant.sendToNext(context, Routes.exchangeRoute);
                            },
                            child: Container(
                        margin: EdgeInsets.only(
                              left: horspace,
                              right: horspace,
                              bottom: FetchPixels.getPixelHeight(20)),
                        padding: EdgeInsets.only(
                              left: FetchPixels.getPixelHeight(16),
                              right: FetchPixels.getPixelHeight(16),
                              top: FetchPixels.getPixelHeight(16),
                              bottom: FetchPixels.getPixelHeight(16)),
                        decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 23,
                                    offset: const Offset(0, 10))
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(14))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getSvgImage(modelPortfolio.id.toString() ?? "",
                                      height: FetchPixels.getPixelHeight(50),
                                      width: FetchPixels.getPixelHeight(50)),
                                  getHorSpace(FetchPixels.getPixelHeight(12)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(modelPortfolio.currency ?? "", 15,
                                          Colors.black, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(FetchPixels.getPixelHeight(3)),
                                      getCustomFont(modelPortfolio.code ?? "",
                                          15, skipColor, 1,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  getCustomFont("\$${modelPortfolio.balance}", 15,
                                      Colors.black, 1,
                                      fontWeight: FontWeight.w600),
                                  getVerSpace(FetchPixels.getPixelHeight(5)),
                                  Wrap(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                modelPortfolio.price![0] == "-"
                                                    ? errorbg
                                                    : successBg,
                                            borderRadius: BorderRadius.circular(
                                                FetchPixels.getPixelHeight(21))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                FetchPixels.getPixelHeight(6),
                                            vertical:
                                                FetchPixels.getPixelHeight(1)),
                                        child: Row(
                                          children: [
                                            getSvgImage(
                                                modelPortfolio.price![0] == "-"
                                                    ? "error_icon.svg"
                                                    : "success_icon.svg"),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(4)),
                                            getCustomFont(
                                                modelPortfolio.price?? '',
                                                13,
                                                modelPortfolio.price![0] == "-"
                                                    ? errorColor
                                                    : successColor,
                                                1,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        ),
                                      )
                                    ],
                                  )
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

  Widget searchWidget(BuildContext context) {
    return getSearchWidget(context, searchController, () {}, onItemChanged,
        withPrefix: true);
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {
        backToPrev();
      },
          istext: true,
          title: "Portfolio",
          fontsize: 24,
          weight: FontWeight.w500,
          textColor: Colors.black),
    );
  }
}
