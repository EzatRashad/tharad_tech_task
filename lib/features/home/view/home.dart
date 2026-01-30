import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/core/utils/utils.dart';
import 'package:tharad_tech/core/widgets/my_scaffold.dart';
import 'package:tharad_tech/core/constants/api_constants.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/services/get_storage_helper.dart';
import 'package:tharad_tech/features/home/view/widgets/home_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return MyScaffold(
      title:
          "${AppStrings.welcomeTitle.tr()} ${CacheHelper.getData<String>(key: nameK)}",
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

              32.ph,
              HomeBanner(),
              20.ph,
              Text(AppStrings.aboutTraining.tr(), style: style.titleLarge),
              12.ph,
              Text(
                AppStrings.flutterTrainingDescription.tr(),
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),

              Text(
                AppStrings.trainingDependsOn.tr(),
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),
              Text(
                "• ${AppStrings.trainingPoint1.tr()}",
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),
              Text(
                "• ${AppStrings.trainingPoint2.tr()}",
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),
              Text(
                "• ${AppStrings.trainingPoint3.tr()}",
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),
              Text(
                "• ${AppStrings.trainingPoint4.tr()}",
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),

              Text(
                AppStrings.trainingGoal.tr(),
                style: style.titleMedium!.copyWith(color: AppColors.hint),
              ),
              20.ph,
              Text(AppStrings.workNatureTitle.tr(), style: style.titleLarge),

              16.ph,
              WorkItem(text: AppStrings.workRealApps.tr()),
              8.ph,
              WorkItem(text: AppStrings.workFeatures.tr()),
              8.ph,
              WorkItem(text: AppStrings.workApis.tr()),
              8.ph,
              WorkItem(text: AppStrings.workBugs.tr()),
              8.ph,
              WorkItem(text: AppStrings.workCleanArchitecture.tr()),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkItem extends StatelessWidget {
  const WorkItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            gradient: LinearGradient(
              colors: [Color(0xff54B7BB), Color(0xff265355)],
            ),
          ),
        ),
        8.pw,
        Text(text, style: style.titleMedium!.copyWith(color: AppColors.hint)),
      ],
    );
  }
}
