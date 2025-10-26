import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:portfolio/view_model/base_controller.dart';

class ProjectsTabViewModel extends BaseGetXController {
  RxDouble scrollProgress = 0.0.obs;
  ScrollController scrollController = ScrollController();

  RxBool topBtnHovered = false.obs;

  RxBool isAnimationCompleted = true.obs;

  RxBool isProject1Visible = false.obs;
  RxBool isProject1ImageVisible = false.obs;
  RxBool isProject1DescVisible = false.obs;

  RxBool isProject2Visible = false.obs;
  RxBool isProject2ImageVisible = false.obs;
  RxBool isProject2DescVisible = false.obs;

  RxBool isProject3Visible = false.obs;
  RxBool isProject3ImageVisible = false.obs;
  RxBool isProject3DescVisible = false.obs;

  RxBool isProject4Visible = false.obs;
  RxBool isProject4ImageVisible = false.obs;
  RxBool isProject4DescVisible = false.obs;

  RxBool isProject5Visible = false.obs;
  RxBool isProject5ImageVisible = false.obs;
  RxBool isProject5DescVisible = false.obs;

  RxBool isComingSoonVisible = false.obs;

  RxBool isProject1KnowMoreBtnHovered = false.obs;
  RxBool isProject2KnowMoreBtnHovered = false.obs;
  RxBool isProject3KnowMoreBtnHovered = false.obs;
  RxBool isProject4KnowMoreBtnHovered = false.obs;
  RxBool isProject5KnowMoreBtnHovered = false.obs;

  @override
  void animateToProjectsTab() {
    print("ExperienceTab First Opened----------------${!super.isTabInMemoryStack(1).value}");
    if (!super.isTabInMemoryStack(2).value){
      isAnimationCompleted.value = false;
      resetAnimations();
      startExperiencePageAnimations();
    }
    // super.animateToProjectsTab();
  }

  @override
  void onInit() {
    scrollController.addListener(_updateScrollProgress);
    super.onInit();
  }

  void _updateScrollProgress() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    scrollProgress.value = (currentScroll / maxScroll).clamp(0.0, 1.0);
  }


  void resetAnimations(){
    isProject1Visible.value = false;
    isProject1ImageVisible.value = false;
    isProject1DescVisible.value = false;
    isProject2Visible.value = false;
    isProject2ImageVisible.value = false;
    isProject2DescVisible.value = false;
    isProject3Visible.value = false;
    isProject3ImageVisible.value = false;
    isProject3DescVisible.value = false;
    isProject4Visible.value = false;
    isProject4ImageVisible.value = false;
    isProject4DescVisible.value = false;
    isProject5Visible.value = false;
    isProject5ImageVisible.value = false;
    isProject5DescVisible.value = false;
    isComingSoonVisible.value = false;
  }

  void startExperiencePageAnimations() {
    Future.delayed(const Duration(milliseconds: 200), (){
      isProject1Visible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 800), (){
      isProject1ImageVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 1100), (){
      isProject1DescVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 2000), (){
      isProject2Visible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 2600), (){
      isProject2ImageVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 2900), (){
      isProject2DescVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 3800), (){
      isProject3Visible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 4400), (){
      isProject3ImageVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 4700), (){
      isProject3DescVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 5600), (){
      isProject4Visible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 6200), (){
      isProject4ImageVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 6500), (){
      isProject4DescVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 7400), (){
      isProject5Visible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 8000), (){
      isProject5ImageVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 8300), (){
      isProject5DescVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 9100), (){
      isComingSoonVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 9700), (){
      isAnimationCompleted.value = true;
    });
  }
 }