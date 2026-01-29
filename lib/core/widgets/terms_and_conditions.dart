import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_strings.dart';
import '/core/widgets/custom_check_box.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  const TermsAndConditionsWidget({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(isChecked: isChecked, onChecked: onChanged),
        const SizedBox(width: 4),
        Text(
          AppStrings.rememberMe.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
