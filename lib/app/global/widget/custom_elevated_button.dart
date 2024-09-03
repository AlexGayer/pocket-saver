import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Widget? image;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;
  final Color? themeColor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.image,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.borderRadius = 30.0,
    this.textStyle,
    this.iconColor,
    this.iconSize = 24.0,
    this.themeColor,
  }) : assert(icon == null || image == null,
            'Only one of icon or image can be provided.');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? themeColor ?? const Color(0xFF0F052C),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, color: iconColor ?? Colors.white, size: iconSize)
            : image ?? const SizedBox.shrink(),
        label: Text(
          text,
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: themeColor),
        ),
      ),
    );
  }
}
