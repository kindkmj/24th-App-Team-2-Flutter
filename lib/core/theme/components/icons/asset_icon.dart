import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../foundations/app_theme.dart';

class AssetIcon extends StatelessWidget {
  const AssetIcon(
    this.icon, {
    super.key,
    this.color,
    this.size,
    this.width,
    this.height,
    this.useIconColor = false,
  });

  final String icon;
  final Color? color;
  final double? size;
  final double? width;
  final double? height;
  final bool useIconColor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: width ?? size,
      height: height ?? size,
      colorFilter: useIconColor
          ? null
          : ColorFilter.mode(
              color ?? context.color.text,
              BlendMode.srcIn,
            ),
    );
  }
}
