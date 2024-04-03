import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:portfolio/view_model/base_controller.dart';
import 'package:portfolio/view_model/home/home_page_view_model.dart';

class OverviewTabViewModel extends BaseGetXController {

  RxBool crossBtnHovered = false.obs;
  RxBool minimizeBtnHovered = false.obs;

  RxBool isAnimationCompleted = true.obs;

  RxInt androidSkillRating = 0.obs;
  RxInt flutterSkillRating = 0.obs;
  RxInt djangoSkillRating = 0.obs;
  RxInt fastApiSkillRating = 0.obs;
  RxInt problemSolvingSkillRating = 0.obs;
  RxInt firebaseSkillRating = 0.obs;
  RxInt pythonSkillRating = 0.obs;
  RxInt dsaSkillRating = 0.obs;
  RxInt awsSkillRating = 0.obs;
  RxInt kotlinSkillRating = 0.obs;
  RxInt dartSkillRating = 0.obs;
  RxInt javaSkillRating = 0.obs;
  RxInt gitSkillRating = 0.obs;

  RxInt bannerWidth = 0.obs;
  RxDouble bannerHeight = 0.05.obs;
  RxBool isProfileBannerOpened = false.obs;
  RxBool isProfileBannerTitleVisible = false.obs;
  RxBool isSummaryVisible = false.obs;
  RxBool isHireMeVisible = false.obs;

  RxBool isKPI1Visible = false.obs;
  RxBool isKPI2Visible = false.obs;
  RxBool isKPI3Visible = false.obs;
  RxBool isKPI4Visible = false.obs;
  RxBool isKPI5Visible = false.obs;

  RxInt kpi1Value = 0.obs;
  RxInt kpi2Value = 0.obs;
  RxInt kpi3Value = 0.obs;
  RxInt kpi4Value = 0.obs;
  RxInt kpi5Value = 0.obs;

  RxBool kpi1KnowMoreHovered = false.obs;
  RxBool kpi2KnowMoreHovered = false.obs;
  RxBool kpi3KnowMoreHovered = false.obs;
  RxBool kpi4KnowMoreHovered = false.obs;
  RxBool kpi5KnowMoreHovered = false.obs;

  RxBool educationViewAllHovered = false.obs;
  RxBool skillsViewAllHovered = false.obs;

  RxBool link1Hovered = false.obs;
  RxBool link2Hovered = false.obs;
  RxBool link3Hovered = false.obs;
  RxBool link4Hovered = false.obs;

  RxBool isSkillsVisible = false.obs;

  RxBool isLinkedInIconHovered = false.obs;
  RxBool isGitHubIconHovered = false.obs;
  RxBool isEmailIconHovered = false.obs;
  RxBool isPhoneIconHovered = false.obs;
  // RxBool isPhoneNumberCopied = false.obs;


  RxBool isDownloadCvBtnHovered = false.obs;
  RxBool isViewProjectsBtnHovered = false.obs;


  late Future t1;
  late Future t2;
  late Future t3;
  late Future t4;
  late Future t5;
  late Future t6;
  late Future t7;
  late Future t8;
  late Future t9;
  late Future t10;
  late Future t11;
  late Future t12;
  late Future t13;

  // @override
  // void onInit() {
  //     // startOverviewPageAnimations();
  //   super.onInit();
  // }

  @override
  void animateToOverviewTab() {
    print("OverviewTab First Opened----------------${!super.isTabInMemoryStack(0).value}");
    if (!super.isTabInMemoryStack(0).value){
      isAnimationCompleted.value = false;
      resetAnimations();
      startOverviewPageAnimations();
    }
    super.animateToOverviewTab();
  }

