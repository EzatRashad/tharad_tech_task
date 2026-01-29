import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '/core/constants/app_strings.dart';
import '/core/style/app_colors.dart';
import '/core/utils/utils.dart';
import '/core/widgets/app_image_widget.dart';

class AppPickImage extends StatelessWidget {
  const AppPickImage({
    super.key,
    required this.onImagePicked,
    this.selectedImage,
  });

  final ValueChanged<File> onImagePicked;
  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile =
            await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          onImagePicked(File(pickedFile.path));
        }
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.primary,
          radius: Radius.circular(8.r),
          dashPattern: const [10, 10],
        ),
        child: Container(
          width: double.infinity,
          color: AppColors.primary.withValues(alpha: 0.05),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Column(
            children: [
              selectedImage == null
                  ? AppImageWidget(imageName: 'camera.svg')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        selectedImage!,
                        height: 60.h,
                        width: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
              6.ph,
              Text(
                AppStrings.allowedFiles.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF998C8C),
                  fontSize: 8.sp,
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 