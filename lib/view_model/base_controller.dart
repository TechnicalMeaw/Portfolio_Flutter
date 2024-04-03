import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/ui/tabs/experience.dart';
import 'package:portfolio/ui/tabs/overview.dart';
import 'package:portfolio/view_model/tabs/overview_tab_view_model.dart';

abstract class BaseGetXController extends GetxController with GetSingleTickerProviderStateMixin{

  static late TabController tabController;
  late final List<Widget> allTabs;

  static final List<RxBool> _allTabsStackStatus = [false.obs, false.obs, false.obs, false.obs];
  static final List<RxBool> _backgroundTabsStackStatus = [false.obs, false.obs, false.obs, false.obs];
  static RxInt currentTab = 100.obs;

  void animateToOverviewTab(){
    _allTabsStackStatus[0].value = true;
    if(currentTab.value <4 ) {
      _backgroundTabsStackStatus[currentTab.value].value = true;
    }
    _backgroundTabsStackStatus[0].value = false;
    currentTab.value = 0;
    if(tabController.index != 0) {
      tabController.animateTo(0);
    }
  }

  void animateToExperienceTab(){
    _allTabsStackStatus[1].value = true;

    if(currentTab.value <4 ) {
      _backgroundTabsStackStatus[currentTab.value].value = true;
    }
    _backgroundTabsStackStatus[1].value = false;
    currentTab.value = 1;
    tabController.animateTo(1);
  }

  void animateToProjectsTab(){
    _allTabsStackStatus[2].value = true;
    _backgroundTabsStackStatus[2].value = false;
    if(currentTab.value <4 ) {
      _backgroundTabsStackStatus[currentTab.value].value = true;
    }
    currentTab.value = 2;
    tabController.animateTo(2);
  }

  void animateToEducationTab(){
    _allTabsStackStatus[3].value = true;
    _backgroundTabsStackStatus[3].value = false;
    if(currentTab.value <4 ) {
      _backgroundTabsStackStatus[currentTab.value].value = true;
    }
    currentTab.value = 3;
    tabController.animateTo(3);
  }


  void closeTab(int tabIndex){
    _allTabsStackStatus[tabIndex].value = false;
    _backgroundTabsStackStatus[tabIndex].value = false;
    currentTab.value = 100;
    // tabController.animateTo();
  }

  void minimizeTab(int tabIndex){
    _allTabsStackStatus[tabIndex].value = true;
    _backgroundTabsStackStatus[tabIndex].value = true;
    currentTab.value = 100;
  }

  RxBool isTabInMemoryStack(int tabIndex){
    return _allTabsStackStatus[tabIndex];
  }

  RxBool isTabInBackground(int tabIndex){
    return _backgroundTabsStackStatus[tabIndex];
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}