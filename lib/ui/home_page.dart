import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';

import 'package:portfolio/view_model/base_controller.dart';
import 'package:portfolio/view_model/home/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageViewModel _viewModel = Get.put(HomePageViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              AssetConstants.imgBackgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          Align(alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text("Hey,", style: TextStyle(color: ColorConstants.glassWhite, fontSize: 16),),
              Text("Welcome to my portfolio!", textAlign: TextAlign.center, style: TextStyle(color: ColorConstants.glassWhite, fontSize: 16, fontWeight: FontWeight.w700),),
              const SizedBox(height: 4,),
              Text("Consider using desktop for better experience.", textAlign: TextAlign.center, style: TextStyle(color: ColorConstants.glassWhite, fontSize: 14, fontWeight: FontWeight.w600),),
              // const SizedBox(height: 2,),
              Text("This is a simulation of Linux based Operating System, feel free to explore!", textAlign: TextAlign.center, style: TextStyle(color: ColorConstants.glassWhite, fontSize: 12),),
              const SizedBox(height: 10,),

              Text("Created with 💗 by Santanu.", textAlign: TextAlign.center, style: TextStyle(color: ColorConstants.glassWhite, fontSize: 12),),
            ],
          ),
          ),
          // ClipRect(
          // child: BackdropFilter(
          // filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //   ),
          //           )),
          _topStatusBarWidget(currentTime: _viewModel.currentTime),
          Align(alignment: Alignment.topCenter, child: _mainWidget(_viewModel)),
          _bottomMainTabs(_viewModel)
        ],
      ),
    );
  }
}

Widget _topStatusBarWidget({required RxString currentTime}) {
  return Align(
    alignment: Alignment.topCenter,
    child:
    ClipRect(
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  child:
    Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                ColorConstants.deepBlue.withOpacity(0.5),
                ColorConstants.textBlue,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(2),
          color: ColorConstants.darkBlack),
      child: LayoutBuilder(
        builder: (context, constrains) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            constrains.maxWidth > 500
                ? const Row(
                    children: [
                      Text(
                        "GitHub",
                        style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: ColorConstants.glassBlack, fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "LinkedIn",
                        style: TextStyle(color: ColorConstants.white,  fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: ColorConstants.glassBlack,  fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: ColorConstants.glassBlack,  fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(color: ColorConstants.white,  fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: ColorConstants.glassBlack, fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Download Resume",
                        style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  )
                : const Text(
                    "Contact Me",
                    style: TextStyle(color: ColorConstants.white),
                  ),
            Obx(
              () => Text(currentTime.value,
                  style: const TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12)),
            )
          ],
        ),
      ),
    ),))
  );
}

Widget _bottomMainTabs(HomePageViewModel viewModel) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child:Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              // color: ColorConstants.lightGlassBlue,
            gradient: LinearGradient(
              colors: [
                ColorConstants.glassBlue.withAlpha(100),
                ColorConstants.lightGlassBlue.withAlpha(120),
              ],
              begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _mainTabWidget(
                  logo: AssetConstants.icOverview,
                  isHovered: viewModel.isOverviewBtnHovered,
                  toolTipText: "Overview",
                  isInMemoryStack: viewModel.isTabInMemoryStack(0),
                  currentTab: BaseGetXController.currentTab,
                  index: 0,
                  onClick: () {
                    viewModel.animateToOverviewTab();
                  }),
              const SizedBox(
                width: 5,
              ),
              _mainTabWidget(
                  logo: AssetConstants.icExperience,
                  isHovered: viewModel.isExperienceBtnHovered,
                  toolTipText: "Experience",
                  isInMemoryStack: viewModel.isTabInMemoryStack(1),
                  currentTab: BaseGetXController.currentTab,
                  index: 1,
                  onClick: () {
                    viewModel.animateToExperienceTab();
                  }),
              const SizedBox(
                width: 5,
              ),
              _mainTabWidget(
                  logo: AssetConstants.icProjects,
                  isHovered: viewModel.isProjectsBtnHovered,
                  toolTipText: "Projects",
                  isInMemoryStack: viewModel.isTabInMemoryStack(2),
                  currentTab: BaseGetXController.currentTab,
                  index: 2,
                  onClick: () {
                    viewModel.animateToProjectsTab();
                  }),
              const SizedBox(
                width: 5,
              ),
              _mainTabWidget(
                  onClick: () {
                    // viewModel.tabController.animateTo(3);
                    // viewModel.currentTab.value = 4;
                    viewModel.animateToEducationTab();
                  },
                  logo: AssetConstants.icEducation,
                  isHovered: viewModel.isEducationBtnHovered,
                  toolTipText: "Education",
                isInMemoryStack: viewModel.isTabInMemoryStack(3),
                currentTab: BaseGetXController.currentTab,
                index: 3,
              ),
            ],
          ),
        )))
      ],
    ),
  );
}

Widget _mainTabWidget(
    {required RxBool isHovered,
    required String toolTipText,
    required String logo,
    required RxBool isInMemoryStack,
    required RxInt currentTab,
    required int index,
    Function()? onClick}) {
  return Tooltip(
    message: toolTipText,
    margin: const EdgeInsets.only(bottom: 15),
    child: Obx(
      () => InkWell(
        onTap: () {
          // isHovered.value = false;
          if (onClick != null) {
            onClick();
          }
        },
        onHover: (hovered){
          isHovered.value = hovered;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          height: isHovered.value ? 55 : 45,
          width: isHovered.value ? 55 : 45,
          padding: EdgeInsets.all(2),
          margin: isHovered.value
              ? const EdgeInsets.symmetric(horizontal: 4.5)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
              color: isHovered.value
                  // ? ColorConstants.white.withAlpha(80)
                  // : ColorConstants.white.withAlpha(80),
                  ? ColorConstants.glassBlack.withAlpha(50)
                  : ColorConstants.glassWhite.withAlpha(50),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 1.0),
                child: Image.asset(
                  logo,
                  fit: BoxFit.cover,
                ),
              ),
              isInMemoryStack.value ? Container(height: 3,
                  width: currentTab.value == index? 11 : 5.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5),
                  color: ColorConstants.glassWhite,),
                ): const SizedBox(height: 3,)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _mainWidget(HomePageViewModel viewModel) {
  return Obx(
      () => Container(
          margin: const EdgeInsets.only(bottom: 70, top: 26, left: 2, right: 2),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: ColorConstants.black,)),
          child: BaseGetXController.currentTab.value > 3 ? const Offstage()
              : TabBarView(
                  controller: BaseGetXController.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: viewModel.allTabs,
          )
        ),
  );
}
