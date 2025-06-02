import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/widgets/projects/project_widget.dart';
import 'package:portfolio/view_model/tabs/projects_tab_view_model.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key, required this.viewModel});

  final ProjectsTabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConstants.glassWhite.withOpacity(0.1),
            border: Border.all(color: ColorConstants.glassWhite, width: 1),
          ),
          child: Column(
            children: [
              _buildTopWidget(),
              _buildMainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopWidget() {
    return Container(
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          _buildControlButton(
            isHovered: viewModel.crossBtnHovered,
            color: ColorConstants.crossRed,
            icon: Icons.close,
            onTap: () {
              viewModel.closeTab(2);
              viewModel.crossBtnHovered.value = false;
            },
          ),
          _buildControlButton(
            isHovered: viewModel.minimizeBtnHovered,
            color: ColorConstants.minimizeYellow,
            icon: Icons.remove,
            onTap: () {
              viewModel.minimizeTab(2);
              viewModel.minimizeBtnHovered.value = false;
            },
            leftMargin: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required RxBool isHovered,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
    double leftMargin = 0,
  }) {
    return InkWell(
      onTap: onTap,
      onHover: (hover) => isHovered.value = hover,
      child: Obx(
            () => AnimatedContainer(
          margin: EdgeInsets.only(
            left: isHovered.value ? leftMargin : leftMargin + 2,
            right: isHovered.value ? 0 : 2,
          ),
          height: isHovered.value ? 12 : 8,
          width: isHovered.value ? 12 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: color,
          ),
          duration: const Duration(milliseconds: 125),
          child: isHovered.value
              ? Icon(icon, size: 10)
              : const SizedBox(height: 8, width: 8),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              color: ColorConstants.glassBlack.withOpacity(0.1),
              child: ListView(
                controller: viewModel.scrollController,
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 16),

                  // Blue Project
                  ProjectWidget(
                    viewModel: viewModel,
                    projectData: _getManipalDoctorsData(),
                    style: ProjectStyle.blue,
                    isVisible: viewModel.isProject1Visible,
                    imageVisible: viewModel.isProject1ImageVisible,
                    descVisible: viewModel.isProject1DescVisible,
                    buttonHovered: viewModel.isProject1KnowMoreBtnHovered,
                    projectAlignment: ProjectAlignment.leftThumb,
                  ),

                  const SizedBox(height: 32),

                  // Blue Project
                  ProjectWidget(
                    viewModel: viewModel,
                    projectData: _getSbigData(),
                    style: ProjectStyle.violet,
                    isVisible: viewModel.isProject2Visible,
                    imageVisible: viewModel.isProject2ImageVisible,
                    descVisible: viewModel.isProject2DescVisible,
                    buttonHovered: viewModel.isProject2KnowMoreBtnHovered,
                    projectAlignment: ProjectAlignment.rightThumb,
                  ),

                  const SizedBox(height: 32),

                  // Violet Project
                  ProjectWidget(
                    viewModel: viewModel,
                    projectData: _getPlantonic1Data(),
                    style: ProjectStyle.blue,
                    isVisible: viewModel.isProject3Visible,
                    imageVisible: viewModel.isProject3ImageVisible,
                    descVisible: viewModel.isProject3DescVisible,
                    buttonHovered: viewModel.isProject3KnowMoreBtnHovered,
                    projectAlignment: ProjectAlignment.leftThumb,
                  ),

                  const SizedBox(height: 32),
                  // Blue Project
                  ProjectWidget(
                    viewModel: viewModel,
                    projectData: _getTekXData(),
                    style: ProjectStyle.violet,
                    isVisible: viewModel.isProject4Visible,
                    imageVisible: viewModel.isProject4ImageVisible,
                    descVisible: viewModel.isProject4DescVisible,
                    buttonHovered: viewModel.isProject4KnowMoreBtnHovered,
                    projectAlignment: ProjectAlignment.rightThumb,
                  ),


                  const SizedBox(height: 32),

                  // Blue Project
                  ProjectWidget(
                    viewModel: viewModel,
                    projectData: _getGogData(),
                    style: ProjectStyle.blue,
                    isVisible: viewModel.isProject5Visible,
                    imageVisible: viewModel.isProject5ImageVisible,
                    descVisible: viewModel.isProject5DescVisible,
                    buttonHovered: viewModel.isProject5KnowMoreBtnHovered,
                    projectAlignment: ProjectAlignment.leftThumb,
                  ),


                  const SizedBox(height: 32),

                  // Coming Soon
                  _buildComingSoonWidget(),

                  const SizedBox(height: 100),
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
                  opacity: viewModel.isProject2Visible.value ? 1: 0,
                  curve: Curves.easeIn,
                  child: InkWell(
                    onTap: isAtBottom ? () => viewModel.animateToEducationTab() :
                        ()=> viewModel.scrollController.animateTo(viewModel.scrollController.offset + constraints.maxHeight/1.5, duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isAtBottom ? 48 : 36,
                      height: isAtBottom ? 48 : 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(isAtBottom ? 16 : 16),
                        border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
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
                              color: ColorConstants.indicatorHighlight.withOpacity(scrollProgress),
                              borderRadius: BorderRadius.circular(isAtBottom ? 16 : 16),
                            ),
                          ),
                          isAtBottom ?
                          //     ? Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: const [
                          //     Text("Experience", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          //     SizedBox(width: 5),
                          //     Icon(Icons.arrow_forward, color: Colors.white),
                          //   ],
                          // )
                          AnimatedBuilder(
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
      ),
    );
  }

  Widget _buildComingSoonWidget() {
    return Obx(
          () => AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: viewModel.isComingSoonVisible.value ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: ColorConstants.glassBlack.withOpacity(0.4),
              border: Border.all(
                color: ColorConstants.glassBlack.withOpacity(0.4),
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text("More Projects Coming Soon", style: TextStyle(color: ColorConstants.glassWhite),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ProjectData _getPlantonic1Data() {
    return ProjectData(
      title: "Plantonic",
      subtitle: "An E-Commerce Application",
      year: "2023 - 2024",
      imageAsset: AssetConstants.imgPlantonic1,
      imageUrl: "https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bulletPoints: [
        "End-to-end plant shopping e-commerce application",
        "Search plants, mark favorites, add to cart, and track orders seamlessly",
        "Smooth order processing and inventory management through admin app",
        "User authentication with phone number and Google OAuth with AES-256 encryption for secure data transfer",
      ],
      actionUrl: "https://play.google.com/store/apps/details?id=co.in.plantonic",
      actionText: "View Project",
    );
  }

  ProjectData _getGogData() {
    return ProjectData(
      title: "GOG - Gangs of Greenpur",
      subtitle: "Sustainable Community Super App",
      year: "2024 - 2025",
      imageAsset: AssetConstants.imgGogThumb,
      // imageUrl: "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg",
      imageUrl: "https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bulletPoints: [
        "Unified mobile platform for event discovery, stay bookings, unique experiences, and community commerce",
        "Engage in community-driven posts and comments, and connect with others via real-time chat",
        "Book curated stays and local experiences with real-time updates and a seamless user experience",
        "Secure phone number-based authentication with AES-256 encrypted data transfer"
      ],
      actionUrl: "https://play.google.com/store/apps/details?id=com.gangsofgreenpur",
      actionText: "View Project",
    );
  }


  ProjectData _getSbigData() {
    return ProjectData(
      title: "SBI General Insurance",
      subtitle: "All in One Insurance App",
      year: "2022 - 2024",
      imageAsset: AssetConstants.imgSbigThumb,
      // imageUrl: "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg",
      imageUrl: "https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bulletPoints: [
        "Integrated the new Health Edge insurance product into the app, enhancing product offerings",
        "Independently upgraded SBIG’s PWA to the latest codebase and resolved critical payment gateway issues",
        "Built dynamic forms to capture critical insured member data with precision",
        "Implemented Firebase Analytics to enable data-driven insights through user interaction tracking"
      ],
      actionUrl: "https://play.google.com/store/apps/details?id=com.sbig.insurance",
      actionText: "View Project",
    );
  }

  ProjectData _getTekXData() {
    return ProjectData(
      title: "Tekexcelator",
      subtitle: "Sales Enablement App",
      year: "2023 - 2024",
      imageAsset: AssetConstants.imgTekXThumb,
      // imageUrl: "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg",
      imageUrl: "https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bulletPoints: [
        "Solely developed the Tekexcelator app from scratch with pixel-perfect UI, fluid animations, and seamless API integration",
        "Implemented core modules including punch in/out, barcode-based sales logging, incentive tracking, feedback, and secure location-based authentication",
        "Adapted quickly to evolving requirements with ongoing updates and agile iterations",
        "Ensured responsive design across screen sizes and handled edge cases with robust state management using GetX"
      ],
      actionUrl: "https://tekexcelrator.com",
      actionText: "View Project",
    );
  }

  ProjectData _getManipalDoctorsData() {
    return ProjectData(
      title: "Manipal Doctors",
      subtitle: "Smart Assistant for Doctors",
      year: "2024 - 2025",
      imageAsset: AssetConstants.imgManipalDoctorsThumb,
      // imageUrl: "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg",
      imageUrl: "https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bulletPoints: [
        "Built an all-in-one app for doctors to manage appointments, patient data, and hospital collaborations",
        "Enabled secure mPIN login with real-time access to vitals, labs, meds, and clinical notes",
        "Integrated smart, deep-linked notifications for labs, critical vitals, and schedules",
        "Designed clean UI with graphs and reports to track patient progress effortlessly"
      ],
      actionUrl: "https://apps.apple.com/in/app/manipal-doctors/id6741423418",
      actionText: "View Project",
    );
  }
}