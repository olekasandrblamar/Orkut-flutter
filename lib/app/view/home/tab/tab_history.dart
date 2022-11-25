import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_history.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class TabHistory extends StatefulWidget {
  const TabHistory({Key? key}) : super(key: key);

  @override
  State<TabHistory> createState() => _TabHistoryState();
}

class _TabHistoryState extends State<TabHistory> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<ModelHistory> histories = DataFile.historyList;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Stack(
      // alignment: Alignment.bottomRight,
      children: [
        Container(
          height: FetchPixels.getPixelHeight(300),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 23,
                offset: const Offset(0, 10),
              ),
            ],
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 75, 145),
                Color.fromARGB(255, 13, 108, 203),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getVerSpace(
              FetchPixels.getPixelHeight(40),
            ),
            getCustomFont(
              "Deposit History",
              28,
              Colors.white,
              2,
              fontWeight: FontWeight.w500,
            ),
            getVerSpace(
              FetchPixels.getPixelHeight(40),
            ),
            getCustomFont(
              "Total Amount",
              18,
              const Color.fromARGB(255, 214, 212, 212),
              2,
              fontWeight: FontWeight.w500,
            ),
            getVerSpace(
              FetchPixels.getPixelHeight(2),
            ),
            getCustomFont(
              "\$ 7392.00",
              40,
              const Color.fromARGB(255, 255, 202, 40),
              2,
              fontWeight: FontWeight.w500,
            ),
            getVerSpace(
              FetchPixels.getPixelHeight(30),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: histories.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => historyCard(
                  histories[index],
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget historyCard(ModelHistory history, {onPress}) {
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
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCustomFont(
              "Wed",
              18,
              Colors.black,
              1,
              fontWeight: FontWeight.w500,
            ),
            getCustomFont(
              "15",
              17,
              Colors.black,
              1,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        getHorSpace(
          FetchPixels.getPixelWidth(20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(
              "TNX ID",
              18,
              Colors.black,
              1,
              fontWeight: FontWeight.w500,
            ),
            getCustomFont(
              "Charge",
              16,
              textColor,
              1,
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            getCustomFont(
              "${history.price}",
              18,
              Colors.black,
              1,
              fontWeight: FontWeight.w600,
            ),
            getCustomFont(
              "Coinpayment TNX",
              16,
              textColor,
              1,
            ),
          ],
        )
      ]),
    );
  }
}
