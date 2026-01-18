import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HoverableProjectCard extends StatefulWidget {
  final dynamic project;
  final bool enabled;

  const HoverableProjectCard({
    required this.project,
    required this.enabled,
  });

  @override
  State<HoverableProjectCard> createState() => _HoverableProjectCardState();
}

class _HoverableProjectCardState extends State<HoverableProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: 96,
      height: 120,
      padding: EdgeInsets.symmetric(
        vertical: _hovered ? 7 : 8,
        horizontal: _hovered ? 11 : 12,
      ),
      transform: _hovered
          ? (Matrix4.identity()
        ..translate(0.0, -2.5)
        ..scale(1.03))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _hovered
            ? ColorConstants.glassWhite.withOpacity(0.10)
            : ColorConstants.transparent,
        border: Border.all(
          color: _hovered
              ? ColorConstants.cyanBlue.withOpacity(0.65)
              : ColorConstants.transparent,
          width: _hovered ? 1.2 : 0.8,
        ),
        boxShadow: _hovered
            ? [
          BoxShadow(
            color: ColorConstants.cyanBlue.withOpacity(0.25),
            blurRadius: 18,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: ColorConstants.black.withOpacity(0.20),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ]
            : [
          // BoxShadow(
          //   color: ColorConstants.black.withOpacity(0.12),
          //   blurRadius: 10,
          //   offset: const Offset(0, 4),
          // ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedScale(
                    scale: _hovered ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOut,
                    child: Image.network(
                      widget.project.logoUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.project.title,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.white.withAlpha(236),
                  fontWeight: _hovered ? FontWeight.w500 : FontWeight.w400,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),

          /// Hover arrow cue (matches modern tiles)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutQuint,
            top: _hovered ? 4 : -24,
            right: 4,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 160),
              opacity: _hovered ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.darkGray.withOpacity(0.85),
                  border: Border.all(
                    color: ColorConstants.white.withOpacity(0.4),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_outward_rounded,
                  size: 12,
                  color: ColorConstants.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (!widget.enabled) return card;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            launchUrl(Uri.parse(widget.project.redirectUrl!));
          },
          child: card,
        ),
      ),
    );
  }
}
