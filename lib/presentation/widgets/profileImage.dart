import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imageUrl;
  final String? errorImageUrl;
  const ProfileImage({Key? key, this.width, required this.imageUrl, this.height, this.errorImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return ClipRRect(
      borderRadius: BorderRadius.circular((width?? 0)/2),
      child: CachedNetworkImage(imageUrl: imageUrl ?? "",
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => SvgPicture.asset("assets/svg/frame.svg", height: 17.h, width: 11.w, fit: BoxFit.cover,),
      ),
    );
  }
}