  void startOverviewPageAnimations(){
    print("Animation----------------Started");

    t1 = Future.delayed(
      const Duration(milliseconds: 100),
          () {
        bannerWidth.value = 1;
      },
    );

    t2 = Future.delayed(
        const Duration(milliseconds: 1200), () => bannerHeight.value = 1);
    t3 = Future.delayed(
        const Duration(milliseconds: 1700),
            () =>
        {
          isProfileBannerOpened.value = true,
        });
    t4 = Future.delayed(
        const Duration(milliseconds: 2900),
            () {
          isProfileBannerTitleVisible.value = true;
          t5 = Future.delayed(const Duration(milliseconds: 200), () {
            isSummaryVisible.value = true;
          });

          t6 = Future.delayed(const Duration(milliseconds: 900), () {
            isHireMeVisible.value = true;
          });
          t7 = Future.delayed(const Duration(milliseconds: 1300), () {
            isKPI1Visible.value = true;
            startIncreasingAnimation(kpi1Value, 2, 100, 400, increaseValue: 1);
          });
          t8 = Future.delayed(const Duration(milliseconds: 1600), () {
            isKPI2Visible.value = true;
            startIncreasingAnimation(kpi2Value, 7, 100, 190, increaseValue: 1);
          });
          t9 = Future.delayed(const Duration(milliseconds: 1900), () {
            isKPI3Visible.value = true;
            startIncreasingAnimation(kpi3Value, 6, 100, 220, increaseValue: 1);
          });
          t10 = Future.delayed(const Duration(milliseconds: 2200), () {
            isKPI4Visible.value = true;
            startIncreasingAnimation(kpi4Value, 6, 100, 200, increaseValue: 1);
          });
          t11 = Future.delayed(const Duration(milliseconds: 2500), () {
            isKPI5Visible.value = true;
            startIncreasingAnimation(kpi5Value, 56, 200, 32, increaseValue: 4);
          });
        });

    t12 = Future.delayed(const Duration(milliseconds: 3200), () {
      isSkillsVisible.value = true;
      startIncreasingAnimation(androidSkillRating, 92, 100, 35);
      startIncreasingAnimation(flutterSkillRating, 83, 200, 30);
      startIncreasingAnimation(djangoSkillRating, 71, 300, 45);
      startIncreasingAnimation(fastApiSkillRating, 76, 400, 25);
      startIncreasingAnimation(problemSolvingSkillRating, 92, 500, 40);
      startIncreasingAnimation(firebaseSkillRating, 84, 600, 30);
      startIncreasingAnimation(pythonSkillRating, 90, 700, 25);
      startIncreasingAnimation(dsaSkillRating, 86, 800, 35);
      startIncreasingAnimation(awsSkillRating, 62, 900, 45);
      startIncreasingAnimation(kotlinSkillRating, 86, 1000, 60);
      startIncreasingAnimation(dartSkillRating, 76, 1100, 35);
      startIncreasingAnimation(javaSkillRating, 80, 1300, 25);
      startIncreasingAnimation(gitSkillRating, 74, 1400, 45);


    });

    t13 = Future.delayed(
        const Duration(seconds: 6), () {
          isAnimationCompleted.value = true;
    });

  }

  void startIncreasingAnimation(RxInt skillRatingInt, int maxSkillRating, int delay, int increaseDelay, {int increaseValue = 2}){
    late Timer timer;
    Future.delayed(
      Duration(milliseconds: delay),
          () {
        timer = Timer.periodic(
          Duration(milliseconds: increaseDelay),
              (timer) {
            if (skillRatingInt.value >= maxSkillRating) {
              timer.cancel();
            } else {
              skillRatingInt.value += increaseValue;
            }
          },
        );
      },
    );
  }


  void resetAnimations(){
    // t1.ignore();
    // t2.ignore();
    // t3.ignore();
    // t4.ignore();
    // t5.ignore();
    // t6.ignore();
    // t7.ignore();
    // t8.ignore();
    // t9.ignore();
    // t10.ignore();
    // t11.ignore();
    // t12.ignore();
    // t13.ignore();

    androidSkillRating = 0.obs;
    flutterSkillRating = 0.obs;
    djangoSkillRating = 0.obs;
    fastApiSkillRating = 0.obs;
    problemSolvingSkillRating = 0.obs;
    firebaseSkillRating = 0.obs;
    pythonSkillRating = 0.obs;
    dsaSkillRating = 0.obs;
    awsSkillRating = 0.obs;
    kotlinSkillRating = 0.obs;
    dartSkillRating = 0.obs;
    javaSkillRating = 0.obs;
    gitSkillRating = 0.obs;

    bannerWidth = 0.obs;
    bannerHeight = 0.05.obs;
    isProfileBannerOpened = false.obs;
    isProfileBannerTitleVisible = false.obs;
    isSummaryVisible = false.obs;
    isHireMeVisible = false.obs;

    isKPI1Visible = false.obs;
    isKPI2Visible = false.obs;
    isKPI3Visible = false.obs;
    isKPI4Visible = false.obs;
    isKPI5Visible = false.obs;

    kpi1Value = 0.obs;
    kpi2Value = 0.obs;
    kpi3Value = 0.obs;
    kpi4Value = 0.obs;
    kpi5Value = 0.obs;

    isSkillsVisible = false.obs;
  }
}
