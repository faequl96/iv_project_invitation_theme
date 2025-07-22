import 'package:flutter/widgets.dart';
import 'package:iv_project_invitation_theme/src/enums/enums.dart';

class ScreenUtil {
  ScreenUtil._();

  static late Size size;
  static late H h;
  static late W w;

  static void set(Size value) {
    size = value;

    if (size.height <= 620) {
      h = H.Xs;
    } else if (size.height > 620 && size.height <= 660) {
      h = H.Sm;
    } else if (size.height > 660 && size.height <= 720) {
      h = H.Md;
    } else if (size.height > 720 && size.height <= 800) {
      h = H.Lg;
    } else if (size.height > 800) {
      h = H.Xl;
    }

    if (size.width <= 340) {
      w = W.Xs;
    } else if (size.width > 348 && size.width <= 360) {
      w = W.Sm;
    } else if (size.width > 360 && size.width <= 376) {
      w = W.Md;
    } else if (size.width > 376 && size.width <= 396) {
      w = W.Lg;
    } else if (size.width > 396) {
      w = W.Xl;
    }
  }
}
