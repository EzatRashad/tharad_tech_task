import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/core/utils/utils.dart';
import 'package:tharad_tech/core/widgets/app_image_widget.dart';
import 'package:tharad_tech/features/home/view/home.dart';
import 'package:tharad_tech/features/profile/view/profile.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 73.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(color: Color(0xffF4F7F6)),
        child: Row(
          children: list.asMap().entries.map((e) {
            var index = e.key;
            var item = e.value;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  changeIndex(index);
                },
                child: Column(
                  children: [
                    AppImageWidget(
                      imageName: item.icon,
                      width: 20.w,
                      height: 20.h,
                      color: index == selectedIndex
                          ? AppColors.primary
                          : Color(0xffADADAC),
                    ),
                    4.ph,
                    Text(
                      item.text.tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: index == selectedIndex
                            ? AppColors.primary
                            : Color(0xffADADAC),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  int selectedIndex = 0;

  List<Widget> screens = [HomeView(), Profile()];

  void changeIndex(int index) {
    selectedIndex = index;
    setState(() {});
  }
}

class NavItem {
  NavItem({required this.text, required this.icon});

  final String text;
  final String icon;
}

List<NavItem> list = [
  NavItem(text: AppStrings.home, icon: "home.svg"),
  NavItem(text: AppStrings.myAccount, icon: "profile.svg"),
];
