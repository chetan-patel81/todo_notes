//less use in this App due to flexible & expanded widget use 
import 'package:flutter/cupertino.dart';

class MediaQueryService {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late bool isPortrait;
  static late bool isMobilePortrait;

  void initialize(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;

    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isMobilePortrait = isPortrait && screenWidth < 600;
  }
}
