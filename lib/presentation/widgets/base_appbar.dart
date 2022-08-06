import 'package:flutter/material.dart';
import 'package:top_yurist/utils/colors.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor = AppColors.scaffoldBackground;
  final   Widget? title;
  final Widget? leading;
  final List<Widget> ?actions;
  final bool? centerTitle;
  final AppBar appBar;


  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, this.title, this.actions, this.leading, this.centerTitle, required this.appBar, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.grey),
      centerTitle: centerTitle ?? false,
      elevation: 0,
      leading: leading,
      title: title,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(appBar.preferredSize.height);
}