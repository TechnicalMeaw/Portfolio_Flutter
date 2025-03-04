import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/tabs/experience_tab_view_model.dart';
import 'package:portfolio/view_model/widget/pie_chart_widget.dart';

class ExperienceTab extends StatelessWidget {
  const ExperienceTab({super.key, required this.viewModel});

  final ExperienceTabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.glassWhite.withOpacity(0.1),
                  border: Border.all(color: ColorConstants.glassWhite, width: 1)
              ),
              child: Column(
                children: [
                  // Top Common Widget
                  Container(
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            viewModel.closeTab(1);
                            viewModel.crossBtnHovered.value = false;
                          },
                          onHover: (isHovered){
                            viewModel.crossBtnHovered.value = isHovered;
                          },
                          child: Obx(
                                ()=> AnimatedContainer(
                                margin: EdgeInsets.only(left: viewModel.crossBtnHovered.value ? 0 : 2, right: viewModel.crossBtnHovered.value? 0: 2),
                                height: viewModel.crossBtnHovered.value ? 12 : 8,
                                width: viewModel.crossBtnHovered.value ? 12 : 8,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5), color: ColorConstants.crossRed),
                                duration: const Duration(milliseconds: 125),
                                child: viewModel.crossBtnHovered.value ? const Icon(Icons.close, size: 10,) : const SizedBox(height: 8, width: 8,)),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            viewModel.minimizeTab(1);
                            viewModel.minimizeBtnHovered.value = false;
                          },
                          onHover: (isHovered){
                            viewModel.minimizeBtnHovered.value = isHovered;
                          },
                          child: Obx(
                                ()=> AnimatedContainer(
                                margin: EdgeInsets.only(left: viewModel.minimizeBtnHovered.value ? 1 : 3),
                                height: viewModel.minimizeBtnHovered.value ? 12 : 8,
                                width: viewModel.minimizeBtnHovered.value ? 12 : 8,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5), color: ColorConstants.minimizeYellow),
                                duration: const Duration(milliseconds: 125),
                                child: viewModel.minimizeBtnHovered.value ? const Icon(Icons.remove, size: 10,) : const SizedBox(height: 8, width: 8,)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Expanded(child: LayoutBuilder(
                    builder:(context, rootConstrains) => Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          color: ColorConstants.glassBlack.withOpacity(0.1),
                          child: rootConstrains.maxWidth > 1100
                              ? SingleChildScrollView(
                            controller: viewModel.scrollController,
                            child: Column(
                              children: [
                                const SizedBox(height: 16,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 16,),
                                    SizedBox(
                                        width: rootConstrains.maxWidth * 0.6,
                                        child: _leftColumn),
                                    // const SizedBox(width: 4,),
                                    const SizedBox(width: 32,),
                                    Expanded(child: _rightColumn),
                                    const SizedBox(width: 16,),
                                  ],
                                ),
                                const SizedBox(height: 16,),
                              ],
                            ),
                          )
                              : ListView(
                            controller: viewModel.scrollController,
                            shrinkWrap: true,
                            children: [
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: _leftColumn,
                              ),
                              const SizedBox(height: 32,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: _rightColumn,
                              ),
                              const SizedBox(height: 100,)
                            ],
                          ),),

                        Obx(() {
                          double scrollProgress = viewModel.scrollProgress.value;
                          bool isAtBottom = scrollProgress == 1.0;

                          return AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            bottom: 16,
                            right: 12,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: viewModel.isFreelanceExperienceVisible.value ? 1: 0,
                              curve: Curves.easeIn,
                              child: InkWell(
                                onTap: isAtBottom ? () => viewModel.animateToProjectsTab() : ()=> viewModel.scrollController.animateTo(viewModel.scrollController.offset + rootConstrains.maxHeight/1.5, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut),
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
                  ))
                ],
              ),
            )));
  }

  Widget get _leftColumn => Column(
    children: [

      Obx(
      ()=> AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: viewModel.isProExperienceVisible.value == true ? 1 : 0,
          child: Container(

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorConstants.white.withOpacity(0.4), width: 0.8),
                  color: ColorConstants.deepTeal.withOpacity(0.5),
                  image: DecorationImage(
                    image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    // image: const NetworkImage("https://static.vecteezy.com/system/resources/previews/006/861/154/non_2x/light-blue-background-gradient-illustration-eps10-vector.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.22), BlendMode.dstATop),
                  )
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Professional Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white),),
                              // Text("Know More", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.black, decoration: TextDecoration.underline),),
                            ],
                          ),
                          const SizedBox(height: 10,),

                          ...List.generate(viewModel.experienceCompanyList.length, (index) =>
                          Column(
                            children: [
                              if(index != 0)
                                const SizedBox(height: 16,),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorConstants.lightCyanBlue.withOpacity(0.4),
                                    border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
                                    gradient: LinearGradient(
                                        colors: [
                                          ColorConstants.black.withOpacity(0.09),

                                          ColorConstants.black.withOpacity(0.34),
                                        ],
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 0.0),
                                        stops: const [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                    borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                        child: _companyWidget(
                                          companyData: viewModel.experienceCompanyList[index],
                                          // jobTitle: "Software Engineer",
                                          // companyName: "Mantra Labs",
                                          // jobDuration: "June 2022 - Present",
                                          // keyResponsibilities: [
                                          //   "Flutter developer with expertise in state management using Bloc, GetX.",
                                          //   "Consistently delivered pixel-perfect UI designs with functionalities.",
                                          //   "Optimized MySQL data flow with Django Restful APIs, cutting response time by 30%, boosting user experience."
                                          // ],
                                          index: index,
                                          // length: 2
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          )
                                        )
                                        //       const SizedBox(height: 24,),
                                        //       _companyWidget(
                                        //         jobTitle: "Android Developer",
                                        //         companyName: "Coprotect Ventures",
                                        //         jobDuration: "Aug 2021 - Oct 2021",
                                        //         keyResponsibilities: ["End-to-end development of a social media application.", "Remote collaboration with a team of 5 members."],
                                        //         index: 0,
                                        //         // length: 2
                                        //       ),
                        ],
                      ),
                    ),))
          ),
        ),
      ),
      const SizedBox(height: 32,),
      Obx(
      ()=> AnimatedOpacity(
        opacity: viewModel.isFreelanceExperienceVisible.value ? 1: 0,
        duration: const Duration(milliseconds: 800),
        child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
                  color: ColorConstants.highlightQueenViolet.withOpacity(0.48),
                  // gradient: LinearGradient(
                  //   colors: [
                  //     ColorConstants.highlightQueenViolet.withOpacity(0.4),
                  //     ColorConstants.deepQueenViolet.withOpacity(0.6)
                  //   ]
                  // ),
                  image: DecorationImage(
                    image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    // image: const NetworkImage("https://images.pexels.com/photos/2569997/pexels-photo-2569997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    // image: const NetworkImage("https://static.vecteezy.com/system/resources/previews/006/861/154/non_2x/light-blue-background-gradient-illustration-eps10-vector.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.24), BlendMode.dstATop),
                  )
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Freelancing Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white),),
                              // Text("Know More", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.black, decoration: TextDecoration.underline),),
                            ],
                          ),
                          const SizedBox(height: 10,),

                          ...List.generate(viewModel.freelanceExperienceList.length, (index) =>
                              Column(
                                children: [
                                  if(index != 0)
                                    const SizedBox(height: 16,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.glassWhite.withOpacity(0.4),
                                        border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
                                        gradient: LinearGradient(
                                            colors: [
                                              // ColorConstants.glassWhite.withAlpha(60),
                                              // ColorConstants.glassWhite.withOpacity(0.2),
                                              // ColorConstants.glassWhite.withOpacity(0.7),
                                              // ColorConstants.orange.withAlpha(10),
                                              ColorConstants.black.withOpacity(0.09),

                                              ColorConstants.black.withOpacity(0.34),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.all(16),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                        child: _companyWidget(
                                          companyData: viewModel.freelanceExperienceList[index],
                                          // jobTitle: "Software Engineer",
                                          // companyName: "Mantra Labs",
                                          // jobDuration: "June 2022 - Present",
                                          // keyResponsibilities: [
                                          //   "Flutter developer with expertise in state management using Bloc, GetX.",
                                          //   "Consistently delivered pixel-perfect UI designs with functionalities.",
                                          //   "Optimized MySQL data flow with Django Restful APIs, cutting response time by 30%, boosting user experience."
                                          // ],
                                          index: index,
                                          isFreelancing: true
                                          // length: 2
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          )
                          //       const SizedBox(height: 24,),
                          //       _companyWidget(
                          //         jobTitle: "Android Developer",
                          //         companyName: "Coprotect Ventures",
                          //         jobDuration: "Aug 2021 - Oct 2021",
                          //         keyResponsibilities: ["End-to-end development of a social media application.", "Remote collaboration with a team of 5 members."],
                          //         index: 0,
                          //         // length: 2
                          //       ),
                        ],
                      ),
                    ),))
          ),
      ),
      ),
    ],
  );

  Widget _companyWidget({
    // required String jobTitle,
    // required String companyName,
    // required String jobDuration,
    // required List<String> keyResponsibilities,
    required ExperienceCompanyDataModel companyData,
    required int index,
    isFreelancing = false
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // if(index != 0)
              //   Container(
              //     height: 16,
              //     width: 1.5, color: ColorConstants.black,),
              // if()
              //   SizedBox(height: index == 0 ? 5.5 : 29.5,),
                SizedBox(height: 5.5,),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1.5, color: isFreelancing? ColorConstants.white: ColorConstants.white)),
              ),
              Expanded(
                child: Container(
                  width: 1.5, color: isFreelancing? ColorConstants.glassWhite: ColorConstants.glassWhite,),
              ),
              const SizedBox(height: 8),
            ],
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // direction: Axis.vertical,
              children: [
                // if(index != 0)
                //   const SizedBox(height: 24,),
                Text(companyData.jobTitle, style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w400, color: isFreelancing ? ColorConstants.white : ColorConstants.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.1,
                      color: isFreelancing ? ColorConstants.darkQueenViolet : ColorConstants.deepBlue,
                    ),
                    const Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.5,
                      color: ColorConstants.cyanBlue,
                    ),
                  ],
                ),),
                if (companyData.companyName != "")
                Text(companyData.companyName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.1,
                      color: isFreelancing ? ColorConstants.queenViolet : ColorConstants.deepBlue,
                    ),
                    const Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.5,
                      color: ColorConstants.cyanBlue,
                    ),
                  ],
                )),
                const SizedBox(height: 2,),
                Text(companyData.jobDuration, style: TextStyle(fontSize: 10, color: isFreelancing ? ColorConstants.glassWhite : ColorConstants.glassWhite, fontWeight: FontWeight.w400,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.1,
                      color: isFreelancing ? ColorConstants.darkQueenViolet : ColorConstants.deepBlue,
                    ),
                    const Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.5,
                      color: ColorConstants.cyanBlue,
                    ),
                  ],
                )),
                const SizedBox(height: 10,),
                ...List.generate(companyData.keyResponsibilities.length, (keyIndex) =>
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 4,),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1.5, color: isFreelancing ? ColorConstants.glassWhite : ColorConstants.glassWhite),
                                color: isFreelancing ? ColorConstants.black : ColorConstants.white
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(companyData.keyResponsibilities[keyIndex].title != "")
                                    Text(companyData.keyResponsibilities[keyIndex].title, style: const TextStyle(fontSize: 14, color: ColorConstants.white,
                                        fontWeight: FontWeight.w400)),
                                  if(companyData.keyResponsibilities[keyIndex].title != "")
                                    const SizedBox(height: 2,),
                                  Text.rich(TextSpan(
                                      children: List.generate(companyData.keyResponsibilities[keyIndex].responsibilityTexts.length, (textIndex) =>
                                      TextSpan(text: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].text,
                                          style: TextStyle(fontSize: 14, color: isFreelancing ? ColorConstants.white : ColorConstants.white,
                                              fontWeight: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].textType == TextType.bold ? FontWeight.w500
                                                  // : FontWeight.lerp(FontWeight.w400, FontWeight.w500, 0.5),
                                                  : FontWeight.w400,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 0.1,
                                                color: isFreelancing ? ColorConstants.white : ColorConstants.deepBlue,
                                              ),
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.5,
                                                color: isFreelancing ? ColorConstants.queenViolet : ColorConstants.cyanBlue,
                                              ),
                                            ],
                                          )))),
                                  ),
                                ],
                              )
                                  ),
                                                          ],
                        ),
                        if (keyIndex != companyData.keyResponsibilities.length)
                          const SizedBox(height: 16,)
                      ],
                    ),
                  ),
                if (companyData.projects.isNotEmpty)
                Text("Contributed to",
                  style: TextStyle(color: isFreelancing ? ColorConstants.white : ColorConstants.white, fontWeight: FontWeight.w500, fontSize: 14),),
                if (companyData.projects.isNotEmpty)
                  const SizedBox(height: 8,),
                if (companyData.projects.isNotEmpty)
                Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  alignment: WrapAlignment.start,
                  children: List.generate(companyData.projects.length, (index){
                    return  Container(
                      constraints: const BoxConstraints(maxWidth: 96),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // color: ColorConstants.glassBlack.withOpacity(0.1),
                        // border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 2),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 64,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(companyData.projects[index].logoUrl ?? "", height: 64, width: 64, fit: BoxFit.cover))),

                          const SizedBox(height: 4,),
                          Text(companyData.projects[index].title,
                            style: const TextStyle(fontSize: 12, color: ColorConstants.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, maxLines: 2,),
                        ],
                      ),
                    );
                  }),)
              ],
            ),
          )
        ],
      ),
    );
  }



  Widget get _rightColumn => Column(
    children: [
      Obx(
      ()=> AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: viewModel.isTechStackVisible.value ? 1 : 0,
        child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  // color: ColorConstants.glassBlack.withOpacity(0.65),
                gradient: LinearGradient(
                    colors: [
                      ColorConstants.darkTextBlue.withOpacity(0.6),
                      ColorConstants.darkTextBlue.withOpacity(0.8),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                  border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),

                  image: DecorationImage(
                    image: const NetworkImage("https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg"),
                    // image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),

                    // image: const NetworkImage("https://img.freepik.com/premium-photo/beautiful-colorful-background-vector-gradation-set-wallpaper-printable-template_515653-42.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.black.withOpacity(0.15), BlendMode.dstATop),
                  )
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Technology Stack", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white),),
                              // Text("Know More", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.black, decoration: TextDecoration.underline),),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Container(
                            decoration: BoxDecoration(
                                // color: ColorConstants.glassWhite.withOpacity(0.4),
                                // gradient: LinearGradient(
                                //     colors: [
                                //       ColorConstants.lightCyanBlue.withAlpha(30),
                                //       ColorConstants.cyanBlue.withAlpha(50),
                                //     ],
                                //     begin: const FractionalOffset(0.0, 0.0),
                                //     end: const FractionalOffset(1.0, 0.0),
                                //     stops: const [0.0, 1.0],
                                //     tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(16)),
                            // padding: const EdgeInsets.symmetric(vertical: 16),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return
                                  constraints.maxWidth > 680 ?
                                  _pieChart1Web
                                      : _pieChart1(constraints);
                              }
                            ),
                          )

                        ],
                      ),
                    ),))
          ),
      ),
      ),

      const SizedBox(height: 32,),

      // Container(
        //   padding: const EdgeInsets.all(32),
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        //   color: ColorConstants.glassWhite.withOpacity(0.8),
        //   image: DecorationImage(
        //   image: const NetworkImage("https://images.squarespace-cdn.com/content/v1/5ffb7c47a24aef1e5b942c13/1618436873379-0JSK85ANOQC8Y2QN1O98/gs-gradientsite2.png"),
        //   fit: BoxFit.cover,
        //   colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
        //   )
        // ),
        // child:
        // Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //   Text("Programming Languages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
        //           // Text("Know More", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.black, decoration: TextDecoration.underline),),
        //   ],
        // ),
        // const SizedBox(height: 16,),
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 650 ?
              Row(
              children: [
                Expanded(
                  child: LayoutBuilder
                    (
                    builder: (context, constraints) {
                      return _pieChart2(constraints);
                    }
                  ),
                ),
                const SizedBox(width: 32,),
                // Container(height: 150, width: 1, color: ColorConstants.darkGray,),
                // const SizedBox(width: 32,),
                Expanded(
                  child: LayoutBuilder
                    (
                      builder: (context, constraints) {
                        return _pieChart3(constraints);
                      }
                  ),
                ),
              ],
                    ) : Column( children: [
                _pieChart2(constraints),
                const SizedBox(height: 32,),
                _pieChart3(constraints)
              ],)

              ;
            }
          )

      // )
              ]
              );
  //     ],
  //   ),
  // );


  Widget get _pieChart1Web => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: Container(
          padding: const EdgeInsets.all( 16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Center(child:
              PieChart(
                  size: Size(constraints.maxWidth/2.8, constraints.maxWidth/2.8),
                  textDistance: 15,
                  textGap: 15,
                  isLabelVisible: false,
                  stroke: 1.3,
                  textCenterAdjustmentOffset: const Offset(-10, -8),
                  dataList: viewModel.technologyStackList
              ));
            },
          ))),
      // const SizedBox(width: 16,),

      // Container(height: 200, width: 1, color: ColorConstants.darkGray,),
      // const SizedBox(width: 16,),
      Expanded(child:
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: constraints.maxWidth/1.6,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                // color: ColorConstants.glassWhite,
              ),
              child: Row(
                children: [
                  Container(height: constraints.maxWidth/3, width: 1, color: ColorConstants.glassWhite,),
                  const SizedBox(width: 32,),
                  Expanded(
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 30,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceAround,
                        // mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(viewModel.technologyStackList.length, (index) =>
                            Row(children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                  color: viewModel.technologyStackList[index].color.withAlpha(190),
                                  // border: Border.all(color: ColorConstants.white, width: 1),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 2,
                                      color: ColorConstants.glassBlack,
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Text(viewModel.technologyStackList[index].title, style:
                              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorConstants.white),)
                            ],),
                        )
                    ),
                  ),
                  const SizedBox(width: 16,),
                ],
              ),

            );}))
    ],
  );

  Widget _pieChart1(BoxConstraints constraints) => Column(
    children: [
      const SizedBox(height: 64,),
      Container(
        width: constraints.maxWidth,
        // height: constraints.maxWidth > 400 ? 400,
        padding: const EdgeInsets.all(24),
        child: Center(
          child:
          // PieChart(
          //     size: Size(constraints.maxWidth/2, constraints.maxWidth/2),
          //     textDistance: 15,
          //     textGap: 15,
          //     isLabelVisible: false,
          //     stroke: 3,
          //     textCenterAdjustmentOffset: const Offset(-10, -8),
          //     dataList: viewModel.technologyStackList
          // ),

          PieChart(
              size: Size(constraints.maxWidth/1.65 > 200 ? 200 : constraints.maxWidth/1.9 < 180 ? constraints.maxWidth/2.1 : constraints.maxWidth/1.75,
                  constraints.maxWidth/1.65 > 200 ? 200 : constraints.maxWidth/1.9 < 180 ? constraints.maxWidth/2.1 : constraints.maxWidth/1.75),
              textDistance: 10,
              textGap: 20,
              isLabelVisible: false,
              stroke: 1.3,
              textCenterAdjustmentOffset: const Offset(-14, -10),
              dataList: viewModel.technologyStackList
          ),
        ),
      ),
      const SizedBox(height: 64,),
      Center(
        child: Container(width: constraints.maxWidth/1.7,
          height: 1,
          color: ColorConstants.glassWhite,
        ),
      ),
      const SizedBox(height: 8,),

      Center(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceEvenly,
          spacing: 16,
          runSpacing: 2,
          children: List.generate(viewModel.technologyStackList.length, (index) =>
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                      color: viewModel.technologyStackList[index].color.withAlpha(190),
                      // border: Border.all(color: ColorConstants.glassWhite, width: 1),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 2,
                          color: ColorConstants.glassBlack,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Text(viewModel.technologyStackList[index].title, style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),)
                ],),
          ),
        ),
      )
    ],
  );


  Widget _pieChart2(BoxConstraints constraints) {
    return Obx(
        () => AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: viewModel.isLangVisible.value ? 1 : 0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                // color: ColorConstants.glassWhite.withOpacity(0.6),
                gradient: LinearGradient(
                    colors: [
                      ColorConstants.darkTextBlue.withOpacity(0.6),
                      ColorConstants.darkTextBlue.withOpacity(0.8),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
                image: DecorationImage(
                  // image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),

                  image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.15), BlendMode.dstATop),
                )
            ),
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: constraints.maxWidth > 434 ? const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 52) : const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Programming Languages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white),),
                        const SizedBox(height: 64,),
                        Container(
                          width: constraints.maxWidth,
                          // height: constraints.maxWidth,
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child:
                            PieChart(
                                size: Size(constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9, constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9),
                                textDistance: 10,
                                textGap: 20,
                                isLabelVisible: false,
                                stroke: 1,
                                textCenterAdjustmentOffset: const Offset(-14, -10),
                                dataList: viewModel.programmingLanguageList
                            ),
                          ),
                        ),
                        const SizedBox(height: 64,),
                        Center(
                          child: Container(width: constraints.maxWidth/1.7,
                            height: 1,
                            color: ColorConstants.glassWhite,
                          ),
                        ),
                        const SizedBox(height: 8,),

                        Center(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 16,
                            runSpacing: 2,
                            children: List.generate(viewModel.programmingLanguageList.length, (index) =>
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                        color: viewModel.programmingLanguageList[index].color.withAlpha(190),
                                        // border: Border.all(color: ColorConstants.white, width: 1),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2,
                                            color: ColorConstants.glassBlack,
                                          ),

                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12,),
                                    Text(viewModel.programmingLanguageList[index].title, style:
                                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),)
                                  ],),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),))
                ),
        ),
    );
  }


  Widget _pieChart3(BoxConstraints constraints) {
    return Obx(
        ()=> AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: viewModel.isDomainVisible.value ? 1 : 0,
          child: Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                // color: ColorConstants.glassWhite.withOpacity(0.6),
                gradient: LinearGradient(
                    colors: [
                      ColorConstants.deepTextBlue.withOpacity(0.38),
                      ColorConstants.deepTextBlue.withOpacity(0.45),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.4), width: 0.8),
                image: DecorationImage(
                  // image: const NetworkImage("https://img.freepik.com/premium-photo/beautiful-colorful-background-vector-gradation-set-wallpaper-printable-template_515653-42.jpg"),
                  image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),

                  // image: const NetworkImage("https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.1), BlendMode.dstATop),
                )
            ),
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Domain Knowledge", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white),),
                        const SizedBox(height: 64,),
                        Container(
                          width: constraints.maxWidth,
                          // height: constraints.maxWidth,
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child:
                            PieChart(
                                size: Size(constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9, constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9),
                                textDistance: 10,
                                textGap: 20,
                                isLabelVisible: false,
                                stroke: 1,
                                textCenterAdjustmentOffset: const Offset(-14, -10),
                                dataList: viewModel.domainKnowledgeList
                            ),
                          ),
                        ),
                        const SizedBox(height: 64,),
                        Center(
                          child: Container(width: constraints.maxWidth/1.7,
                            height: 1,
                            color: ColorConstants.glassWhite,
                          ),
                        ),
                        const SizedBox(height: 8,),

                        Center(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 16,
                            runSpacing: 2,
                            children: List.generate(viewModel.domainKnowledgeList.length, (index) =>
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                        color: viewModel.domainKnowledgeList[index].color,
                                        // border: Border.all(color: ColorConstants.darkGray, width: 0.5)
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1,
                                            color: ColorConstants.glassBlack,
                                          ),

                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12,),
                                    Text(viewModel.domainKnowledgeList[index].title, style:
                                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),)
                                  ],),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),))
                ),
        ),
    );
  }
}
