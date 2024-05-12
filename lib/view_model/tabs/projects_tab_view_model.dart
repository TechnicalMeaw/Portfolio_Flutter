import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/base_controller.dart';

class ProjectsTabViewModel extends BaseGetXController {

  RxBool crossBtnHovered = false.obs;
  RxBool minimizeBtnHovered = false.obs;
  RxBool isAnimationCompleted = true.obs;

  RxBool isProject1Visible = false.obs;
  RxBool isProject1ImageVisible = false.obs;
  RxBool isProject1DescVisible = false.obs;

  RxBool isProject1KnowMoreBtnHovered = false.obs;

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


  void resetAnimations(){
    isProject1Visible.value = false;
    isProject1ImageVisible.value = false;
    isProject1DescVisible.value = false;
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

    Future.delayed(const Duration(milliseconds: 2400), (){
      isAnimationCompleted.value = true;
    });
  }
 }