import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/resources/color_constants.dart'; // Adjust this import to match your project
import 'package:portfolio/ui/core/widgets/visibility_aware_stateless_widget.dart';

class BaseContainerWidget extends VisibilityAwareWidget {
  BaseContainerWidget({
    super.key,
    required this.child,
    this.outerPadding = const EdgeInsets.all(16.0),
    this.blurSigma = 15,
    this.innerPadding,
    this.onVisibilityChanged,
  });

  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry? innerPadding;
  final double blurSigma;
  final Widget child;
  final Function(double visibleFraction)? onVisibilityChanged;

  @override
  Future<void> onVisible(double visibleFraction) async {
    onVisibilityChanged?.call(visibleFraction);
  }

  @override
  Widget body(BuildContext context, bool isVisible) {
    return Padding(
      padding: outerPadding,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 700),
        opacity: isVisible ? 1 : 0,
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ColorConstants.glassWhite.withOpacity(0.4),
              width: 0.8,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Padding(
                padding: innerPadding ?? const EdgeInsets.all(16.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
