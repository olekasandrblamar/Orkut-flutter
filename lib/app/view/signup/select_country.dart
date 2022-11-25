import 'dart:io';

import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_country.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {


  TextEditingController searchController = TextEditingController();
  List<ModelCountry> newCountryList = List.from(DataFile.countryList);

  onItemChanged(String value) {
    setState(() {
      newCountryList = DataFile.countryList
          .where((string) =>
              string.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
  void finishView() {
    Constant.backToPrev(context);
  }
  List<ModelCountry> datalist=[];
  Future<List<ModelCountry>> fetchdata() async{
    final response=await http.get(Uri.parse('https://orkt.one/api/countries'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
        }
    );
    print(response.statusCode);
    if(response.statusCode==200){
      List<ModelCountry> country_response=countryfromjson(response.body);

      setState(() {
        datalist=country_response;
      });
      return country_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(26)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  gettoolbarMenu(context, "back.svg", () {
                    finishView();
                  },
                      istext: true,
                      title: "Select Country",
                      weight: FontWeight.w700,
                      fontsize: 24,
                      textColor: Colors.black),
                ),
                getVerSpace(FetchPixels.getPixelHeight(18)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  getSearchWidget(
                      context, searchController, () {}, onItemChanged,
                      withPrefix: true),
                ),
                getVerSpace(FetchPixels.getPixelHeight(32)),
                FutureBuilder<List<ModelCountry>>(
                    future:fetchdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return   Expanded(
                          flex: 1,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelHeight(20)),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            primary: true,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              ModelCountry modelCountry = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  PrefData.setImage(modelCountry.image ?? "");
                                  PrefData.setCode(modelCountry.code ?? "");
                                  finishView();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: FetchPixels.getPixelHeight(20)),
                                  height: FetchPixels.getPixelHeight(56),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: FetchPixels.getPixelHeight(16)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: containerShadow,
                                            blurRadius: 18,
                                            offset: const Offset(0, 4)),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          getCountryImage(
                                            modelCountry.image ,
                                          ),
                                          getHorSpace(FetchPixels.getPixelHeight(12)),
                                          getCustomFont(modelCountry.name ?? "", 15,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w400),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          getCustomFont(modelCountry.code ?? "", 15,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w600)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return
                        Expanded(
                        flex: 1,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelHeight(20)),
                          scrollDirection: Axis.vertical,
                          itemCount: datalist.length,
                          itemBuilder: (context, index) {
                            ModelCountry modelCountry = datalist[index];
                            return GestureDetector(
                              onTap: () {
                                PrefData.setImage(modelCountry.image ?? "");
                                PrefData.setCode(modelCountry.code ?? "");
                                finishView();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: FetchPixels.getPixelHeight(20)),
                                height: FetchPixels.getPixelHeight(56),
                                padding: EdgeInsets.symmetric(
                                    horizontal: FetchPixels.getPixelHeight(16)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: containerShadow,
                                          blurRadius: 18,
                                          offset: const Offset(0, 4)),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(12))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        getCountryImage(
                                          modelCountry.image ,
                                        ),
                                        getHorSpace(FetchPixels.getPixelHeight(12)),
                                        getCustomFont(modelCountry.name ?? "", 15,
                                            Colors.black, 1,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        getCustomFont(modelCountry.code ?? "", 15,
                                            Colors.black, 1,
                                            fontWeight: FontWeight.w600)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                ),
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
