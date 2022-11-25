import 'dart:ui';

// Color backGroundColor = "#F9FAFC".toColor();
// Color blueColor = "#23408F".toColor();
// Color intro1Color = "#FFC8CF".toColor();
// Color intro2Color = "#E5ECFF".toColor();
// Color intro3Color = "#F7FBCD".toColor();
// Color dividerColor = "#E5E8F1".toColor();
Color textColor = "#6E768A".toColor();
Color blueColor = "#2B66FF".toColor();
Color intro1 = "#ECF4FF".toColor();
Color intro2 = "#FFF4EC".toColor();
Color intro3 = "#F7ECFF".toColor();
Color shadowColor = blueColor.withOpacity(0.10);
Color skipColor = "#6E768A".toColor();
Color borderColor = "#BEC4CD".toColor();
Color containerShadow = "#E0E9F5".toColor();
Color subtextColor = "#6E768A".toColor();
Color errorColor = "#DD3333".toColor();
Color successColor = "#04B155".toColor();
Color orangeColor = "#F56D40".toColor();
Color deviderColor = "#DEE0E6".toColor();
Color buttonColor = '#FFB500'.toColor();
// Color buttonColor = '#F0F5FF'.toColor();
Color paymentBg = "#F2F3F8".toColor();
Color success = "#009C49".toColor();
Color error = "#DD3333".toColor();
Color priceColor = "#F1F5FF".toColor();
Color bgColor = "#E3F3FF".toColor();
Color errorbg = "#F9E7E7".toColor();
Color successBg = '#E7F9EF'.toColor();
// Color deatilColor = "#D3DFFF".toColor();
// Color listColor = "#EEF1F9".toColor();
// Color procced = "#E2EAFF".toColor();
// Color success = "#04B155".toColor();
// Color completed = "#0085FF".toColor();
// Color error = "#FF2323".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
