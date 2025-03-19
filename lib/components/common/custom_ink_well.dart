import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Widget child;

  const CustomInkWell({
    super.key,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: borderRadius,
        enableFeedback: false,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
