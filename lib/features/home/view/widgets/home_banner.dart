import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/widgets/app_image_widget.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff54B7BB), Color(0xff265355)],
        ),
      ),
      child: Column(
        children: [
          AppImageWidget(imageName: "frame.png"),
          Text(
            AppStrings.flutterTrainingTitle.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

