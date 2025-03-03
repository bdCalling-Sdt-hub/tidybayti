import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final double? appBarWidth;
  final Color appBarBgColor;
  final String? appBarContent;
  final IconData? iconData;

  const CustomAppBar({
    this.appBarHeight = 64,
    this.appBarWidth,
    this.appBarBgColor = Colors.white,
    this.appBarContent,
    super.key,
    this.iconData,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(appBarWidth ?? double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.appBarBgColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (widget.iconData != null)
            IconButton(
              icon: Icon(widget.iconData),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          const Spacer(),
          if (widget.appBarContent != null)
            CustomText(
              text: widget.appBarContent!,
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: AppColors.dark500,
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
