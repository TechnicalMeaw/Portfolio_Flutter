import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// Removed redundant GetX imports from user's second file if they were there.
// Assuming these are the correct GetX imports:
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_utils/get_utils.dart';

import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/utils.dart';
import 'package:portfolio/view_model/tabs/overview_tab_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

// Ensure ProjectData class is defined
class ProjectData {
  final String title;
  final String description;
  final String imageAsset;
  final String? id;
  final String? projectUrl;

  ProjectData({
    required this.title,
    required this.description,
    required this.imageAsset,
    this.id,
    this.projectUrl,
  });
}


class OverviewTab extends StatelessWidget {
  final OverviewTabViewModel viewModel;

  OverviewTab({super.key, required this.viewModel});

  // Helper method for top bar (close/minimize) buttons
  Widget _buildTopBarButton({
    required RxBool hoverVariable,
    required VoidCallback onTap,
    required Color buttonColor,
    required IconData iconData,
    required bool isCloseButton, // To differentiate margin logic
  }) {
    return InkWell(
      onTap: () {
        onTap();
        hoverVariable.value = false;
      },
      onHover: (isHovered) {
        hoverVariable.value = isHovered;
      },
      child: Obx(
            () => AnimatedContainer(
          margin: EdgeInsets.only(
              left: hoverVariable.value
                  ? (isCloseButton ? 0 : 4)
                  : (isCloseButton ? 2 : 3),
              right: hoverVariable.value ? 0 : (isCloseButton ? 4 : 0)),
          height: hoverVariable.value ? 12 : 8,
          width: hoverVariable.value ? 12 : 8,
          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5), color: buttonColor),
          duration: const Duration(milliseconds: 125),
          child: hoverVariable.value
              ? Center(child: Icon(iconData, size: 10, color: ColorConstants.black.withAlpha(236),))
              : const SizedBox(height: 8, width: 8),
        ),
      ),
    );
  }

  // Helper method for social media icons
  Widget _buildSocialIcon({
    required String assetPath,
    required String url,
    required RxBool isHoveredVariable,
    Color normalColor = ColorConstants.glassBlack, // Corrected from glassBlack based on usage
    Color hoverColor = ColorConstants.white,
  }) {
    normalColor = ColorConstants.glassWhite;
    return MouseRegion(
      onHover: (_) => isHoveredVariable.value = true,
      onExit: (_) => isHoveredVariable.value = false,
      child: InkWell(
        onTap: () async {
          final Uri parsedUrl = Uri.parse(url);
          if (!await launchUrl(parsedUrl)) {
            throw Exception('Could not launch $parsedUrl');
          }
        },
        child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isHoveredVariable.value
                          ? ColorConstants.white.withOpacity(0.2)
                          : ColorConstants.black.withOpacity(0.1),
                      blurRadius: isHoveredVariable.value ? 12 : 6,
                      spreadRadius: isHoveredVariable.value ? 2 : 1,
                    ),
                  ]
                ),
                child: Image(
                            height: 18,
                            width: 18,
                            image: AssetImage(assetPath),
                            color: isHoveredVariable.value ? hoverColor : normalColor,
                          ),
              ),
        ),
      ),
    );
  }

  // Helper for phone icon with Snackbar
  Widget _buildPhoneIcon(BuildContext context) {
    return MouseRegion(
      onHover: (_) => viewModel.isPhoneIconHovered.value = true,
      onExit: (_) => viewModel.isPhoneIconHovered.value = false,
      child: InkWell(
        onTap: () async {
          const snackBar = SnackBar(
            content: Text('Phone number copied.',
                style: TextStyle(
                    color: ColorConstants.white, fontWeight: FontWeight.w400)),
            backgroundColor: ColorConstants.glassBlue,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await Clipboard.setData(const ClipboardData(text: "+918240251373"));
        },
        child: Obx(
              () => Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: viewModel.isPhoneIconHovered.value
                            ? ColorConstants.white.withOpacity(0.2)
                            : ColorConstants.black.withOpacity(0.1),
                        blurRadius: viewModel.isPhoneIconHovered.value ? 12 : 6,
                        spreadRadius: viewModel.isPhoneIconHovered.value ? 2 : 1,
                      ),
                    ]
                ),
                child: Image(
                            height: 18,
                            width: 18,
                            image: const AssetImage(AssetConstants.icPhone),
                            color: viewModel.isPhoneIconHovered.value
                  ? ColorConstants.white
                  : ColorConstants.glassWhite,
                          ),
              ),
        ),
      ),
    );
  }

  // Helper method for generic section wrapper with animation and blur
  Widget _buildAnimatedSectionWrapper({
    required RxBool visibilityFlag,
    required Widget content,
    required BoxDecoration sectionDecoration,
    EdgeInsets padding = const EdgeInsets.all(32.0), // Default padding
    double blurSigma = 15.0,
    BoxConstraints? boxConstrains
  }) {
    return Obx(() => AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      opacity: visibilityFlag.value ? 1 : 0,
      curve: Curves.easeIn,
      child: Container(
        constraints: boxConstrains,
        decoration: sectionDecoration.copyWith( // Ensure borderRadius is applied consistently
          borderRadius: sectionDecoration.borderRadius ?? BorderRadius.circular(32),
          border: sectionDecoration.border ??
              Border.all(
                  color: ColorConstants.glassWhite.withOpacity(0.6),
                  width: 1),
        ),
        child: ClipRRect(
          borderRadius: sectionDecoration.borderRadius != null
              ? (sectionDecoration.borderRadius as BorderRadius)
              : BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Padding(
              padding: padding,
              child: content,
            ),
          ),
        ),
      ),
    ));
  }

  // Helper for KPI cards
  Widget _buildKpiCard({
    required RxInt kpiValue,
    required String label,
    String suffix = "+",
    required RxBool isVisible,
    required RxBool isHovered,
    required VoidCallback onTap,
    required List<Color> normalGradientColors,
    required List<Color> hoverGradientColors,
    Color textColor = ColorConstants.white,
    Color textHoverColor = ColorConstants.white,
    required BoxConstraints constraints
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      opacity: isVisible.value ? 1 : 0,
      curve: Curves.easeIn,
      child: Obx(
            () => InkWell(
          onTap: onTap,
          onHover: (hovering) => isHovered.value = hovering,
          borderRadius: BorderRadius.circular(32),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            constraints: const BoxConstraints(minWidth: 250),
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                  color: isHovered.value ? ColorConstants.white : ColorConstants.glassWhite.withOpacity(0.6),
                  width: 1),
              gradient: RadialGradient( // Changed to Radial as per original user code for KPI
                radius: 1, // Ensure this is desired for KPI
                colors: isHovered.value
                    ? hoverGradientColors
                    : normalGradientColors,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      bottom: isHovered.value ? 24 : 0,
                      top: 0,
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${kpiValue.value}$suffix",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: isHovered.value ? textHoverColor.withAlpha(236) : textColor.withAlpha(236),
                                shadows: const <Shadow>[
                                  Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 15.0,
                                      color: ColorConstants.black),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isHovered.value ? textHoverColor.withAlpha(236) : textColor.withAlpha(236),
                                shadows: const <Shadow>[
                                  Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 15.0,
                                      color: ColorConstants.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                      // Positioned(
                      //   top: 16,
                      //   right: 16,
                      //   child: AnimatedOpacity(
                      //     opacity: isHovered.value ? 1 : 0,
                      //     duration: const Duration(milliseconds: 300),
                      //     child: Icon(Icons.open_in_new, color: ColorConstants.white, size: 16,)
                      //     // Text(
                      //     //   "Learn More",
                      //     //   textAlign: TextAlign.center,
                      //     //   style: TextStyle(
                      //     //     fontSize: 10,
                      //     //     fontWeight: FontWeight.w400,
                      //     //     decoration: TextDecoration.underline,
                      //     //     decorationColor: ColorConstants.white,
                      //     //     decorationThickness: 1,
                      //     //     color: isHovered.value ? textHoverColor : textColor,
                      //     //     shadows: const <Shadow>[
                      //     //       Shadow(
                      //     //           offset: Offset(0.0, 0.0),
                      //     //           blurRadius: 15.0,
                      //     //           color: ColorConstants.black),
                      //     //     ],
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutQuint,
                      bottom: isHovered.value ? 24 : -40,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isHovered.value ? 1.0 : 0.0,
                        child: Text(
                                "Learn More",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorConstants.white,
                                  decorationThickness: 1,
                                  color: isHovered.value ? textHoverColor : textColor,
                                  shadows: const <Shadow>[
                                    Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 15.0,
                                        color: ColorConstants.black),
                                  ],
                                ),
                              ),

                        // Container(
                        //   padding: const EdgeInsets.all(8), // Slightly larger padding
                        //   decoration: BoxDecoration(
                        //       color: ColorConstants.glassWhite.withOpacity(0.1), // Accent color for icon background
                        //       shape: BoxShape.circle,
                        //       border: Border.all(color: ColorConstants.white.withOpacity(0.5), width: 1) // Brighter border for icon
                        //   ),
                        //   child: const Icon(Icons.arrow_outward_rounded,
                        //       color: ColorConstants.white, size: 12), // Slightly larger icon
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper for "View All" text buttons
  Widget _buildViewAllTextButton({
    required RxBool isHoveredVariable,
    required VoidCallback onTap,
    bool isPaddingRequired = true,
    String text = "View All",
  }) {
    return InkWell(
      onTap: onTap,
      onHover: (hovering) {
        isHoveredVariable.value = hovering;
      },
      child: Obx(
            () => Padding(
          padding: EdgeInsets.symmetric(horizontal: isPaddingRequired ? 8 : 0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isHoveredVariable.value
                  ? ColorConstants.white
                  : ColorConstants.glassWhite,
              decoration: TextDecoration.underline,
              decorationColor: isHoveredVariable.value
                  ? ColorConstants.white
                  : ColorConstants.glassWhite,
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  color: !isHoveredVariable.value
                      ? ColorConstants.black
                      : ColorConstants.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for links in the Links section
  Widget _buildLinkItem({
    required String linkText,
    required String url,
    required RxBool isHoveredVariable,
  }) {
    return InkWell(
      onTap: () async {
        final Uri parsedUrl = Uri.parse(url);
        if (!await launchUrl(parsedUrl)) {
          throw Exception('Could not launch $parsedUrl');
        }
      },
      onHover: (hovering) {
        isHoveredVariable.value = hovering;
      },
      child: Wrap( // Using Wrap for link item to handle potential overflow if linkText is long
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4.0,
        children: [
          Obx(
          ()=> Text(
              linkText,
              softWrap: true,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isHoveredVariable.value ? ColorConstants.deepBlue : ColorConstants.white.withAlpha(236)),
            ),
          ),
          Obx(() => Icon(Icons.open_in_new_rounded,
              size: 12, // Slightly larger for better visibility
              color: isHoveredVariable.value
                  ? ColorConstants.deepBlue
                  : ColorConstants.blue))
        ],
      ),
    );
  }

// Make sure this is within your OverviewTab class in overview.dart

// --- REFINED MODERN PROJECT TILE METHOD ---
// --- REFINED MODERN PROJECT TILE METHOD ---
  Widget _projectTileModernLook(
      BuildContext context,
      ProjectData project,
      double tileWidth,
      double tileHeight,
      ) {
    bool isHovered = false; // Local state for hover, managed by StatefulBuilder

    return StatefulBuilder(
      builder: (BuildContext sctx, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // print("Tapped on ${project.title}"); // Your existing print statement
              if (project.projectUrl != null && project.projectUrl!.isNotEmpty) {
                launchUrl(Uri.parse(project.projectUrl!), mode: LaunchMode.externalApplication);
              } else if (project.id != null) {
                // viewModel.navigateToProjectDetailsScreen(project.id!); // Your VM call
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200), // Slightly faster transition
              curve: Curves.easeOut,
              width: tileWidth,
              height: tileHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all( // Added border for better definition and hover effect
                  color: isHovered
                      ? ColorConstants.cyanBlue.withOpacity(0.6)
                      : ColorConstants.glassWhite.withOpacity(0.2),
                  width: isHovered ? 1.5 : 1.0,
                ),
                boxShadow: isHovered
                    ? [ // Enhanced hover shadow
                  BoxShadow(
                    color: ColorConstants.cyanBlue.withOpacity(0.2), // Using accent color for shadow
                    blurRadius: 22,
                    spreadRadius: 2,
                  ),
                  BoxShadow( // Inner subtle glow might be too much, optional
                    color: ColorConstants.glassWhite.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: -5, // Negative spread for inner effect
                  )
                ]
                    : [ // Softer default shadow
                  BoxShadow(
                    color: ColorConstants.black.withOpacity(0.10),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32), // Slightly less than container to ensure border visibility
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: isHovered ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        child: Image.asset( // In a real app, use NetworkImage for URLs or ensure assets are bundled
                          project.imageAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: ColorConstants.glassWhite.withOpacity(0.05),
                            child: Center(
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: ColorConstants.glassWhite.withOpacity(0.4), size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Gradient Overlay
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: 1.0, // Keep gradient consistent, text contrast is key
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                ColorConstants.black.withOpacity(0.1), // Lighter top part of gradient
                                ColorConstants.black.withOpacity(isHovered ? 0.90 : 0.80), // Darker for text, slightly more on hover
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.2, 0.5, 1.0], // Adjusted stops for a more gradual effect at bottom
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            project.title,
                            style: TextStyle(
                                color: ColorConstants.white.withAlpha(200),
                                fontSize: tileWidth < 220 ? 15 : 17, // Slightly adjusted font size logic
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                shadows: const [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(0,1))]
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (project.description.isNotEmpty) ...[
                            const SizedBox(height: 5), // Slightly more space
                            Text(
                              project.description,
                              style: TextStyle(
                                  color: ColorConstants.white.withOpacity(0.85), // Brighter description
                                  fontSize: tileWidth < 220 ? 11.5 : 12.5,
                                  shadows: const [Shadow(color: Colors.black54, blurRadius: 3)]
                              ),
                              maxLines: 1, // Kept at 1 line to ensure title dominance
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Hover Action Icon
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutQuint,
                      top: isHovered ? 12 : -40,
                      right: 12,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isHovered ? 1.0 : 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(8), // Slightly larger padding
                          decoration: BoxDecoration(
                              color: ColorConstants.darkGray.withOpacity(0.85), // Accent color for icon background
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorConstants.white.withOpacity(0.5), width: 1) // Brighter border for icon
                          ),
                          child: const Icon(Icons.arrow_outward_rounded,
                              color: ColorConstants.white, size: 20), // Slightly larger icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- MODERN "+N MORE" TILE METHOD ---
  Widget _moreProjectsTileModernLook(
      BuildContext context,
      int count,
      double tileWidth,
      double tileHeight,
      ) {
    bool isHovered = false;

    return StatefulBuilder(
        builder: (BuildContext sctx, StateSetter setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                viewModel.animateToProjectsTab();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: tileWidth,
                height: tileHeight,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                      color: isHovered ? ColorConstants.cyanBlue.withOpacity(0.5) : ColorConstants.glassWhite.withOpacity(0.3),
                      width: 1.5
                  ),
                  color: isHovered ? ColorConstants.glassBlue.withOpacity(0.1) : ColorConstants.glassBlack.withOpacity(0.1),
                  boxShadow: isHovered ? [
                    BoxShadow(
                      color: ColorConstants.cyanBlue.withOpacity(0.2),
                      blurRadius: 15,
                    )
                  ] : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.apps_rounded, color: ColorConstants.white.withOpacity(0.8), size: tileWidth < 180 ? 28 : 36),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "+$count",
                      style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: tileWidth < 180 ? 18 : 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "More Projects",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isHovered ? ColorConstants.cyanBlue : ColorConstants.white.withOpacity(0.7),
                        fontSize: tileWidth < 180 ? 11 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  // Placeholder for _buildViewAllTextButton

  // --- UPDATED _projectsOverviewSection METHOD ---
  Widget _projectsOverviewSection(BuildContext context) {
    // Using the project list and asset constants you provided
    final List<ProjectData> allProjects = [
      ProjectData(id: "p1", title: "Manipal Doctors", description: "Smart Assistant for Doctors", imageAsset: AssetConstants.imgManipalDoctorsThumb, projectUrl: "https://apps.apple.com/in/app/manipal-doctors/id6741423418"),
      ProjectData(id: "p6", title: "GOG - Gangs of Greenpur", description: "Sustainable Community Super App", imageAsset: AssetConstants.imgGogThumb, projectUrl: "https://play.google.com/store/apps/details?id=com.gangsofgreenpur"),
      ProjectData(id: "p2", title: "SBI General Insurance", description: "All in One Insurance App", imageAsset: AssetConstants.imgSbigThumb, projectUrl: "https://play.google.com/store/apps/details?id=com.sbig.insurance"),
      ProjectData(id: "p5", title: "Tekexcelator", description: "Sales Enablement App", imageAsset: AssetConstants.imgTekXThumb, projectUrl: "https://tekexcelrator.com"),
      ProjectData(id: "p4", title: "Plantonic", description: "An E-Commerce Application", imageAsset: AssetConstants.imgPlantonic1, projectUrl: "https://play.google.com/store/apps/details?id=co.in.plantonic"),
    ];

    // This outer padding is for the entire section before it's passed to the wrapper
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth; // Width available for projectSectionContent
            List<Widget> itemsToDisplay = [];

            const double tileIdealHeight = 230.0;
            const double tileSpacing = 16.0;
            // const double minTileWidthForCalc = 220.0; // Minimum comfortable width for a tile (used in desktop)

            if (screenWidth <= 650) { // Mobile: Vertical Column
              itemsToDisplay.clear(); // Clear any previous items
              double mobileTileWidth = screenWidth; // Tiles take full available width within the padded section
              int maxMobileTiles = 2; // Number of project tiles to show before "More Projects" tile
              // You can adjust this value or show all projects if preferred.

              List<Widget> actualTilesInColumn = [];

              for (int i = 0; i < allProjects.length; i++) {
                if (i < maxMobileTiles) {
                  actualTilesInColumn.add(
                    _projectTileModernLook(context, allProjects[i], mobileTileWidth, tileIdealHeight),
                  );
                } else {
                  break;
                }
              }

              if (allProjects.length > maxMobileTiles) {
                actualTilesInColumn.add(
                  _moreProjectsTileModernLook(context, allProjects.length - maxMobileTiles, mobileTileWidth, tileIdealHeight),
                );
              }

              // Add padding for vertical spacing in the column
              for (int i = 0; i < actualTilesInColumn.length; i++) {
                itemsToDisplay.add(
                    Padding(
                      padding: EdgeInsets.only(bottom: (i == actualTilesInColumn.length - 1) ? 0 : tileSpacing),
                      child: actualTilesInColumn[i],
                    )
                );
              }

            } else { // Desktop and Tablet: Dynamically sized Row with Flexible tiles
              itemsToDisplay.clear(); // Clear any previous items
              int numSlots;
              // Determine ideal number of slots based on available width
              if (screenWidth > 1200) { // Wider Desktop
                numSlots = 4;
              } else if (screenWidth > 850) { // Standard Desktop / Wide Tablet
                numSlots = 3;
              } else { // Tablet / Narrower Desktop (but > 650px)
                numSlots = 2;
              }
              if (numSlots < 1) numSlots = 1;


              int projectsDirectlyShown;
              bool showMoreTile;

              if (allProjects.length <= numSlots) {
                projectsDirectlyShown = allProjects.length;
                showMoreTile = false;
              } else {
                projectsDirectlyShown = numSlots - 1;
                if (projectsDirectlyShown < 1 && numSlots > 0) projectsDirectlyShown = 1;
                showMoreTile = true;
              }

              if (allProjects.isEmpty) {
                projectsDirectlyShown = 0;
                showMoreTile = false;
              }

              int totalItemsToDisplayInRow = projectsDirectlyShown + (showMoreTile ? 1 : 0);

              if (totalItemsToDisplayInRow > 0) {
                double hintTileWidth = (screenWidth - (totalItemsToDisplayInRow - 1) * tileSpacing) / totalItemsToDisplayInRow;

                for (int i = 0; i < projectsDirectlyShown; i++) {
                  if (i < allProjects.length) {
                    itemsToDisplay.add(
                        _projectTileModernLook(context, allProjects[i], hintTileWidth, tileIdealHeight)
                    );
                  }
                }

                if (showMoreTile) {
                  int remainingCount = (projectsDirectlyShown == 0 && allProjects.isNotEmpty)
                      ? allProjects.length
                      : allProjects.length - projectsDirectlyShown;
                  if (remainingCount > 0) {
                    itemsToDisplay.add(
                        _moreProjectsTileModernLook(context, remainingCount, hintTileWidth, tileIdealHeight)
                    );
                  }
                }
              }
            }

            Widget projectSectionContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0), // Increased bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Recent Works",
                          style: TextStyle(
                              fontSize: 18, // Consistent with other section titles
                              fontWeight: FontWeight.w600, // Consistent
                              color: ColorConstants.white.withAlpha(236))),
                      _buildViewAllTextButton(
                        // For hover state on this button, you'd typically use a ValueNotifier
                        // or manage state in the parent widget if _buildViewAllTextButton is stateless.
                        // For this example, using viewModel.projectsViewAllHovered.
                          isHoveredVariable: viewModel.projectsViewAllHovered,
                          onTap: () => viewModel.animateToProjectsTab(),
                          text: "View All"
                      ),
                    ],
                  ),
                ),
                if (itemsToDisplay.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        "Fresh projects coming soon!",
                        style: TextStyle(color: ColorConstants.glassWhite, fontSize: 16),
                      ),
                    ),
                  )
                else if (screenWidth <= 650) // Mobile: Render as a Column
                  Column(
                    // The itemsToDisplay list already contains Padding widgets for spacing
                    children: itemsToDisplay,
                  )
                else // Desktop/Tablet - Use Flexible children in a Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(itemsToDisplay.length, (index) {
                      return Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index == itemsToDisplay.length - 1 ? 0 : tileSpacing,
                          ),
                          child: itemsToDisplay[index],
                        ),
                      );
                    }),
                  ),
              ],
            );

            return _buildAnimatedSectionWrapper(
              visibilityFlag: viewModel.isProjectsOverviewVisible,
              sectionDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.darkBlack.withOpacity(0.15),
                      ColorConstants.deepTextBlue.withOpacity(0.15),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                  ),
                  image: DecorationImage( // Ensure this image is accessible or use a placeholder/asset
                    image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.01), BlendMode.dstATop),
                  )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0), // Wrapper's internal padding
              content: projectSectionContent,
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        // borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstants.glassWhite.withOpacity(0.04),
                border: Border.all(color: ColorConstants.glassWhite, width: 1)),
            child: Column(
              children: [
                Container(
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      _buildTopBarButton(
                          hoverVariable: viewModel.topBtnHovered,
                          onTap: () => viewModel.closeTab(0),
                          buttonColor: ColorConstants.crossRed,
                          iconData: Icons.close,
                          isCloseButton: true
                      ),
                      // const SizedBox(width: 2,),
                      _buildTopBarButton(
                          hoverVariable: viewModel.topBtnHovered,
                          onTap: () => viewModel.minimizeTab(0),
                          buttonColor: ColorConstants.minimizeYellow,
                          iconData: Icons.remove,
                          isCloseButton: false
                      ),
                    ],
                  ),
                ),
                Expanded(child: LayoutBuilder(
                  builder: (context, rootConstrains) => Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorConstants.glassBlack.withOpacity(0.1),
                          border: Border.all(
                              color: ColorConstants.glassWhite.withOpacity(0.2),
                              width: 1)
                        ),
                        child: rootConstrains.maxWidth > 1230
                            ? SingleChildScrollView(
                          controller: viewModel.scrollController,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: rootConstrains.maxWidth * 0.6,
                                      child: _leftColumn(context, rootConstrains)),
                                  Expanded(child: _rightColumn(context, rootConstrains))
                                ],
                              ),
                              // const SizedBox(height: 8,),
                              _projectsOverviewSection(context),
                              const SizedBox(height: 16,)
                            ],
                          ),
                        )
                            : ListView(
                          controller: viewModel.scrollController,
                          shrinkWrap: true,
                          children: [
                            _leftColumn(context, rootConstrains),
                            // const SizedBox(height: 8,),
                            _rightColumn(context, rootConstrains, isMobileView: true),
                            _projectsOverviewSection(context),
                            const SizedBox(height: 16,)
                          ],
                        ),
                      ),
                      Obx(() {
                        double scrollProgress = viewModel.scrollProgress.value;
                        bool isAtBottom = scrollProgress == 1.0;
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          bottom: 16,
                          right: 12,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: viewModel.isSummaryVisible.value ? 1 : 0, // Should ideally be a general page visibility flag
                            curve: Curves.easeIn,
                            child: InkWell(
                              onTap: isAtBottom
                                  ? () => viewModel.animateToExperienceTab()
                                  : () => viewModel.scrollController.animateTo(
                                  viewModel.scrollController.offset + rootConstrains.maxHeight / 1.5,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isAtBottom ? 48 : 36,
                                height: isAtBottom ? 48 : 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius:
                                  BorderRadius.circular(isAtBottom ? 16 : 16),
                                  border: Border.all(
                                      color: ColorConstants.glassWhite
                                          .withOpacity(0.4),
                                      width: 0.8),
                                ),
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: isAtBottom ? 120 : 50,
                                      height: isAtBottom ? 50 : 80,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.indicatorHighlight
                                            .withOpacity(scrollProgress),
                                        borderRadius: BorderRadius.circular(
                                            isAtBottom ? 16 : 16),
                                      ),
                                    ),
                                    isAtBottom
                                        ? AnimatedBuilder(
                                      animation: viewModel.animationController,
                                      builder: (context, child) {
                                        return Transform.translate(
                                          offset: viewModel.leftRightAnimation.value,
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        );
                                      },
                                    )
                                        : AnimatedBuilder(
                                      animation: viewModel.animationController,
                                      builder: (context, child) {
                                        return Transform.translate(
                                          offset: viewModel.upDownAnimation.value,
                                          child: const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _leftColumn(BuildContext context, BoxConstraints rootConstraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 154,
                    // margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Row(
                        children: [
                          Obx(
                                () => AnimatedContainer(
                              duration: const Duration(milliseconds: 640),
                              margin: const EdgeInsets.only(left: 75),
                              padding: const EdgeInsets.all(2),
                              height: constraints.maxHeight * viewModel.bannerHeight.value,
                              width: (constraints.maxWidth * viewModel.bannerWidth.value) > 75
                                  ? (constraints.maxWidth * viewModel.bannerWidth.value) - 75
                                  : (constraints.maxWidth * viewModel.bannerWidth.value),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(32),
                                    bottomRight: Radius.circular(32)),
                                border: Border.all(
                                    color: ColorConstants.glassWhite.withOpacity(0.6),
                                    width: 1),
                                gradient: LinearGradient(
                                    colors: [
                                      ColorConstants.glassBlack.withOpacity(0.2),
                                      ColorConstants.black.withOpacity(0.25),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.glassBlue.withAlpha(30),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 75),
                                    child: Visibility(
                                        visible: viewModel.bannerHeight.value == 1,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        child: AnimatedOpacity(
                                            duration: const Duration(seconds: 2),
                                            curve: Curves.fastOutSlowIn,
                                            opacity: viewModel.isProfileBannerOpened.value ? 1 : 0,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text("Santanu Mukherjee",
                                                    style: TextStyle(
                                                        fontSize: constraints.maxWidth > 500 ? 24 : 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstants.white.withAlpha(236),
                                                      shadows: [
                                                        Shadow(
                                                          color: ColorConstants.black.withAlpha(50),
                                                          offset: const Offset(0, 2),
                                                          blurRadius: 10,
                                                        )
                                                      ]
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text("Software Engineer",
                                                  style: TextStyle(
                                                      fontSize: constraints.maxWidth > 500 ? 16 : 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorConstants.white.withOpacity(0.8),
                                                      shadows: [
                                                        Shadow(
                                                          color: ColorConstants.black.withAlpha(50),
                                                          offset: const Offset(0, 2),
                                                          blurRadius: 10,
                                                        )
                                                      ]
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                AnimatedContainer(
                                                  width: viewModel.isProfileBannerTitleVisible.value ? (constraints.maxWidth - 75) * 0.4 : 0,
                                                  height: 1,
                                                  color: ColorConstants.white.withOpacity(0.8),
                                                  duration: const Duration(milliseconds: 300),
                                                ),
                                                const SizedBox(height: 16),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 25, right: 25),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      _buildSocialIcon(assetPath: AssetConstants.icLinkedin, url: 'https://www.linkedin.com/in/mukherjee-santanu/', isHoveredVariable: viewModel.isLinkedInIconHovered),
                                                      SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                                      _buildSocialIcon(assetPath: AssetConstants.icGithub, url: 'https://github.com/TechnicalMeaw', isHoveredVariable: viewModel.isGitHubIconHovered),
                                                      SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                                      _buildSocialIcon(assetPath: AssetConstants.icEmail, url: 'mailto:connect@santanumukherjee.com', isHoveredVariable: viewModel.isEmailIconHovered),
                                                      SizedBox(width: (constraints.maxWidth - 75) * 0.06),
                                                      _buildPhoneIcon(context),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 154,
                      width: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(77),
                        border: Border.all(width: 1, color: ColorConstants.glassWhite),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.glassBlue.withAlpha(30),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(backgroundImage: AssetImage(AssetConstants.imgProfileImage)))
                ],
              ),
              const SizedBox(height: 16),
              _buildAnimatedSectionWrapper(
                visibilityFlag: viewModel.isSummaryVisible,
                boxConstrains: const BoxConstraints(minHeight: 274),
                sectionDecoration: BoxDecoration(
                  color: ColorConstants.darkTextBlue.withOpacity(0.18),
                  image: DecorationImage(
                    image: const NetworkImage("https://images.pexels.com/photos/2569997/pexels-photo-2569997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.015), BlendMode.dstATop),
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236), shadows: [
                        Shadow(
                          color: ColorConstants.black.withAlpha(50),
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                        )
                      ]
                    )),
                    const SizedBox(height: 16),
                    Text(
                      "A results-driven Flutter and mobile engineer with a proven track record of shipping scalable, production-grade apps used by 3M+ users worldwide. I’ve helped brands modernize their tech, optimize performance, and launch features that directly improve conversions and customer experience. I work across the full stack—mobile, backend, cloud, automation—ensuring every part of the product aligns with business objectives and delivers long-term value.",
                      softWrap: true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236),
                        shadows: [
                          Shadow(
                            color: ColorConstants.black.withAlpha(80),
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                          )
                        ]
                      ),
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 32),
                    Obx(
                          () => AnimatedOpacity(
                          duration: const Duration(milliseconds: 800),
                          opacity: viewModel.isHireMeVisible.value ? 1 : 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Utils.openResumePopup(context);
                                  // final Uri url = Uri.parse('https://1drv.ms/b/c/676896353223dc87/ESCxAKK0Ip9DnuywRVuSX7oBpgXcbo2N4AOQPfgLMRFRyA?e=MvOLa1');
                                  // if (!await launchUrl(url)) { throw Exception('Could not launch $url'); }
                                },
                                onHover: (isHovered) { viewModel.isDownloadCvBtnHovered.value = isHovered; },
                                child: Obx(()=> AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: viewModel.isDownloadCvBtnHovered.value ? ColorConstants.white.withOpacity(0.8) : ColorConstants.black.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(width: 1, color: viewModel.isDownloadCvBtnHovered.value ? ColorConstants.black : ColorConstants.white),
                                    boxShadow: [ BoxShadow( color: ColorConstants.glassBlue.withOpacity(0.4), spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Text( "View Resume", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.isDownloadCvBtnHovered.value ? ColorConstants.black : ColorConstants.white.withAlpha(236)),
                                  ),
                                )),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: () { viewModel.animateToProjectsTab(); },
                                onHover: (isHovered) { viewModel.isViewProjectsBtnHovered.value = isHovered; },
                                child: Obx(
                                      () => Text(
                                        "View Projects",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: viewModel.isViewProjectsBtnHovered.value
                                              ? ColorConstants.white.withOpacity(0.95)
                                              : ColorConstants.white.withOpacity(0.75),
                                          decoration: TextDecoration.underline,
                                          decorationThickness: viewModel.isViewProjectsBtnHovered.value ? 2 : 1.2,
                                          decorationColor: viewModel.isViewProjectsBtnHovered.value
                                              ? ColorConstants.glassWhite.withOpacity(0.9)
                                              : ColorConstants.white.withOpacity(0.6),
                                          shadows: [
                                            Shadow(
                                              color: viewModel.isViewProjectsBtnHovered.value
                                                  ? ColorConstants.white.withOpacity(0.3)
                                                  : ColorConstants.black.withOpacity(0.25),
                                              offset: const Offset(0, 2),
                                              blurRadius: viewModel.isViewProjectsBtnHovered.value ? 12 : 8,
                                            ),
                                          ],
                                        ),
                                      )

                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) => Obx(
                      () => Container(
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
                          child: CarouselSlider(
                              options: CarouselOptions(
                                  height: 212.0,
                                  animateToClosest: true,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                                  viewportFraction: constraints.maxWidth > 700 ? 0.4 : 0.7,
                                  enlargeFactor: constraints.maxWidth > 700 ? 0.17 : 0.2),
                              items: [
                                _buildKpiCard(kpiValue: viewModel.kpi1Value, label: "Years Experience", isVisible: viewModel.isKPI1Visible, isHovered: viewModel.kpi1KnowMoreHovered, onTap: () => viewModel.animateToExperienceTab(), normalGradientColors: [ColorConstants.blue, ColorConstants.deepTextBlue], hoverGradientColors: [ColorConstants.blue1, ColorConstants.black], constraints: constraints),
                                _buildKpiCard(kpiValue: viewModel.kpi2Value, label: "Handled Projects", isVisible: viewModel.isKPI2Visible, isHovered: viewModel.kpi2KnowMoreHovered, onTap: () => viewModel.animateToProjectsTab(), normalGradientColors: [ColorConstants.grassGreen.withOpacity(0.8), ColorConstants.deepTextBlue], hoverGradientColors: [ColorConstants.grassGreen.withOpacity(0.7), ColorConstants.black], constraints: constraints),
                                _buildKpiCard(kpiValue: viewModel.kpi3Value, label: "Finished Apps", isVisible: viewModel.isKPI3Visible, isHovered: viewModel.kpi3KnowMoreHovered, onTap: () => viewModel.animateToProjectsTab(), normalGradientColors: [ColorConstants.deepTeal.withOpacity(0.7), ColorConstants.deepTextBlue], hoverGradientColors: [ColorConstants.deepTeal.withOpacity(0.8), ColorConstants.black], constraints: constraints),
                                _buildKpiCard(kpiValue: viewModel.kpi4Value, label: "Architected Apps", isVisible: viewModel.isKPI4Visible, isHovered: viewModel.kpi4KnowMoreHovered, onTap: () => viewModel.animateToProjectsTab(), normalGradientColors: [ColorConstants.teal.withOpacity(0.8), ColorConstants.deepTextBlue], hoverGradientColors: [ColorConstants.teal.withOpacity(0.8), ColorConstants.black],constraints: constraints),
                                _buildKpiCard(kpiValue: viewModel.kpi5Value, label: "Lines of Code", suffix: "k+", isVisible: viewModel.isKPI5Visible, isHovered: viewModel.kpi5KnowMoreHovered, onTap: () => viewModel.animateToExperienceTab(), normalGradientColors: [ColorConstants.cyanBlue.withOpacity(0.8), ColorConstants.deepTextBlue], hoverGradientColors: [ColorConstants.cyanBlue1, ColorConstants.black],constraints: constraints),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildAnimatedSectionWrapper(
                visibilityFlag: viewModel.isEducationOverviewVisible,
                sectionDecoration: BoxDecoration(
                  color: ColorConstants.darkTextBlue.withAlpha(50),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Education", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236),
                        shadows: [
                            Shadow(
                              color: ColorConstants.black.withAlpha(50),
                              offset: const Offset(0, 2),
                              blurRadius: 10,
                            )
                          ]
                        )),
                        _buildViewAllTextButton(isHoveredVariable: viewModel.educationViewAllHovered, onTap: () => viewModel.animateToExperienceTab()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(children: [ Text("Bachelor of Technology, Computer Science & Engineering",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorConstants.white.withAlpha(236),
                          shadows: [
                            Shadow(
                              color: ColorConstants.black.withAlpha(50),
                              offset: const Offset(0, 2),
                              blurRadius: 10,
                            )
                          ]
                        ))]),
                    Text("Dream Institute of Technology",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236),
                          shadows: [
                            Shadow(
                              color: ColorConstants.black.withAlpha(80),
                              offset: const Offset(0, 2),
                              blurRadius: 10,
                            )
                          ]
                        )),
                    const SizedBox(height: 2),
                    Text("2018 - 2022", style: TextStyle(fontSize: 10, color: ColorConstants.cyanBlue.withAlpha(236), fontWeight: FontWeight.w400)),
                    const SizedBox(height: 6),
                    Text("CGPA: 9.04", style: TextStyle(fontSize: 12, color: ColorConstants.white.withAlpha(236), fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: ColorConstants.black.withAlpha(80),
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                        )
                      ]
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }

  Widget _rightColumn(BuildContext context, BoxConstraints rootConstraints, {bool isMobileView = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobileView)
        const SizedBox(height: 8,),
        Padding(
          padding: isMobileView ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8) : const EdgeInsets.all(8.0),
          child: _buildAnimatedSectionWrapper(
            visibilityFlag: viewModel.isSkillsVisible,
            sectionDecoration: BoxDecoration(
                color: ColorConstants.deepTextBlue.withOpacity(0.1),
                image: DecorationImage(
                  image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.035), BlendMode.dstATop),
                )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236), shadows: [
                        Shadow(
                          color: ColorConstants.black.withAlpha(50),
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                        )
                      ]
                    )),
                    _buildViewAllTextButton( isHoveredVariable: viewModel.skillsViewAllHovered,
                        onTap: () => viewModel.animateToExperienceTab()),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Flutter", rating: viewModel.flutterSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Android development", rating: viewModel.androidSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Django", rating: viewModel.djangoSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "FastApi", rating: viewModel.fastApiSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Problem Solving", rating: viewModel.problemSolvingSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Firebase", rating: viewModel.firebaseSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Python", rating: viewModel.pythonSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "DSA", rating: viewModel.dsaSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "AWS", rating: viewModel.awsSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Kotlin", rating: viewModel.kotlinSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Dart", rating: viewModel.dartSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Java", rating: viewModel.javaSkillRating.value)),
                const SizedBox(height: 16),
                Obx(()=> skillRatingWidget(skillName: "Git", rating: viewModel.gitSkillRating.value)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        SizedBox(height: isMobileView ? 16 : 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildAnimatedSectionWrapper(
            visibilityFlag: viewModel.isKPI1Visible,
            sectionDecoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorConstants.black.withOpacity(0.7),
                    ColorConstants.darkTextBlue.withOpacity(0.8),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            padding: const EdgeInsets.all(32),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white)),
                const SizedBox(height: 16),
                _buildLinkItem(linkText: "SBI General Insurance", url: 'https://play.google.com/store/apps/details?id=com.sbig.insurance', isHoveredVariable: viewModel.link1Hovered),
                _buildLinkItem(linkText: "Manipal Doctors", url: 'https://apps.apple.com/in/app/manipal-doctors/id6741423418', isHoveredVariable: viewModel.link2Hovered),
                _buildLinkItem(linkText: "Care Health Insurance", url: 'https://play.google.com/store/apps/details?id=com.religare.healthinsurance', isHoveredVariable: viewModel.link3Hovered),
                _buildLinkItem(linkText: "Canara HSBC Life Insurance", url: 'https://play.google.com/store/apps/details?id=com.choiceapp.genius&hl=en_IN', isHoveredVariable: viewModel.link4Hovered),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget skillRatingWidget({required String skillName, required int rating}) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: 28,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  width: constraints.maxWidth,
                  height: 4.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 0.8, color: ColorConstants.glassBlue.withOpacity(0.6)))),
            ),
            Positioned(
              bottom: 0.8,
              left: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 40),
                curve: Curves.easeIn,
                width: constraints.maxWidth * rating * 0.01,
                child: Column(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      opacity: rating > 20 ? 1 : 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2, right: 10),
                            child: Text("$rating%",
                                softWrap: true,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236), shadows: [
                                  Shadow(
                                      offset: const Offset(0.0, 2.0),
                                      blurRadius: 15.0,
                                      color: ColorConstants.textBlue.withAlpha(150)),
                                  Shadow(
                                      offset: const Offset(0.0, 2.0),
                                      blurRadius: 15.0,
                                      color: ColorConstants.black.withAlpha(150))
                                ]),
                                overflow: TextOverflow.visible),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ColorConstants.textBlue.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 0))
                          ],
                          gradient: LinearGradient(
                              colors: [
                                ColorConstants.glassWhite,
                                ColorConstants.cyanBlue.withOpacity(0.8),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: const [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(4),
                          color: ColorConstants.darkBlack),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(skillName,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.white.withAlpha(236),
                        shadows: <Shadow>[
                          Shadow(
                              offset: const Offset(0.0, 2.0),
                              blurRadius: 15.0,
                              color: ColorConstants.textBlue.withAlpha(150)),
                          Shadow(
                              offset: const Offset(0.0, 2.0),
                              blurRadius: 15.0,
                              color: ColorConstants.black.withAlpha(150))
                        ]),
                    overflow: TextOverflow.visible),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The ProjectData class definition was moved to the top of the file for better organization.