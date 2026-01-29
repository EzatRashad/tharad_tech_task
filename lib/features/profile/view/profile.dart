import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/utils/utils.dart';
import '/core/widgets/app_input.dart';
import '/core/widgets/app_image_widget.dart';
import '/core/widgets/app_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final name_controller = TextEditingController();

  final email_controller = TextEditingController();

  final password_controller = TextEditingController();

  final confirm_password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Text(''),
        elevation: 0,
        title: Text(
          'الملف الشخصي',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: const Color(0xff101010).withOpacity(0.1),
              child: AppImageWidget(imageName: "notification.svg"),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: kToolbarHeight + 20.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.58),
            end: Alignment(1.00, 0.57),
            colors: [Color(0xFF5CC7A3), Color(0xFF265355)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              28.ph,
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),

                      children: [
                        Column(
                          children: [
                            32.ph,
                            AppInput(
                              label: "اسم المستخدم",
                              hint: "أدخل اسم المستخدم",
                              controller: name_controller,
                            ),

                            12.ph,
                            AppInput(
                              label: "البريد الإلكتروني",
                              hint: "أدخل البريد الإلكتروني",
                              controller: email_controller,
                            ),

                            12.ph,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "الصورة الشخصية",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  6.ph,
                                  Stack(
                                    children: [
                                      AppImageWidget(imageName: "uploaded.png"),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: AppImageWidget(
                                          imageName: "uploaded_camera.svg",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            12.ph,
                            AppInput(
                              label: "كلمة المرور القديمة",
                              hint: "أدخل كلمة المرور",
                              controller: password_controller,
                              obscureText: true,
                              suffixIcon: AppImageWidget(
                                imageName: "eye_off.svg",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            12.ph,
                            AppInput(
                              label: "كلمة المرور الجديدة",
                              hint: "أدخل كلمة المرور",
                              controller: password_controller,
                              obscureText: true,
                              suffixIcon: AppImageWidget(
                                imageName: "eye_off.svg",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            12.ph,
                            AppInput(
                              label: "تأكيد كلمة المرور الجديدة",
                              hint: "أدخل كلمة المرور",
                              controller: password_controller,
                              obscureText: true,
                              suffixIcon: AppImageWidget(
                                imageName: "eye_off.svg",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            40.ph,

                            AppButton(
                              width: 234.w,
                              title: "حفظ التغييرات",
                              onTap: () {},
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, 0.58),
                                end: Alignment(1.00, 0.57),
                                colors: [Color(0xFF5CC7A3), Color(0xFF265355)],
                              ),
                            ),
                            12.ph,
                            Text(
                              "تسجيل الخروج",
                              style: theme.titleMedium!.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
