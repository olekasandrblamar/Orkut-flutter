import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_chartdata.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  var horspace = FetchPixels.getPixelHeight(20);
  List<ChartData> chartLists = DataFile.chartData;
  dynamic index;

  String? name;
  String? image;
  String? currency;
  double? price;
  String? profit;

  Future<void> getData() async {
    name = await PrefData.getTrendName();
    image = await PrefData.getTrendImage();
    currency = await PrefData.getTrendCurrency();
    price = await PrefData.getTrendPrice();
    profit = await PrefData.getTrendProfit();
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horspace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                         if (image!=null ) Image.network(
                            image!  ,
                            width: FetchPixels.getPixelHeight(50),
                            height: FetchPixels.getPixelHeight(50),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(14)),
                          getCustomFont("\$${price?.toStringAsFixed(3)}", 24,
                              Colors.black, 1,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE7F9EF),
                                        borderRadius: BorderRadius.circular(
                                            FetchPixels.getPixelHeight(21))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            FetchPixels.getPixelHeight(6),
                                        vertical:
                                            FetchPixels.getPixelHeight(1)),
                                    child: Row(
                                      children: [
                                        getSvgImage("down.svg"),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(4)),
                                        getCustomFont(
                                            profit ?? "", 13, successColor, 1,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              getHorSpace(FetchPixels.getPixelHeight(10)),
                              getCustomFont(currency ?? '', 15, subtextColor, 1,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(14)),
                          getCustomFont(
                              dateFormat.format(DateTime.now()).toString(),
                              15,
                              subtextColor,
                              1,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          Container(
                            padding: EdgeInsets.only(
                                left: FetchPixels.getPixelHeight(20),
                                right: FetchPixels.getPixelHeight(20)),
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
                            child: Column(
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(50)),
                                chartWidget(),
                                getVerSpace(FetchPixels.getPixelHeight(50)),
                                buyAndSellButton(context),
                                getVerSpace(FetchPixels.getPixelHeight(20)),
                              ],
                            ),
                          )
                        ],
                      ))
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

  Row buyAndSellButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: getButton(context, Colors.black, "Buy", Colors.white, () {
          Constant.sendToNext(context, Routes.exchangeRoute);
        }, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60))),
        getHorSpace(horspace),
        Expanded(
            child: getButton(
                context, blueColor, "Sell", Colors.white, () {}, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)))
      ],
    );
  }

  SizedBox chartWidget() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(242),
      child: LineChart(LineChartData(
        clipData: FlClipData.all(),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: leftTitleWidgets,
              showTitles: true,
              reservedSize: 28,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(0.8, 3.6),
              const FlSpot(2.3, 2.8),
              const FlSpot(4, 5),
              const FlSpot(6.1, 3.7),
              const FlSpot(7.9, 4.5),
              const FlSpot(9.3, 3),
              const FlSpot(11, 3.5)
            ],
            isCurved: true,
            color: blueColor,
            barWidth: FetchPixels.getPixelHeight(2),
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF64ABFF).withOpacity(0.13),
                      const Color(0xFF3397F2).withOpacity(0)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated)),
          ),
          LineChartBarData(
            spots: [
              const FlSpot(0, 4.5),
              const FlSpot(1.5, 3.8),
              const FlSpot(2.8, 4.8),
              const FlSpot(4.3, 3.3),
              const FlSpot(6.4, 4.1),
              const FlSpot(8, 2.8),
              const FlSpot(9, 4),
              const FlSpot(9.7, 4.5),
              const FlSpot(11, 4)
            ],
            isCurved: true,
            color: orangeColor,
            barWidth: FetchPixels.getPixelHeight(2),
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              color: Colors.white,
              show: false,
            ),
          ),
        ],
      )),
    );
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      backToPrev();
    },
        istext: true,
        title: name ?? "European Union",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1d';
        break;
      case 2:
        text = '5d';
        break;
      case 4:
        text = '1m';
        break;
      case 6:
        text = '6m';
        break;
      case 8:
        text = '1y';
        break;
      case 10:
        text = '5y';
        break;
      default:
        return Container();
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          index = value;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(13),
        ),
        decoration: index == value
            ? BoxDecoration(
                color: const Color(0xFFF3F8FF),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(6)))
            : null,
        child: Text(
          text,
          style: TextStyle(
              color: value == index ? blueColor : subtextColor,
              fontWeight: value == index ? FontWeight.w600 : FontWeight.w400,
              fontSize: 15,
              fontFamily: Constant.fontsFamily),
          textScaleFactor: FetchPixels.getTextScale(),
        ),
      ),
    );
  }
}
