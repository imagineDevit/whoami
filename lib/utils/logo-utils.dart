
import 'package:henri_sedjame/misc/logo-properties.dart';
import 'package:henri_sedjame/utils/screen-utils.dart';

class LogoUtils {

  static double logoSize(double size, double width){
    if (ScreenUtils.isSmall(width)) {
      return size > 250 ? size * (2/5) : size;
    } else if (ScreenUtils.isMedium(width)) {
      return size * (5/8);
    } else {
      return size;
    }
  }


  static double? logoLeftPosition(double? pos, double width){
    if(pos == null) return null;
    if (ScreenUtils.isSmall(width)) {
      return null ;
    } else if (ScreenUtils.isMedium(width)) {
      return pos * (15/16);
    } else {
      return pos;
    }
  }

  static double getWidth(double height) {
    return height * originalLogoWidth / originalLogoHeight;
  }

  static double getHeight(double width) {
    return width * originalLogoHeight / originalLogoWidth;
  }
}