import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/ui/core/widgets/base_container_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/tabs/overview/widgets/social_icon_widget.dart';

class TopIntroSectionWidget extends StatefulWidget {
  const TopIntroSectionWidget({super.key});

  @override
  State<TopIntroSectionWidget> createState() => _TopIntroSectionWidgetState();
}

class _TopIntroSectionWidgetState extends State<TopIntroSectionWidget> with TickerProviderStateMixin {
  double bannerHeight = 0.05;
  double bannerWidthFactor = 0.0;
  bool isProfilePictureVisible = false;
  bool isProfileBannerOpened = false;
  bool isProfileBannerTitleVisible = false;
  bool isVisible = false;

  void triggerAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => bannerWidthFactor = 1.0);
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() => isProfilePictureVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() => bannerHeight = 1.0);
    });

    Future.delayed(const Duration(milliseconds: 1700), () {
      setState(() => isProfileBannerOpened = true);
    });

    Future.delayed(const Duration(milliseconds: 2900), () {
      setState(() => isProfileBannerTitleVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('TopIntroSectionWidget'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !isVisible) {
          isVisible = true;
          triggerAnimations();
        }
      },
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bannerWidth = (constraints.maxWidth * bannerWidthFactor).clamp(0.0, constraints.maxWidth);
                return Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 640),
                      margin: const EdgeInsets.only(left: 75),
                      height: constraints.maxHeight * bannerHeight,
                      width: bannerWidth > 75 ? bannerWidth - 75 : bannerWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.glassWhite, width: 0.8),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            ColorConstants.glassBlack.withOpacity(0.1),
                            ColorConstants.glassBlack.withOpacity(0.08),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 75),
                            child: Visibility(
                              visible: bannerHeight == 1,
                              maintainAnimation: true,
                              maintainState: true,
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 2),
                                curve: Curves.fastOutSlowIn,
                                opacity: isProfileBannerOpened ? 1 : 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Santanu Mukherjee",
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth > 500 ? 24 : 16,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstants.white,
                                      ),
                                    ),
                                    Text(
                                      "Software Engineer",
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth > 500 ? 16 : 12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstants.white.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    AnimatedContainer(
                                      width: isProfileBannerTitleVisible ? (constraints.maxWidth - 75) * 0.4 : 0,
                                      height: 1,
                                      color: ColorConstants.white.withOpacity(0.8),
                                      duration: const Duration(milliseconds: 300),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SocialIconWidget(
                                              assetPath: AssetConstants.icLinkedin,
                                              url: 'https://www.linkedin.com/in/mukherjee-santanu/'),
                                          SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                          SocialIconWidget(
                                              assetPath: AssetConstants.icGithub,
                                              url: 'https://github.com/TechnicalMeaw'),
                                          SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                          SocialIconWidget(
                                              assetPath: AssetConstants.icEmail,
                                              url: 'mailto:connect@santanumukherjee.com'),
                                          SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                          SocialIconWidget(
                                            assetPath: AssetConstants.icPhone,
                                            onTap: () async {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                  'Phone number copied.',
                                                  style: TextStyle(
                                                      color: ColorConstants.white,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                backgroundColor: ColorConstants.glassBlue,
                                                elevation: 10,
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              await Clipboard.setData(
                                                  const ClipboardData(text: "+918240251373"));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: isProfilePictureVisible ? 1 : 0,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                border: Border.all(width: 5, color: ColorConstants.white),
                boxShadow: const [
                  BoxShadow(
                    color: ColorConstants.glassBlue,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage(AssetConstants.imgProfileImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}
