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

class HomePageViewModel extends BaseGetXController {
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
    // animateToOverviewTab();
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
}