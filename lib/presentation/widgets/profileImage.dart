import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imageUrl;
  final String? errorImageUrl;
  const ProfileImage({Key? key, this.width, required this.imageUrl, this.height, this.errorImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl ?? "",
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorWidget: (context, url, error) => Icon(Icons.person_outline, size: width,),
    );
  }
}
