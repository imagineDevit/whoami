
class ScreenUtils {

  static const double mediumScreenSize = 1200.0;
  static const double smallScreenSize = 700.0;

  static bool isLarge(double width) {
    return !ScreenUtils.isMedium(width) && !ScreenUtils.isSmall(width);
  }

  static bool isMedium(double width) {

    return mediumScreenSize >= width &&
    smallScreenSize < width;
  }

  static bool isSmall(double width) {
    return smallScreenSize >= width;
  }
}