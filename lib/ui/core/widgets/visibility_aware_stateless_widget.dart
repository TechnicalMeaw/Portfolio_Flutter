import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Abstract base class for any widget that needs to react when it becomes visible,
/// without itself being a [StatefulWidget].
abstract class VisibilityAwareWidget extends StatelessWidget {
  const VisibilityAwareWidget({super.key});

  /// Override to handle logic when the widget becomes visible (e.g. trigger animations, counters, etc.)
  Future<void> onVisible(double visibleFraction) async {}

  /// Provide the actual UI, depending on whether the widget is visible
  Widget body(BuildContext context, bool isVisible);

  @override
  Widget build(BuildContext context) {
    return _VisibilityAwareInternal(
      builder: (context, isVisible) => body(context, isVisible),
      onVisible: onVisible,
    );
  }
}

/// Private internal widget that manages visibility detection and rebuilds the visible widget
class _VisibilityAwareInternal extends StatefulWidget {
  final Widget Function(BuildContext context, bool isVisible) builder;
  final Future<void> Function(double visibleFraction) onVisible;

  const _VisibilityAwareInternal({
    required this.builder,
    required this.onVisible,
  });

  @override
  State<_VisibilityAwareInternal> createState() => _VisibilityAwareInternalState();
}

class _VisibilityAwareInternalState extends State<_VisibilityAwareInternal> {
  bool _isVisible = false;
  bool _hasTriggered = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) async {
        if (!_hasTriggered && info.visibleFraction > 0.3) {
          _hasTriggered = true;
          await widget.onVisible(info.visibleFraction);
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      },
      child: widget.builder(context, _isVisible),
    );
  }
}
