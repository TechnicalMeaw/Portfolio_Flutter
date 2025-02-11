import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';

import 'package:portfolio/view_model/base_controller.dart';
import 'package:portfolio/view_model/home/home_page_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Align(alignment: Alignment.topCenter, child: _mainWidget(_viewModel, context)),
          _bottomMainTabs(_viewModel, context)
        ],
      ),
    );
  }
  Widget _topStatusBarWidget({required RxString currentTime}) {
    return Align(
        alignment: Alignment.topCenter,
        child:
        ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
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
                          ? Obx(
                            ()=> Row(children: [
                            InkWell(
                              onHover: (isHovered){
                                _viewModel.isOptionsGithubHovered.value = isHovered;
                              },
                              onTap: () async {
                                final Uri url = Uri.parse('https://github.com/TechnicalMeaw');
                                if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "GitHub",
                                style: TextStyle(color: _viewModel.isOptionsGithubHovered.value ? ColorConstants.black : ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                              ),
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
                            InkWell(
                              onHover: (isHovered) {
                                _viewModel.isOptionsLinkedInHovered.value = isHovered;
                              },
                              onTap: () async {
                                final Uri url = Uri.parse('https://www.linkedin.com/in/mukherjee-santanu/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "LinkedIn",
                                style: TextStyle(color: _viewModel.isOptionsLinkedInHovered.value ? ColorConstants.black : ColorConstants.white,  fontWeight: FontWeight.w400, fontSize: 12),
                              ),
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
                            InkWell(
                              onHover: (isHovered) {
                                _viewModel.isOptionsEmailHovered.value = isHovered;
                              },
                              onTap: () async {
                                final Uri url = Uri.parse('mailto:santanumukherjeebh@gmail.com');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "Email",
                                style: TextStyle(color: _viewModel.isOptionsEmailHovered.value ? ColorConstants.black : ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                              ),
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
                            InkWell(
                              onHover: (isHovered) {
                                _viewModel.isOptionsPhoneHovered.value = isHovered;
                              },
                              onTap: () async {
                                // viewModel.isPhoneNumberCopied.value = true;
                                const snackBar = SnackBar(
                                  content: Text('Phone number copied.', style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400),),
                                  backgroundColor: ColorConstants.glassBlue,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                final Uri url = Uri.parse('tel://+918240251373');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "Phone",
                                style: TextStyle(color: _viewModel.isOptionsPhoneHovered.value ? ColorConstants.black : ColorConstants.white,  fontWeight: FontWeight.w400, fontSize: 12),
                              ),
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
                            InkWell(
                              onHover: (isHovered) {
                                _viewModel.isOptionsDownloadCVHovered.value = isHovered;
                              },
                              onTap: () async {
                                final Uri url = Uri.parse('https://1drv.ms/b/c/676896353223dc87/ESCxAKK0Ip9DnuywRVuSX7oBpgXcbo2N4AOQPfgLMRFRyA?e=MvOLa1');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "Download Resume",
                                style: TextStyle(color: _viewModel.isOptionsDownloadCVHovered.value ? ColorConstants.black : ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                            ),
                                                    ],
                                                  ),
                          )
                          :  InkWell(
                              onHover: (isHovered) {
                                _viewModel.isOptionsDownloadCVHovered.value = isHovered;
                              },
                              onTap: () async {
                                final Uri url = Uri.parse('https://1drv.ms/b/s!AofcIzI1lmhnhLlwwjJGyPUD6OicEg?e=vUoFsM');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                "Download Resume",
                                style: TextStyle(color: _viewModel.isOptionsDownloadCVHovered.value ? ColorConstants.black : ColorConstants.white, fontWeight: FontWeight.w400, fontSize: 12),
                              ),
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
}



Widget _bottomMainTabs(HomePageViewModel viewModel, BuildContext context) {
  return Align(
    alignment: MediaQuery.of(context).size.width < 700 ? Alignment.bottomCenter : Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width < 700 ? 0 : 5.0, bottom: MediaQuery.of(context).size.width < 700 ? 5 : 0),
      child: Row(
        mainAxisAlignment: MediaQuery.of(context).size.width < 700 ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child:Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            // margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.glassWhite),
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
            child: MediaQuery.of(context).size.width < 700 ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: menuItems(viewModel, context),
            ) :
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: menuItems(viewModel, context),
            ),
          )))
        ],
      ),
    ),
  );
}

List<Widget> menuItems(HomePageViewModel viewModel, BuildContext context) =>
    [
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
      SizedBox(
        height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
        width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
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
      SizedBox(
        height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
        width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
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
      SizedBox(
        height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
        width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
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
    ];

Widget _mainTabWidget(
    {required RxBool isHovered,
    required String toolTipText,
    required String logo,
    required RxBool isInMemoryStack,
    required RxInt currentTab,
    required int index,
    Function()? onClick}) {
  return Obx(
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
        height: isHovered.value ? 62 : 56,
        width: isHovered.value ? 57 : 49,
        padding: EdgeInsets.all(2),
        margin: isHovered.value
            ? const EdgeInsets.symmetric(horizontal: 4.5)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
            color: isHovered.value
                // ? ColorConstants.white.withAlpha(80)
                // : ColorConstants.white.withAlpha(80),
                ? ColorConstants.glassBlack
                : ColorConstants.glassBlack.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.5), width: 0.8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 1.0),
              child: Image.asset(
                logo,
                fit: BoxFit.cover,
                height: isHovered.value ? 24 : null,
              ),
            ),

            isHovered.value ? Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(toolTipText, style: const TextStyle(fontSize: 9.5, color: ColorConstants.white, fontWeight: FontWeight.w300),),
            ) : Offstage(),

            isInMemoryStack.value ? Container(height: 3,
                width: currentTab.value == index? 11 : 5.5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5),
                color: ColorConstants.glassWhite,),
              ): const SizedBox(height: 3,)
          ],
        ),
      ),
    ),
  );
}

Widget _mainWidget(HomePageViewModel viewModel, BuildContext context) {
  return Obx(
      () => Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width < 700 ? 81.5 : 2, top: 26, left: MediaQuery.of(context).size.width < 700 ? 2 : 78, right: 2),
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
