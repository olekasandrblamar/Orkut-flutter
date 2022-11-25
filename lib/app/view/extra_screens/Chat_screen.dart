import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:orkut/base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
class Chat_screen extends StatefulWidget {
 final String name;
 final String photo;
 final String id;
 Chat_screen(this.name,this.photo,this.id);
  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }
  bool is_send=false;
  final chat_controller=TextEditingController();
  String device_token="";
  String name='';
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

  Future<String> postdata(
      String id,
      String message,
      String file,
      ) async{
    final response=await http.MultipartRequest("POST",
        Uri.parse('https://orkt.one/api/trade/submit-chat'));
    response.headers.addAll({"Authorization": "Bearer $device_token"});
    response.headers.addAll({"Accept": "application/json"});
    response.headers.addAll({"Content-type": "application/json; charset=UTF-8"});
    response.fields['trade_id']=id;
    response.fields['message']=message;
  //  response.files.add(await http.MultipartFile.fromPath("file", file));
    var request=await response.send();
    var responsed=await http.Response.fromStream(request);
    if (responsed.statusCode == 200) {
      fetchdata(id);
     return '';
    }
    else {
      throw Exception('Failed to send  data');
    }
  }

  Future<List<String>> fetchdata(String id) async{
    final response=await http.get(Uri.parse('https://orkt.one/api/trade/$id/chat'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token,
        }
    );
    if(response.statusCode==200){
      List<String> messages=[];
      Iterable l = json.decode(response.body)['chat'];
      for(int i=0; i<=l.length-1; i++){
        setState(() {
          messages.add(json.decode(response.body)['chat'][i]['message'].toString());
        });
      }
      return messages;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              getVerSpace(FetchPixels.getPixelHeight(14)),
      appBar(context),
      getVerSpace(FetchPixels.getPixelHeight(35)),
                Row(
                  children: [
                    SizedBox(width: 70,),
                    CircleAvatar(backgroundImage:NetworkImage('https://orkt.one/assets/images/'+widget.photo),radius: 30,),
                    SizedBox(width: 70,),
                    getCustomFont("Asheer", 18, Colors.black, 1),
                  ],
                ),
        getPaddingWidget(EdgeInsets.all(15),
        Row(
          children: [
            Container(
              height: FetchPixels.getPixelHeight(550),
              width: FetchPixels.getPixelWidth(200),
              child: FutureBuilder<List<String>>(
                  future: fetchdata(widget.id),
                  builder: (context,snapshot){
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    if (snapshot.hasError) {
                      return const Text('Error!');
                    } else {

                      return   ListView.builder(
                        itemBuilder: (context, index) {
                          return getPaddingWidget(
                            EdgeInsets.all(15),
                            Container(
                              height: FetchPixels.getPixelHeight(60),

                              decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index]),
                                  Text(name),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        reverse: true,
                      );
                    }
                  }
              ),
            ),
          ],
        ),
        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    getPaddingWidget(EdgeInsets.all(20),
                    SizedBox(
                      width: 320,
                      child: getDefaultTextFiledWithLabel(
                        context, "Type your message",chat_controller,
                        withprefix: false,
                        image: "message.svg",
                        isEnable: false,
                        height: FetchPixels.getPixelHeight(60),
                      ),
                    ),
                    ),
                    IconButton(onPressed: ()async{
                      name = await PrefData.getFirstName();
                     postdata(widget.id, chat_controller.text, '');
                     fetchdata(widget.id);
                    }, icon:Icon(FontAwesomeIcons.solidPaperPlane)
                    ),
                  ],
                ),
      ],
    ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(

            width: 320,
            height: 40,
            child:
            gettoolbarMenu(
              context,
              "back.svg",
                  () {
                backToPrev();
              },
              istext: true,
              title: "Chat",
              fontsize: 24,
              weight: FontWeight.w700,
              textColor: Colors.black,
              isleftimage: true,
            ),
          ),
        ],
      ),
    );
  }

}
