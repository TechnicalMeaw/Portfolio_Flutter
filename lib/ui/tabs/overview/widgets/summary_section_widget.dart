import 'package:flutter/material.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/core/widgets/base_container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SummarySectionWidget extends StatefulWidget {
  const SummarySectionWidget({super.key});

  @override
  State<SummarySectionWidget> createState() => _SummarySectionWidgetState();
}

class _SummarySectionWidgetState extends State<SummarySectionWidget> {
  bool isTitleVisible = false;
  bool isSubtitleVisible = false;
  bool isHireMeVisible = false;
  bool isViewProjectsVisible = false;
  bool isDownloadCvHovered = false;
  bool isViewProjectsHovered = false;

  bool _hasAnimated = false;

  void onVisibilityChanged(double visibleFraction) {
    if (visibleFraction > 0.3 && !_hasAnimated && mounted) {
      _hasAnimated = true;
      triggerAnimations();
    }
  }

  void triggerAnimations() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() => isTitleVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => isSubtitleVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => isHireMeVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() => isViewProjectsVisible = true);
    });
  }

  void onDownloadCVTap() async {
    final Uri url = Uri.parse('https://1drv.ms/b/c/676896353223dc87/ESCxAKK0Ip9DnuywRVuSX7oBpgXcbo2N4AOQPfgLMRFRyA?e=MvOLa1');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void onViewProjectsTap() {

    debugPrint("Navigating to projects tab...");
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainerWidget(
      outerPadding: EdgeInsets.zero,
      innerPadding: const EdgeInsets.all(32),
      onVisibilityChanged: onVisibilityChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedOpacity(
            opacity: isTitleVisible ? 1 :0,
            duration: const Duration(milliseconds: 700),
            child: const Text(
              "Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorConstants.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            opacity: isSubtitleVisible ? 1 :0,
            duration: const Duration(milliseconds: 700),
            child: const Text(
              "Experienced Flutter and Android developer with 4+ years crafting and scaling apps used by over 2M+ users. I specialize in building high-quality, reliable software using Django, FastAPI, Firebase, and AWS — driven to create products that truly stand out.",
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstants.white,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: isHireMeVisible ? 1 : 0,
                child: InkWell(
                  onTap: onDownloadCVTap,
                  onHover: (hovered) {
                    setState(() => isDownloadCvHovered = hovered);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDownloadCvHovered
                          ? ColorConstants.white.withOpacity(0.8)
                          : ColorConstants.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        width: 1,
                        color: isDownloadCvHovered ? ColorConstants.black : ColorConstants.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.glassBlue.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      "Download CV",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDownloadCvHovered ? ColorConstants.black : ColorConstants.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: isViewProjectsVisible ? 1 : 0,
                child: InkWell(
                  onTap: onViewProjectsTap,
                  onHover: (hovered) {
                    setState(() => isViewProjectsHovered = hovered);
                  },
                  child: Text(
                    "View Projects",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isViewProjectsHovered ? FontWeight.w700 : FontWeight.w500,
                      color: isViewProjectsHovered
                          ? ColorConstants.white
                          : ColorConstants.white.withOpacity(0.8),
                      decoration: TextDecoration.underline,
                      decorationColor: isViewProjectsHovered
                          ? ColorConstants.glassWhite
                          : ColorConstants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
