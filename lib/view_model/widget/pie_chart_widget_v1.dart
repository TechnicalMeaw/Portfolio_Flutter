import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';

class PieChart extends StatefulWidget {
  const PieChart({
    super.key,
    required this.size,
    required this.dataList,
    this.isLabelVisible = false,
    this.stroke = 2,
    this.textDistance = 50,
    this.textGap = 15,
    this.textCenterAdjustmentOffset = Offset.zero,
  });

  final Size size;
  final List<PieChartDataModel> dataList;
  final bool isLabelVisible;
  final double stroke;
  final double textDistance;
  final double textGap;
  final Offset textCenterAdjustmentOffset;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final Animation<double> _mainAnimation;

  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  late final List<PieData> _pieData;

  int? _hoveredIndex;
  int? _previousHoveredIndex;
  Offset? _hoverPosition;

  late final double _hitPadding;

  bool _animationStarted = false;
  bool _isMobile = false;

  @override
  void initState() {
    super.initState();

    // Precompute angles
    double start = 0;
    _pieData = widget.dataList.map((e) {
      final sweep = 2 * pi * e.percentage / 100;
      final data = PieData(startAngle: start, sweepAngle: sweep);
      start += sweep;
      return data;
    }).toList();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _mainAnimation = CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeInOutCubic,
    );

    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );

    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    );

    // Must cover max outward stroke growth
    final baseThickness = widget.size.width / 4 / widget.stroke;
    _hitPadding = (baseThickness * 1.35) / 2 + 2;

    /// ✅ Guaranteed fallback start (prevents blank render)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_animationStarted) {
        _animationStarted = true;
        _mainController.forward();
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  /// Safe visibility-based animation trigger
  void _tryStartAnimationWhenVisible() {
    if (_animationStarted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    final visible =
        offset.dy < screenHeight &&
            offset.dy + renderBox.size.height > 0;

    if (visible) {
      _animationStarted = true;
      _mainController.forward();
    }
  }

  int? _getHoveredSlice(Offset pos) {
    final center = Offset(widget.size.width / 2, widget.size.height / 2);
    final dx = pos.dx - center.dx;
    final dy = pos.dy - center.dy;

    final angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);
    final fraction = _mainAnimation.value;

    for (int i = 0; i < _pieData.length; i++) {
      final start = _pieData[i].startAngle * fraction;
      final end = start + (_pieData[i].sweepAngle * fraction);
      if (angle >= start && angle <= end) {
        return i;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _isMobile = MediaQuery.of(context).size.width < 650;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _tryStartAnimationWhenVisible();
    });

    final chart = Padding(
      padding: EdgeInsets.all(_hitPadding),
      child: CustomPaint(
        size: widget.size,
        painter: PieChartPainter(
          pieData: _pieData,
          dataList: widget.dataList,
          mainAnimation: _mainAnimation,
          hoverAnimation: _hoverAnimation,
          hoveredIndex: _isMobile ? null : _hoveredIndex,
          previousHoveredIndex: _previousHoveredIndex,
          hoverPosition: _isMobile ? null : _hoverPosition,
          stroke: widget.stroke,
          isLabelVisible: widget.isLabelVisible,
          textDistance: widget.textDistance,
          textGap: widget.textGap,
          textCenterAdjustmentOffset: widget.textCenterAdjustmentOffset,
        ),
      ),
    );

    /// 🚫 Mobile: no hover, GPU-safe
    if (_isMobile) {
      return RepaintBoundary(child: chart);
    }

    /// 🖱 Desktop/Web hover
    return MouseRegion(
      cursor: _hoveredIndex != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onHover: (event) {
        final localPos =
            event.localPosition - Offset(_hitPadding, _hitPadding);

        final newIndex = _getHoveredSlice(localPos);

        if (newIndex != _hoveredIndex) {
          _previousHoveredIndex = _hoveredIndex;
          _hoveredIndex = newIndex;
          _hoverController
            ..reset()
            ..forward();
        }

        _hoverPosition = localPos;
        setState(() {});
      },
      onExit: (_) {
        _previousHoveredIndex = _hoveredIndex;
        _hoveredIndex = null;
        _hoverPosition = null;

        _hoverController
          ..reset()
          ..forward();

        setState(() {});
      },
      child: RepaintBoundary(child: chart),
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter({
    required this.pieData,
    required this.dataList,
    required this.mainAnimation,
    required this.hoverAnimation,
    required this.hoveredIndex,
    required this.previousHoveredIndex,
    required this.hoverPosition,
    required this.stroke,
    required this.isLabelVisible,
    required this.textDistance,
    required this.textGap,
    required this.textCenterAdjustmentOffset,
  }) : super(repaint: Listenable.merge([mainAnimation, hoverAnimation]));

  final List<PieData> pieData;
  final List<PieChartDataModel> dataList;

  final Animation<double> mainAnimation;
  final Animation<double> hoverAnimation;

  final int? hoveredIndex;
  final int? previousHoveredIndex;
  final Offset? hoverPosition;

  final double stroke;
  final bool isLabelVisible;
  final double textDistance;
  final double textGap;
  final Offset textCenterAdjustmentOffset;

  final Paint arcPaint = Paint()..style = PaintingStyle.stroke;
  final Paint borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = ColorConstants.white
    ..strokeWidth = 1;

  final Paint guidePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.6;

  double _hoverFactor(int index) {
    if (index == hoveredIndex) return hoverAnimation.value;
    if (index == previousHoveredIndex) return 1 - hoverAnimation.value;
    return 0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fraction = max(mainAnimation.value, 0.001); // safety
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final baseThickness = size.width / 4 / stroke;

    for (int i = 0; i < pieData.length; i++) {
      final slice = pieData[i];
      final model = dataList[i];

      final start = slice.startAngle * fraction;
      final sweep = slice.sweepAngle * fraction;
      final midAngle = start + sweep / 2;

      final hoverT = _hoverFactor(i);
      final thickness =
          baseThickness + baseThickness * 0.35 * hoverT;

      arcPaint
        ..strokeWidth = thickness
        ..color = model.color.withOpacity(
          lerpDouble(
            hoveredIndex == null ? 0.85 : 0.25,
            0.95,
            hoverT,
          )!,
        );

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep,
        false,
        arcPaint,
      );

      final grow = thickness / 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - grow),
        start,
        sweep,
        false,
        borderPaint,
      );

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius + grow),
        start,
        sweep,
        false,
        borderPaint,
      );

      final guideStart =
          center + Offset(cos(midAngle), sin(midAngle)) * (radius + grow);
      final guideEnd =
          guideStart + Offset(cos(midAngle), sin(midAngle)) * textDistance;

      guidePaint.color =
          ColorConstants.glassWhite.withOpacity(fraction);
      canvas.drawLine(guideStart, guideEnd, guidePaint);

      final label =
      isLabelVisible ? model.title : '${model.percentage}%';

      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: ColorConstants.white.withOpacity(fraction),
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final textOffset =
          guideEnd + Offset(cos(midAngle), sin(midAngle)) * textGap;

      canvas.save();
      canvas.translate(textOffset.dx, textOffset.dy);
      tp.paint(canvas, textCenterAdjustmentOffset);
      canvas.restore();
    }

    // Tooltip (desktop only)
    if (hoveredIndex != null && hoverPosition != null) {
      final model = dataList[hoveredIndex!];
      final opacity = hoverAnimation.value;

      final tp = TextPainter(
        text: TextSpan(
          text:
          '${model.title}\n${model.percentage.toStringAsFixed(1)}%',
          style: TextStyle(
            color: Colors.white.withOpacity(opacity),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          hoverPosition!.dx + 12,
          hoverPosition!.dy + 12,
          tp.width + 12,
          tp.height + 10,
        ),
        const Radius.circular(6),
      );

      canvas.drawRRect(
        rect,
        Paint()..color = Colors.black.withOpacity(0.75 * opacity),
      );

      tp.paint(
        canvas,
        Offset(rect.left + 6, rect.top + 5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => false;
}

class PieData {
  final double startAngle;
  final double sweepAngle;

  PieData({
    required this.startAngle,
    required this.sweepAngle,
  });
}
