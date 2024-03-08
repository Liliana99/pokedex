import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/device_utils.dart';

class ViewDimensions {
  final double maxWidth;
  final double maxWidthLogo;
  final double maxHeight;

  ViewDimensions(this.maxWidth, this.maxWidthLogo, this.maxHeight);
}

ViewDimensions calculateDimensions(BuildContext context, Size size) {
  final maxWidth = DeviceUtils.isDesktop(context)
      ? size.width * 0.20
      : DeviceUtils.isLargeTablet(context)
          ? size.width * 0.40
          : size.width * 0.50;

  final maxWidthLogo = DeviceUtils.isDesktop(context)
      ? size.width * 0.20
      : DeviceUtils.isLargeTablet(context)
          ? size.width * 0.30
          : size.width * 0.95;

  final maxHeight = DeviceUtils.isDesktop(context)
      ? size.height * 0.1
      : DeviceUtils.isLargeTablet(context)
          ? size.height / 8
          : size.height / 14;

  return ViewDimensions(maxWidth, maxWidthLogo, maxHeight);
}
