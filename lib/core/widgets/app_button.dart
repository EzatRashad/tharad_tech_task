import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final double width, height, radius;
  final Widget? child;
  final Gradient? gradient;
  final Color? textColor, borderColor;
  final void Function()? onTap;
  final bool withBorder;

  const AppButton({
    super.key,
    this.title = "OK",
    this.width = double.infinity,
    this.height = 58.0,
    this.onTap,
    this.child,
    this.gradient,
    this.textColor = Colors.white,
    this.borderColor,
    this.withBorder = false,
    this.radius = 16.0,
  });

  static const LinearGradient defaultGradient = LinearGradient(
    begin: Alignment(0.00, 0.58),
    end: Alignment(1.00, 0.57),
    colors: [Color(0xFF54B7BB), Color(0xFF265355)],
  );

  @override
  Widget build(BuildContext context) {
    final Gradient finalGradient = gradient ?? defaultGradient;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: finalGradient,
          borderRadius: BorderRadius.circular(radius),
          border: withBorder
              ? Border.all(color: borderColor ?? Colors.black)
              : null,
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child:
              child ??
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
        ),
      ),
    );
  }
}
