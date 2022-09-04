import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_yurist/utils/colors.dart';

final ImagePicker _picker = ImagePicker();

Future<File?> pickImage(BuildContext context) async {
  final style = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(Color.fromRGBO(28, 79, 209, 0.3)),
  );
  final result = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 150.h,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 30.h, top: 16.h, left: 16.w, right: 16.w),
          child: Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  color: AppColors.blue.withOpacity(0.1),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CupertinoButton(
                  color: AppColors.blue.withOpacity(0.1),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (result == null) {
    return null;
  }

  final file = await _getImageFromCamera(result);
  return file;
}

Future<File?> _getImageFromCamera(ImageSource source) async {
  try {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 30,
    );
    if (image == null) {
      return null;
    }
    final temporaryImage = File(image.path);
    debugPrint(temporaryImage.path);
    return temporaryImage;
  } catch (e) {
    debugPrint("filed to pick image: $e");
  }
  return null;
}
