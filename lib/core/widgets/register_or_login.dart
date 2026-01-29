import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/style/app_colors.dart';
import '/core/utils/utils.dart';

class RegisterOrLogin extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;
  final MainAxisAlignment alignment;

  const RegisterOrLogin({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: alignment,
      children: [
        Text(normalText, style: theme.titleSmall!.copyWith(fontSize: 12.sp)),
        3.pw,
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            textAlign: TextAlign.center,
            style: theme.titleMedium!.copyWith(
              fontSize: 12.sp,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
