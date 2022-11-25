import 'dart:convert';
import 'dart:io';

import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/blogdetails.dart';
import 'package:orkut/app/models/categories_id_model.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/app/view/create_timeline_screen.dart';

import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../base/pref_data.dart';
class TabTimeline extends StatefulWidget {
  const TabTimeline({Key? key}) : super(key: key);

  @override
  State<TabTimeline> createState() => _TabTimelineState();
}
class _TabTimelineState extends State<TabTimeline> {
  var horspace = FetchPixels.getPixelHeight(20);

  List<String> categoryLists = DataFile.timelineCategoryList;
  int select = 0;
  ModelNews? selectedNews;
  Future<String>? _futurecomment;
final comment_controller=TextEditingController();
  String device_token="";
String blogid='';

@override
void initState(){
  super.initState();
  fetchdata().listen((event) { });
  Future<String> _futuretoken=PrefData.getToken();
   _futuretoken.then((value)async {
    setState(() {
      device_token=value;
    });
  },
  );
}
  List<dynamic> comments=[];
  Stream<List<ModelNews>> fetchdata() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/blogs'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
        }
    );
    if(response.statusCode==200){
      List<ModelNews> blog_response=blogfromjson(response.body);
     yield blog_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }

  }

Future<void> fetch_blog_details(String blog_id)async{
  final blog_details_response=await http.get(Uri.parse('https://orkt.one/api/blog-details/'+blog_id),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
      }
  );
  if(blog_details_response.statusCode==200){
          List<dynamic> comments_response=jsonDecode(blog_details_response.body)['blog']['comments'];
         setState(() {
           comments=comments_response;
         });
  }
  else{
    throw Exception('Failed to fetch data');
  }
}
  Future<String> post_comment(String comment,String id)async {
    print(comment+id);
    final comment_response = await http.post(Uri.parse('https://orkt.one/api/comment'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer '+device_token,
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, dynamic>{
         'comment':comment,
          'blog_id':id,
        })
    );
    print(comment_response.statusCode);
    print(comment_response.body);
    if (comment_response.statusCode == 200) {
      return '';
    }
    else {
      throw Exception('Failed to comment');
    }
  }
  Future<String> like(String id)async {
    final comment_response = await http.post(Uri.parse('https://orkt.one/api/like'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer '+device_token,
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, dynamic>{
          'blog_id':id
        }
        )
    );
    print(comment_response.statusCode);
    print(comment_response.body);
    if (comment_response.statusCode == 200) {
      fetchdata().listen((event) { });
      return '';
    }
    else {
      throw Exception('Failed to like');
    }
  }
  bool is_like=false;
  bool is_like_comment=false;
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            getVerSpace(FetchPixels.getPixelHeight(14)),
            appBar(
              context,
              back: selectedNews != null,
              onBackPress: () {
                setState(() {
                  selectedNews = null;
                });
              },
            ),
            getVerSpace(FetchPixels.getPixelHeight(23)),
    selectedNews==null?
        StreamBuilder<List<ModelNews>>(
            stream: fetchdata(),
            builder: (context,snapshot){
              if (!snapshot.hasData) {
                return const Center(child:CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Text('Error!');
              } else {
              return  blogList(snapshot.data!);
          }
        }
        )
            :
        blogPage(context),
          ],
        ),
        if (selectedNews != null) Container() else floatingActionButton(),
      ],
    );
  }

  Expanded blogPage(BuildContext context) {
fetch_blog_details(selectedNews!.id);
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 2),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double position, child) {
          return Opacity(
            opacity: position,
            child: child,
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  "Trending",
                  20,
                  successColor,
                  1,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
                getVerSpace(
                  10,
                ),
                getCustomFont(
                  selectedNews!.name,
                  25,
                  Colors.black,
                  2,
                  fontWeight: FontWeight.w600,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Container(
                  height: FetchPixels.getPixelHeight(250),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://orkt.one/assets/images/'+selectedNews!.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 30,
                          color: textColor,
                        ),
                        getHorSpace(5),
                        getCustomFont(
                          selectedNews!.hour,
                          16,
                          textColor,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    getCustomFont(
                      selectedNews!.readingTime,
                      15,
                      textColor,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Container(
                  color: textColor.withOpacity(0.5),
                  height: 1,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(
                            'https://orkt.one/assets/images/'+selectedNews!.image,
                          ),
                        ),
                        getHorSpace(
                          5,
                        ),
                        getCustomFont(
                          selectedNews!.author,
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
                          selectedNews!.views,
                          14,
                          textColor,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      ]),
                    ),
                  ],
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                getCustomFont(
                  selectedNews!.description,
                  12,
                  textColor,
                  20,
                  fontWeight: FontWeight.w400,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Container(
                  color: textColor.withOpacity(0.5),
                  height: 1,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                         IconButton(onPressed: (){
                           setState(() {
                             if(is_like==false){
                               is_like=true;
                             }
                             else if(is_like==true){
                               is_like=false;
                             }
                           });
                           like(selectedNews!.id);

                         }, icon: Icon(Icons.favorite_outline_sharp,
                         color: is_like==true?Colors.red:Colors.transparent,
                         )),
                          getHorSpace(5),
                          getCustomFont(
                            selectedNews!.likes,
                            13,
                            textColor,
                            1,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          openCommentModal(height,selectedNews!.id.toString());
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 20,
                              color: textColor,
                            ),
                            getHorSpace(5),
                            getCustomFont(
                              "325",
                              13,
                              textColor,
                              1,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.share,
                      size: 30,
                      color: textColor,
                    ),
                  ],
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(20),
                ),
                Container(
                  color: textColor.withOpacity(0.5),
                  height: 1,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(30),
                ),
                TextButton(
                  onPressed: () {
                    openCommentModal(height,selectedNews!.id.toString());
                  },
                  child: getCustomFont(
                    "View all comments",
                    15,
                    successColor,
                    1,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(10),
                ),
                commentCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openCommentModal(height,String id) {
    print("comment modal id is: $id");
    showModalBottomSheet<void>(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: height * 0.85,
          child: commentScreen(id),
        );
      },
    );
  }

  Widget commentCard() {
    return Container(
        height: 200,
        child:ListView.builder(
          reverse: true,
      itemCount: comments.length,
      itemBuilder: (BuildContext context,index){
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    'https://orkt.one/assets/images/'+selectedNews!.image,
                  ),
                ),
                getHorSpace(
                  10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont(
                            selectedNews!.author,
                            14,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w600,
                          ),
                           IconButton(
                            onPressed: (){
                            setState(() {
                                if(is_like_comment==false){
                                is_like_comment=true;
                                }
                                else if(is_like_comment==true){
                                is_like_comment=false;
                                }
                            });
                          },
                            icon: Icon(
                            Icons.favorite,
                            color: is_like_comment==true?Colors.red:Colors.transparent,
                            size: 20,
                          ),
                          ),
                        ],
                      ),
                      getVerSpace(
                        FetchPixels.getPixelHeight(5),
                      ),
                      getCustomFont(
                         comments[index]['comment'],
                        12,
                        textColor,
                        2,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            getVerSpace(
              FetchPixels.getPixelHeight(30),
            ),
          ],
        );
    },
    ),
    );
  }

  SizedBox blogList(List<ModelNews> newsLists) {
    return SizedBox(
      height: FetchPixels.getPixelHeight(640),
      child: Column(
        children: [
          categoryList(),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          Expanded(
            child: ListView.builder(
              itemCount: newsLists.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (BuildContext context, double position, child) {
                    return Transform.scale(
                      scale: position,
                      child: child,
                    );
                  },
                  child: blogCard(
                    newsLists[index],
                    onPress: () {
                      setState(() {
                        selectedNews = newsLists[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox categoryList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(44),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categoryLists.length,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              GestureDetector(
                child: Container(
                  decoration: select == index
                      ? BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ],
                          border: Border(
                            bottom: BorderSide(
                              color: blueColor,
                              width: 2,
                            ),
                          ),
                        )
                      : null,
                  padding: EdgeInsets.symmetric(
                    vertical: FetchPixels.getPixelHeight(5),
                    horizontal: FetchPixels.getPixelHeight(0),
                  ),
                  margin: EdgeInsets.only(
                      right: FetchPixels.getPixelHeight(37),
                      left: index == 0 ? horspace : 0),
                  child: getCustomFont(
                    categoryLists[index],
                    18,
                    select == index ? blueColor : textColor,
                    1,
                    fontWeight:
                        select == index ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                onTap: () {
                  setState(() {
                    select = index;
                  });
                },
              )
            ],
          );
        },
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
          onBackPress();
        },
        istext: true,
        title: "Timeline",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: back,
        isrightimage: false,
      ),
    );
  }

  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTimelineScreen()));
        },
        style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => blueColor),
          shape:MaterialStateProperty.resolveWith((states) => CircleBorder(),),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(
            FetchPixels.getPixelWidth(15),)
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget commentScreen(String id) {
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
          child:
          Row(
    children:[
      SizedBox(
        width: 300,
           child: getDefaultTextFiledWithLabel(
            context, "Post comment",comment_controller,
            withprefix: false,
            image: "message.svg",
            isEnable: false,
            height: FetchPixels.getPixelHeight(60),
          ),
      ),
          IconButton(onPressed: (){;
            post_comment(comment_controller.text, id);
            fetch_blog_details(id);
            Navigator.pop(context);
          }, icon:Icon(Icons.send)

          ),
    ],
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
                  commentCard(),
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
                  image:NetworkImage(
                    'https://orkt.one/assets/images/'+news.image,
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
                        15,
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
                  12,
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
                          // foregroundImage: AssetImage(
                          //   news.author,
                          // ),
                        ),
                        getHorSpace(
                          5,
                        ),
                        getCustomFont(
                          news.author,
                          12,
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