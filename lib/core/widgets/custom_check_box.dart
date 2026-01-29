import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/core/style/app_colors.dart';
import '/core/widgets/app_image_widget.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.isChecked,
    required this.onChecked,
  });
  final bool isChecked;
  final ValueChanged<bool> onChecked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        width: 24.w,
        height: 24.w,
        duration: const Duration(milliseconds: 100),
        decoration: ShapeDecoration(
          color: isChecked ? Color(0xFF42867B) : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.50, color: AppColors.black),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: isChecked
            ? Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset("assets/icons/check.svg"),
              )
            : const SizedBox(),
      ),
    );
  }
}
