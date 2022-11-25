import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class StatementDialog extends StatefulWidget {
  const StatementDialog({Key? key}) : super(key: key);

  @override
  State<StatementDialog> createState() => _StatementDialogState();
}

class _StatementDialogState extends State<StatementDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding:
          EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(16))),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  // ignore: use_full_hex_values_for_flutter_colors
                  color: Color(0xff26566c9e),
                  blurRadius: 40,
                  offset: Offset(-5, 6))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: getSvgImage("close.svg"),
                  onTap: () {
                    Constant.backToPrev(context);
                  },
                )),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getSvgImage("check.svg"),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getCustomFont('\$56', 34, Colors.black, 1,
                fontWeight: FontWeight.w400),
            getVerSpace(FetchPixels.getPixelHeight(4)),
            getCustomFont("INITIATED", 18, Colors.black, 1,
                fontWeight: FontWeight.w500),
            getVerSpace(FetchPixels.getPixelHeight(4)),
            getCustomFont("16 luly,2022 20:54:14", 16, skipColor, 1,
                fontWeight: FontWeight.w400),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Container(
              height: FetchPixels.getPixelHeight(61),
              decoration: BoxDecoration(
                  color: paymentBg,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(16))),
              alignment: Alignment.center,
              child: getCustomFont(
                  '12as1235-advds-addf-1452-fdfffa', 16, Colors.black, 1,
                  fontWeight: FontWeight.w400),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getCustomFont("Tap to copy reference ID", 16, skipColor, 1,
                fontWeight: FontWeight.w400),
            getVerSpace(FetchPixels.getPixelHeight(40))
          ],
        ),
      ),
    );
  }
}
