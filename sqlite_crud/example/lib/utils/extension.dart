import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  Size get mediaQueryData  => MediaQuery.sizeOf(this);
  double get screenHeight => mediaQueryData.height;
  double get screenWidth => mediaQueryData.width;
  // remove appbar default  height
  double get availableHeight => screenHeight - kToolbarHeight;
}