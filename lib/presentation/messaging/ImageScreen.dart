import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_downloader/image_downloader.dart';

class ChatImage extends StatelessWidget {
  final String? date;
  final String? imageUrl;

  const ChatImage({Key? key, this.date, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [IconButton(onPressed: () async{
          try {
            // Saved with this method.
            var imageId = await ImageDownloader.downloadImage("https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
            if (imageId == null) {
              return;
            }
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You successfully dawnloaded the photo")));
            // Below is a method of obtaining saved image information.
            var fileName = await ImageDownloader.findName(imageId);
            var path = await ImageDownloader.findPath(imageId);
            var size = await ImageDownloader.findByteSize(imageId);
            var mimeType = await ImageDownloader.findMimeType(imageId);
          } on PlatformException catch (error) {
            print(error);
          }
        }, icon: SvgPicture.asset("assets/svg/download.svg"))],
        title: Text(
          date ?? "",
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: AppColors.white),
        ),
        elevation: 0,
        backgroundColor: AppColors.black,
      ),
      body: Hero(
        tag: imageUrl!,
        child: CachedNetworkImage(imageUrl: imageUrl ?? "",
          width: 374.w,
          height: 511.h,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => SvgPicture.asset("assets/svg/frame.svg", height: 17.h, width: 11.w, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
