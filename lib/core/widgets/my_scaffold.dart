import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/core/widgets/app_image_widget.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.title,
    required this.body,
    this.isCenter = false,
  });
  final String title;
  final Widget body;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title,
          style: style.titleLarge?.copyWith(
            color: AppColors.white,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: isCenter,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: .2),
            child: AppImageWidget(imageName: "notification.svg"),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff54B7BB), Color(0xff265355)],
          ),
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
