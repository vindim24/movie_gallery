import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviesCacheImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String _baseImageUrl = "https://image.tmdb.org/t/p/w500";

  MoviesCacheImageWidget({super.key, required this.width, required this.height, required this.imageUrl});

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _baseImageUrl  + imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return _imageWidget(AssetImage('assets/images/no_image.png'));
      },
    );
  }
}
