import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
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
import '../../base/constant.dart';
import '../../base/emoji_utils.dart';
import '../../base/pref_data.dart';
import '../models/categories_id_model.dart';
import '../models/model_portfolio.dart';

class CreateTimelineScreen extends StatefulWidget {
  const CreateTimelineScreen({Key? key}) : super(key: key);

  @override
  State<CreateTimelineScreen> createState() => Create_TimelineScreenState();
}

class Create_TimelineScreenState extends State<CreateTimelineScreen> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  void backToPrev() {
    Constant.backToPrev(context);
  }
  String category='';
  int category_id=0;
  List<String> categorylist=[];
  List<int> categorylist_id=[];
  final title_controller=TextEditingController();
  final description_controller=TextEditingController();
  final cat_controller=TextEditingController();
  var horSpace = FetchPixels.getPixelHeight(20);

  @override
  initState(){
fetchCategories();
    super.initState();
  }

String message='';
  String errors='';
  String status='';
  File path=File('');
  Future<String> postdata(
      String id,
      String title,
      String desc,
      String path,
      ) async{
    Future<String> _futuretoken=PrefData.getToken();
    String device_token="";
    await  _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );
    final response=await http.MultipartRequest("POST",
      Uri.parse('https://orkt.one/api/create/blog'));
     response.headers.addAll({"Authorization": "Bearer $device_token"});
    response.headers.addAll({"Accept": "application/json"});
    response.headers.addAll({"Content-type": "application/json; charset=UTF-8"});
    response.fields['title']=title;
    response.fields['category_id']=id;
    response.fields['description']=desc;
    response.files.add(await http.MultipartFile.fromPath("photo", path));
    var request=await response.send();
    var responsed=await http.Response.fromStream(request);
    print(responsed.body);
    print(responsed.statusCode);
        setState(() {
          message=jsonDecode(responsed.body)['message'].toString();
          errors=jsonDecode(responsed.body)['errors'].toString();
          status=jsonDecode(responsed.body)['status'].toString();
        });
       return "";
  }
  Future<List<Modelcatid>> fetchCategories() async{
    String device_token='';
    Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
      final response=await http.get(Uri.parse('https://orkt.one/api/get/categories'),
          headers: {
            HttpHeaders.acceptHeader:'application/json',
            HttpHeaders.authorizationHeader: 'Bearer '+device_token,
          }
      );
      if(response.statusCode==200){
        List<Modelcatid> catid_response=catidfromjson(response.body);
        setState(() {
          for(int i=0; i<=catid_response.length-1; i++){
            categorylist.add(catid_response[i].name);
            categorylist_id.add(catid_response[i].id);
          }

        });
        return catid_response;
      }
      else{
        throw Exception('Failed to fetch data');
      }

    });
    throw Exception('Failed to fetch data');

  }

bool is_submit=false;
bool is_path=false;

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
                    ),
                    // FutureBuilder<List<Modelcatid>>(
                    //     future: fetchCategories(),
                    //     builder: (context,snapshot){
                    //       if (!snapshot.hasData) {
                    //         return Text("");
                    //       }
                    //       if (snapshot.hasError) {
                    //         return const Text('Error!');
                    //       } else {
                    //         return  Text("");
                    //       }
                    //     }
                    // ),
                  Center(child:  getCustomFont("Create Timeline", 25, Colors.black,1)),

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
          child:
          SizedBox(
            height: FetchPixels.getPixelHeight(56),
            child: DropdownButtonFormField(
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.white,
              hint: getCustomFont(
                  "Select Category id", 15, textColor, 1,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: FetchPixels.getPixelHeight(16)),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Container(
                    padding: EdgeInsets.all(
                        FetchPixels.getPixelHeight(16)),
                    child: getSvgImage("arrow_bottom.svg",
                        width: FetchPixels.getPixelHeight(24),
                        height: FetchPixels.getPixelHeight(24)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        FetchPixels.getPixelHeight(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          FetchPixels.getPixelHeight(12)),
                      borderSide: BorderSide(
                          color: borderColor,
                          width:
                          FetchPixels.getPixelHeight(1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          FetchPixels.getPixelHeight(12)),
                      borderSide: BorderSide(
                          color: borderColor,
                          width:
                          FetchPixels.getPixelHeight(1))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          FetchPixels.getPixelHeight(12)),
                      borderSide: BorderSide(
                          color: borderColor,
                          width: FetchPixels.getPixelHeight(1)))),
              items: categorylist.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      getHorSpace(
                          FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                          e ?? '', 16, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
                if(category==categorylist[0]){
                  setState(() {
                    category_id=categorylist_id[0];
                  });
                }
                else  if(category==categorylist[1]){
                  setState(() {
                    category_id=categorylist_id[1];
                  });
                }
                else  if(category==categorylist[2]){
                  setState(() {
                    category_id=categorylist_id[2];
                  });
                }
              },
            ),
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
                        context, "Title", title_controller,
                        withprefix: false,
                        suffiximage: "message.svg",
                        image: "message.svg",
                        isEnable: false,
                        height: FetchPixels.getPixelHeight(60),
                         ),
        ),
                    getVerSpace(FetchPixels.getPixelHeight(16)),

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
                        context, "Start Writing", description_controller,
                        withprefix: false,
                        suffiximage: "message.svg",
                        image: "message.svg",
                        isEnable: false,
                        height: FetchPixels.getPixelHeight(240),
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
                        context, is_path==false? "Add Photo": path.path, TextEditingController(),
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
                     getVerSpace(FetchPixels.getPixelHeight(60)),

                    Center(
                      child: getButton(context, blueColor, is_submit==false?"Submit":"Wait", Colors.white, () async{
                        setState(() {
                          is_submit=true;
                        });
                       await postdata(category_id.toString(),title_controller.text,description_controller.text,path.path);
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
                  10,
                  textColor,
                  8,
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
