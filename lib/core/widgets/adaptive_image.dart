import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdaptiveImage extends StatelessWidget {
  final String? urlOrPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AdaptiveImage({
    super.key,
    required this.urlOrPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final String? value = urlOrPath;
    final Widget child;
    if (value == null || value.isEmpty) {
      child = _placeholder();
    } else if (value.startsWith('http')) {
      child = CachedNetworkImage(
        imageUrl: value,
        width: width,
        height: height,
        fit: fit,
        placeholder: (c, _) => _placeholder(),
        errorWidget: (c, _, __) => _placeholder(),
      );
    } else if (value.startsWith('assets/')) {
      child = Image.asset(value, width: width, height: height, fit: fit);
    } else {
      child = Image.file(File(value), width: width, height: height, fit: fit);
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  Widget _placeholder() =>
      Container(width: width, height: height, color: Colors.black12);
}
