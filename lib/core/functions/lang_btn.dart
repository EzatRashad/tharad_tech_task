import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/core/utils/utils.dart';
import 'package:tharad_tech/core/widgets/app_button.dart';

class LangBtn {
  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xffF4F7F6),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.language.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
              24.ph,
              RadioListTile<Locale>(
                activeColor: AppColors.primary,
                tileColor: Colors.white,

                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE8E8E8)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                value: const Locale('ar'),
                groupValue: context.locale,
                onChanged: (value) {
                  context.setLocale(value ?? const Locale('ar'));
                },
                title: Text(
                  "اللغة العربية",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0D1D1E),
                  ),
                ),
              ),
              12.ph,
              RadioListTile<Locale>(
                activeColor: AppColors.primary,
                tileColor: Colors.white,

                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE8E8E8)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                value: const Locale('en'),
                groupValue: context.locale,
                onChanged: (value) {
                  context.setLocale(value!);
                },
                title: Text(
                  "English",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0D1D1E),
                  ),
                ),
              ),
              24.ph,
              AppButton(
                title: AppStrings.execute.tr(),
                onTap: () {
                  Navigator.pop(context);
                },
                width: double.infinity,
              ),
            ],
          ),
        );
      },
    );
  }
}
