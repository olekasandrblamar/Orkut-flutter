import 'dart:io';

import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_ticket.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../base/pref_data.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  var horspace = FetchPixels.getPixelHeight(20);

  // List<ModelTicket> ticketList = DataFile.ticketList;

  void backToPrev() {
    Constant.backToPrev(context);
  }

  List<ModelTicket> datalist = [];
  String device_token = "";

  @override
  void initState() {
    super.initState();
    Future<String> _futuretoken = PrefData.getToken();

    _futuretoken.then((value) async {
      setState(() {
        device_token = value;
      });
    },
    );
  }

  Stream<List<ModelTicket>> fetchdata() async* {
    final response = await http.get(
        Uri.parse('https://orkt.one/api/my/tickets'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + device_token,
        }
    );

    if (response.statusCode == 200) {
      List<ModelTicket> ticket_response = ticketfromjson(response.body);
      yield ticket_response;
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(18)),
                appBar(
                  context,
                ),
                getVerSpace(
                  FetchPixels.getPixelHeight(30),
                ),
                getCustomFont(
                  "Tickets",
                  18,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w600,
                ),
                getVerSpace(FetchPixels.getPixelHeight(23)),
                streamBuilder(),
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    getButton(
                      context,
                      blueColor,
                      "+ Create Ticket",
                      Colors.white,
                          () {
                        Constant.sendToNext(
                          context,
                          Routes.supportTicketRoute,
                        );
                      },
                      18,
                      weight: FontWeight.w600,
                      buttonWidth: FetchPixels.getPixelHeight(220),
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded ticketsList(List<ModelTicket> ticketList) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ticketList.length,
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
                  child: tradeRequestCard(
                    ticketList[index],
                    onPress: () {

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

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(
        context,
        "back.svg",
        backToPrev,
        istext: true,
        title: "Support Tickets",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: true,

      ),
    );
  }

  Widget tradeRequestCard(ModelTicket ticket, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor,  blurRadius: 15,
              spreadRadius: 20, offset: const Offset(0, 7))
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(
              ticket.code,
              20,
              Colors.black,
              1,
              fontWeight: FontWeight.w600,
            ),
            getCustomFont(
              ticket.subject,
              12,
              textColor,
              1,
            ),
            getCustomFont(
              ticket.date,
              10,
              textColor,
              1,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            getCustomFont(
              "Type Message",
              20,
              Colors.redAccent,
              1,
              fontWeight: FontWeight.w600,
            ),
          ],
        )
      ]),
    );
  }

  StreamBuilder streamBuilder() {
    return StreamBuilder<List<ModelTicket>>(
        stream: fetchdata(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('Error!');
          } else {
            return ticketsList(snapshot.data!);
          }
        }
    );
  }
}
