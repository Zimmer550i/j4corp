import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? width;
  final double? size;
  final double? height;
  const CustomSvg({
    super.key,
    required this.asset,
    this.color,
    this.size,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return asset.contains(".svg")
        ? SvgPicture.asset(
          asset,
          height: size ?? height,
          width: size ?? width,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        )
        : CachedNetworkImage(
          imageUrl: asset,
          height: size ?? height,
          width: size ?? width,
        );
  }
}
