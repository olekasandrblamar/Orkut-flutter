import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../drawer/mydrawer.dart';


class Kycform extends StatefulWidget {
  const Kycform({Key? key}) : super(key: key);

  @override
  State<Kycform> createState() => KycformState();
}

class KycformState extends State<Kycform> {
  var horspace = FetchPixels.getPixelHeight(20);

  void backToPrev() {
    Constant.backToPrev(context);
  }
  String category='';
  List<String> categorylist=[];
  final title_controller=TextEditingController();
  final description_controller=TextEditingController();
  final nid_controller=TextEditingController();
  var horSpace = FetchPixels.getPixelHeight(20);
  String device_token="";
  @override
  initState(){
    super.initState();
    Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );
  }
  File path=File('');
  String message='';
  String errors='';
  String status='';
  Future<String> postdata(
    String nid,
    String nid_screenshot,
    String desc,
      ) async{
    final response=await http.MultipartRequest("POST",
        Uri.parse('https://orkt.one/api/kyc'));
    response.headers.addAll({"Authorization": "Bearer $device_token"});
    response.headers.addAll({"Accept": "application/json"});
    response.headers.addAll({"Content-type": "application/json; charset=UTF-8"});
    response.fields['nid']=nid;
    response.fields['description']=desc;
    response.files.add(await http.MultipartFile.fromPath("nid_screenshot", nid_screenshot));
    var request=await response.send();
    var responsed=await http.Response.fromStream(request);
    print(responsed.body);
    print(responsed.statusCode);

      setState(() {
        message=jsonDecode(responsed.body)['message'].toString();
        errors=jsonDecode(responsed.body)['errors'].toString();
status=jsonDecode(responsed.body)['status'].toString();
      });
      return '';
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool is_path=false;
  bool is_submit=false;
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Mydrawer(),
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
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(23)),
                    getVerSpace(FetchPixels.getPixelHeight(23)),
                   Center(
                       child: getCustomFont("KYC Form", 25, Colors.black,1)),
        getVerSpace(FetchPixels.getPixelHeight(23)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(12) ,
                          boxShadow: [
                            BoxShadow(
                              color:shadowColor,
                              blurRadius: 15,
                              spreadRadius: 18,
                            ),
                          ]
                      ),
                    child:getDefaultTextFiledWithLabel(
                      context, "ID Type", nid_controller,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60),
                    ),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
        Container(
          decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(12) ,
              boxShadow: [
                BoxShadow(
                  color:shadowColor,
                  blurRadius: 15,
                  spreadRadius: 18,
                ),
              ]
          ),
          child:
                    getDefaultTextFiledWithLabel(
                      context,is_path==false? "NID Screenshot": path.path, TextEditingController(),
                      withprefix: false,
                      withSufix: true,
                      suffiximage: "browse.svg",
                      imagefunction: () async{
                        setState(() {
                          is_path=true;
                        });
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          path=File(image!.path);
                        });
                      },
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60),
                    ),
        ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
        Container(
          decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(12) ,
              boxShadow: [
                BoxShadow(
                  color:shadowColor,
                  blurRadius: 15,
                  spreadRadius: 18,
                ),
              ]
          ),
          child:
                    getDefaultTextFiledWithLabel(
                      context, "Description", description_controller,
                      withprefix: false,
                      suffiximage: "message.svg",
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(240),
                    ),
        ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),
                    getVerSpace(FetchPixels.getPixelHeight(23)),
                    getVerSpace(FetchPixels.getPixelHeight(23)),
                    Center(
                      child: getButton(context, blueColor, is_submit==false? "Submit":"Wait", Colors.white, ()async {
                        setState(() {
                          is_submit=true;
                        });
                        await postdata(nid_controller.text,path.path,description_controller.text);
                        if(status=='success'){
                          setState(() {
                            is_submit=false;
                          });
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Icon(FontAwesomeIcons.circleCheck),
                            content: Text(message),
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                        else {
                          setState(() {
                            is_submit=false;
                          });
                          AlertDialog alert = AlertDialog(
                            title: Icon(FontAwesomeIcons.circleExclamation),
                            content:
                            Text(message+" "+errors),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                       }
                      }, 16,
                          weight: FontWeight.w600,
                          borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                          buttonWidth: FetchPixels.getWidthPercentSize(30),
                          buttonHeight: FetchPixels.getPixelHeight(50)),

                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget appBar(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        InkWell(
          onTap: () {
            backToPrev();
          },
          child: getSvgImage(
            'back.svg',
            height: FetchPixels.getPixelHeight(30),
            width: FetchPixels.getPixelHeight(30),
          ),
        ),
        SizedBox(width: FetchPixels.width*0.4),
        getAssetImage("profile_image.png",
            width: FetchPixels.getPixelHeight(30),
            height: FetchPixels.getPixelHeight(30)),

        InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
          child: getSvgImage(
            'more.svg',
            height: FetchPixels.getPixelHeight(30),
            width: FetchPixels.getPixelHeight(30),
          ),
        ),

      ],
    );}

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
