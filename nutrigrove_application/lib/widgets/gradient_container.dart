import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  const GradientContainer({
    super.key,
    required this.child,
    required this.gradient,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.borderRadius,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
