import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomPhoto extends StatelessWidget {
  ZoomPhoto({super.key, required this.url, required this.tag});

  String url;
  int tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      transitionOnUserGestures: true,
      child: Container(
          child: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
      )),
    );
  }
}
