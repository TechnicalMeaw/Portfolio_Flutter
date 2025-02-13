import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/tabs/education.dart';
import 'package:portfolio/ui/tabs/experience.dart';
import 'package:portfolio/ui/tabs/overview.dart';
import 'package:portfolio/ui/tabs/projects.dart';
import 'package:portfolio/view_model/base_controller.dart';
import 'package:portfolio/view_model/tabs/education_tab_view_model.dart';
import 'package:portfolio/view_model/tabs/experience_tab_view_model.dart';
import 'package:portfolio/view_model/tabs/overview_tab_view_model.dart';
import 'package:portfolio/view_model/tabs/projects_tab_view_model.dart';

class HomePageViewModel extends BaseGetXController with GetTickerProviderStateMixin{
  RxBool isOverviewBtnHovered = false.obs;
  RxBool isExperienceBtnHovered = false.obs;
  RxBool isProjectsBtnHovered = false.obs;
  RxBool isEducationBtnHovered = false.obs;
  // late TabController tabController;
  late Timer _timer;

  // late final List<Widget> allTabs;
  // final OverviewTabViewModel overviewTabViewModel = Get.put(OverviewTabViewModel());

  RxBool isOptionsGithubHovered = false.obs;
  RxBool isOptionsLinkedInHovered = false.obs;
  RxBool isOptionsEmailHovered = false.obs;
  RxBool isOptionsPhoneHovered = false.obs;
  RxBool isOptionsDownloadCVHovered = false.obs;

  late AnimationController overviewAnimationController;
  Rx<Animation<double>?> overviewScaleAnimation = Rx<Animation<double>?>(null);
  Rx<Animation<double>?> overviewOpacityAnimation = Rx<Animation<double>?>(null);
  Future? initialAction;

  @override
  void onInit() {

    // allTabs = <Widget>[
    //   OverviewTab(viewModel: overviewTabViewModel),
    //   const ExperienceTab(),
    //   const ExperienceTab(),
    //   const ExperienceTab(),
    // ];
    BaseGetXController.overviewTabViewModel = Get.put(OverviewTabViewModel());
    BaseGetXController.experienceTabViewModel = Get.put(ExperienceTabViewModel());
    BaseGetXController.projectsTabViewModel = Get.put(ProjectsTabViewModel());
    BaseGetXController.educationTabViewModel = Get.put(EducationTabViewModel());

    allTabs = <Widget>[
      OverviewTab(viewModel: BaseGetXController.overviewTabViewModel),
      ExperienceTab(viewModel: BaseGetXController.experienceTabViewModel,),
      ProjectsTab(viewModel: BaseGetXController.projectsTabViewModel,),
      EducationTab(viewModel: BaseGetXController.educationTabViewModel,),
    ];

    BaseGetXController.tabController = TabController(vsync: this, length: allTabs.length);


    //TODO Remove this line
    // Future.delayed(const Duration(milliseconds: 350), () {
    //   animateToOverviewTab();
    // });

    // animateToProjectsTab();
    // animateToExperienceTab();
    // animateToEducationTab();

    // BaseGetXController.tabController.addListener(() {
    //   switch(BaseGetXController.tabController.index){
    //     case 0:
    //       animateToOverviewTab();
    //       break;
    //     case 1:
    //       animateToExperienceTab();
    //       break;
    //     case 2:
    //       animateToProjectsTab();
    //       break;
    //     case 3:
    //       animateToEducationTab();
    //       break;
    //   }
    // });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateCurrentTime());
    // tabController = TabController(vsync: this, length: allTabs.length);

    /// Initial Animation
    overviewAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    overviewScaleAnimation.value = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: overviewAnimationController, curve: Curves.easeInOut),
    );

    overviewOpacityAnimation.value = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: overviewAnimationController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      isOverviewBtnHovered.value = true;
      initialAction = Future.delayed(const Duration(milliseconds: 5200), () {
        if (overviewAnimationController.isAnimating){
          overviewAnimationController.stop(); // Stop animation after 5s
          overviewScaleAnimation.value = null;
          overviewOpacityAnimation.value = null;
          animateToOverviewTab();
          isOverviewBtnHovered.value = false;
        }
      });
    });


    super.onInit();
  }

  // @override
  // void animateToOverviewTab() {
  //   overviewTabViewModel.animateToOverviewTab();
  //   super.animateToOverviewTab();
  // }
  //
  // @override
  // void animateToExperienceTab() {
  //   experienceTabViewModel.animateToExperienceTab();
  //   super.animateToExperienceTab();
  // }

  Rx<Color> mainWidgetColor = Rx<Color>(ColorConstants.transparent);
  DateTime now = DateTime.now();
  RxString currentTime = "".obs;

  void _updateCurrentTime() {
    now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a').format(now);
  }

  @override
  void onClose() {
    overviewAnimationController.dispose();
    super.onClose();
  }
}