import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

import '../extra_screens/Chat_screen.dart';


class AboutProfileScreen extends StatefulWidget {
String name;
String photo;
String id;
AboutProfileScreen(this.name,this.photo,this.id);
  @override
  State<AboutProfileScreen> createState() => _AboutProfileScreenState();
}

class _AboutProfileScreenState extends State<AboutProfileScreen> {
  var horspace = FetchPixels.getPixelHeight(10);
  TextEditingController payController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: horspace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(14)),
                    appBar(
                      context,
                      back: true,
                      onBackPress: () {
                        setState(() {
                        });
                      },
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(23)),
                    Center(
                      child: getNetworkImage(widget.photo,
          height: FetchPixels.width*0.4,
          width: FetchPixels.width*0.4),
                    ),
          getVerSpace(FetchPixels.getPixelHeight(16)),

                    Center(child: getCustomFont(widget.name, 14, Colors.black, 1,
                        fontWeight: FontWeight.w600)),

                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Center(child: getCustomFont('Add your bio here', 13,  Colors.grey , 1)),
                    getVerSpace(FetchPixels.getPixelHeight(10)),

                    Center(
                      child: RatingBar.builder(
                        initialRating: 5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        tapOnlyMode: true,
                        wrapAlignment: WrapAlignment.start,
                        itemCount: 5,
                        itemPadding: EdgeInsets.only(
                          right: FetchPixels.getPixelWidth(1),
                        ),
                        itemSize: 15,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: "#FFB500".toColor(),
                        ),
                        unratedColor: "#9B9B9B".toColor(),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [

                            Center(child: getCustomFont("102", 12, Colors.black, 1,
                                fontWeight: FontWeight.w600)),

                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Center(child: getCustomFont('Posts', 12,  Colors.grey , 1)),
                            getVerSpace(FetchPixels.getPixelHeight(10)),

                          ],
                        ),
                        Column(
                          children: [

                            Center(child: getCustomFont("6M", 12, Colors.black, 1,
                                fontWeight: FontWeight.w600)),

                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Center(child: getCustomFont('Followers', 12,  Colors.grey , 1)),
                            getVerSpace(FetchPixels.getPixelHeight(10)),

                          ],
                        ),
                        Column(
                          children: [

                            Center(child: getCustomFont("78", 12, Colors.black, 1,
                                fontWeight: FontWeight.w600)),

                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Center(child: getCustomFont('Following', 12,  Colors.grey , 1)),
                            getVerSpace(FetchPixels.getPixelHeight(10)),

                          ],
                        ),
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        getButton(context, blueColor, "Follow", Colors.white, () {    }, 16,
                            weight: FontWeight.w600,
                            borderRadius:
                            BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                            buttonWidth: FetchPixels.getWidthPercentSize(25),
                            buttonHeight: FetchPixels.getPixelHeight(40)),
                        getButton(context, Colors.white, "Message", blueColor, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_screen(widget.name,widget.photo,widget.id)));
                        }, 12,
                            weight: FontWeight.w600,
                            borderRadius:BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                            borderColor: blueColor,
                            borderWidth: 1.0,
                            isBorder: true,
                            buttonHeight: FetchPixels.getPixelHeight(40),
                            buttonWidth: FetchPixels.getWidthPercentSize(25)),
                      ],
                    ),

                    getVerSpace(FetchPixels.getPixelHeight(16)),
                    Center(
                      child: getButton(context, buttonColor, "Offer List", Colors.white, () {    }, 12,
                          weight: FontWeight.w600,
                          borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                          buttonWidth: FetchPixels.getWidthPercentSize(25),
                          buttonHeight: FetchPixels.getPixelHeight(40)),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
                    Card(elevation: 5,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(horspace)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check_circle,color: Colors.green,),
                                  getHorSpace(horspace),
                                  getCustomFont("KYC Verified",
                                      12, Colors.grey, 1,
                                      fontWeight: FontWeight.normal),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.check_circle,color: Colors.green,),
                                  getHorSpace(horspace),
                                  getCustomFont("Email Verified",
                                      12, Colors.grey, 1,
                                      fontWeight: FontWeight.normal),
                                ],
                              ),
                            ],
                          ),

                          getVerSpace(FetchPixels.getPixelHeight(16)),
                          Row(
                            children: [
                              Icon(Icons.highlight_remove_outlined,color: error,),
                              getHorSpace(horspace),
                              getCustomFont("Phone Number Not Verified",
                                  12, Colors.grey, 1,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ],
                      ),
                    ),),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
                    Card(elevation: 5,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(horspace)
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,color: Colors.amber,),
                                      getHorSpace(horspace),
                                      getCustomFont("Trade Volume - 56",
                                          10, Colors.grey, 1,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,color: Colors.amber,),
                                      getHorSpace(horspace),
                                      getCustomFont("Completed Trade -23",
                                          10, Colors.grey, 1,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            getVerSpace(horspace),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,color: Colors.amber,),
                                      getHorSpace(horspace),
                                      getCustomFont("Disputed Trade -14",
                                          10, Colors.grey, 1,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,color: Colors.amber,),
                                      getHorSpace(horspace),
                                      getCustomFont("Cancelled Trade -11",
                                          10, Colors.grey, 1,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),),
                    getVerSpace(FetchPixels.getPixelHeight(16)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomFont("Reviews", 14, Colors.black, 1,
                            fontWeight: FontWeight.w600),
                        getCustomFont("View all", 12, Colors.grey, 1,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getReviewCard()

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget appBar(BuildContext context, {back = false, onBackPress}) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(
        context,
        "back.svg",
            () {
          Navigator.pop(context);
        },
        istext: true,
        title: "About",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: back,

      ),
    );
  }

  Widget profileImageWidget() {
    return getAssetImage("profile_photo.png",
        height: FetchPixels.getPixelHeight(50),
        width: FetchPixels.getPixelHeight(50));
  }
  Widget getReviewCard(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(horspace)
      ),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
      child: getPaddingWidget(
        EdgeInsets.all(horspace),
        Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
          profileImageWidget(),
          getHorSpace(FetchPixels.getPixelWidth(10)),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont("Zubair", 18, Colors.black, 1,
                  fontWeight: FontWeight.w600),
              RatingBar.builder(
                initialRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                tapOnlyMode: true,
                wrapAlignment: WrapAlignment.start,
                itemCount: 5,
                itemPadding: EdgeInsets.only(
                  right: FetchPixels.getPixelWidth(1),
                ),
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: "#FFB500".toColor(),
                ),
                unratedColor: "#9B9B9B".toColor(),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(
                width: FetchPixels.width/1.5,
                child: getCustomFont("On the insert ta, the gakkery inckude items that are desigbed ti ciirduba with the verall look of your document",
                    18, Colors.grey, 3,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Expanded(child: SizedBox())

        ],),
      ),
    );
  }
  Widget commentScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 30,
            bottom: 10,
          ),
          child: getCustomFont(
            "All Comments",
            20,
            Colors.black,
            1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: getDefaultTextFiledWithLabel(
            context,
            "Write a Comment...",
            TextEditingController(),
            withSufix: true,
            suffiximage: "send.svg",
            onSuffixPress: () {},
            height: FetchPixels.getPixelHeight(60),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  getVerSpace(
                    20,
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget blogCard(ModelNews news, {onPress}) {
    return Container(
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          35,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        child: InkWell(
          onTap: onPress,
          child: Column(children: [
            Container(
              height: FetchPixels.getPixelHeight(220),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/${news.image}",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      FetchPixels.getPixelHeight(
                        30,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            getHorSpace(5),
                            getCustomFont(
                              news.hour,
                              16,
                              Colors.white,
                              1,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                40,
                              ),
                            ),
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(30),
                vertical: FetchPixels.getPixelHeight(15),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: getCustomFont(
                        news.name,
                        20,
                        Colors.black,
                        2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    getHorSpace(
                      20,
                    ),
                    getCustomFont(
                      news.readingTime,
                      15,
                      textColor,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                getVerSpace(
                  5,
                ),
                getCustomFont(
                  news.description,
                  15,
                  textColor,
                  4,
                  fontWeight: FontWeight.w400,
                ),
                getVerSpace(
                  20,
                ),
                Container(
                  color: textColor.withOpacity(0.5),
                  height: 1,
                ),
                getVerSpace(
                  20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: AssetImage(
                            news.author,
                          ),
                        ),
                        getHorSpace(
                          5,
                        ),
                        getCustomFont(
                          news.author,
                          16,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                          size: 20,
                        ),
                        getHorSpace(5),
                        getCustomFont(
                          news.views,
                          14,
                          textColor,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      ]),
                    ),
                  ],
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
