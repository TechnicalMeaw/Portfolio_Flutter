import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/tabs/experience.dart';
import 'package:portfolio/ui/tabs/overview.dart';
import 'package:portfolio/view_model/base_controller.dart';
import 'package:portfolio/view_model/tabs/experience_tab_view_model.dart';
import 'package:portfolio/view_model/tabs/overview_tab_view_model.dart';

class HomePageViewModel extends BaseGetXController {
  RxBool isOverviewBtnHovered = false.obs;
  RxBool isExperienceBtnHovered = false.obs;
  RxBool isProjectsBtnHovered = false.obs;
  RxBool isEducationBtnHovered = false.obs;
  // late TabController tabController;
  late Timer _timer;

  late final OverviewTabViewModel overviewTabViewModel;
  late final ExperienceTabViewModel experienceTabViewModel;

  // late final List<Widget> allTabs;
  // final OverviewTabViewModel overviewTabViewModel = Get.put(OverviewTabViewModel());


  @override
  void onInit() {

    // allTabs = <Widget>[
    //   OverviewTab(viewModel: overviewTabViewModel),
    //   const ExperienceTab(),
    //   const ExperienceTab(),
    //   const ExperienceTab(),
    // ];
    overviewTabViewModel = Get.put(OverviewTabViewModel());
    experienceTabViewModel = Get.put(ExperienceTabViewModel());
    allTabs = <Widget>[
      OverviewTab(viewModel: overviewTabViewModel),
      ExperienceTab(viewModel: experienceTabViewModel,),
      ExperienceTab(viewModel: experienceTabViewModel,),
      ExperienceTab(viewModel: experienceTabViewModel,),
    ];

    BaseGetXController.tabController = TabController(vsync: this, length: allTabs.length);


    //TODO Remove this line
    animateToExperienceTab();

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

  @override
  void animateToOverviewTab() {
    overviewTabViewModel.animateToOverviewTab();
    super.animateToOverviewTab();
  }

  Rx<Color> mainWidgetColor = Rx<Color>(ColorConstants.transparent);
  DateTime now = DateTime.now();
  RxString currentTime = "".obs;

  void _updateCurrentTime() {
    now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a').format(now);
  }
}