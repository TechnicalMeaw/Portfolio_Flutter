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
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child:
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorConstants.glassWhite.withOpacity(0.2)),
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
                    builder:(context, rootConstrains) => Container(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      color: ColorConstants.glassBlack.withOpacity(0.1),
                      child: rootConstrains.maxWidth > 1100
                          ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16,),
                                SizedBox(
                                    width: rootConstrains.maxWidth * 0.4,
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
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.cyanBlue.withOpacity(0.5),
                  image: DecorationImage(
                    image: const NetworkImage("https://static.vecteezy.com/system/resources/previews/006/861/154/non_2x/light-blue-background-gradient-illustration-eps10-vector.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
                  )
              ),
              child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Professional Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
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
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorConstants.lightCyanBlue.withAlpha(30),
                                        ColorConstants.cyanBlue.withAlpha(50),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.queenViolet.withOpacity(0.7),
                  // gradient: LinearGradient(
                  //   colors: [
                  //     ColorConstants.highlightQueenViolet.withOpacity(0.4),
                  //     ColorConstants.deepQueenViolet.withOpacity(0.6)
                  //   ]
                  // ),
                  image: DecorationImage(
                    image: const NetworkImage("https://static.vecteezy.com/system/resources/previews/006/861/154/non_2x/light-blue-background-gradient-illustration-eps10-vector.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.3), BlendMode.dstATop),
                  )
              ),
              child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
                                      gradient: LinearGradient(
                                          colors: [
                                            // ColorConstants.glassWhite.withAlpha(60),
                                            ColorConstants.queenViolet.withAlpha(30),
                                            ColorConstants.deepQueenViolet.withAlpha(80),
                                            // ColorConstants.orange.withAlpha(10),
                                          ],
                                          begin: const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: const [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                      borderRadius: BorderRadius.circular(16)),
                                  padding: const EdgeInsets.all(16),
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
                    border: Border.all(width: 1.5, color: isFreelancing? ColorConstants.white: ColorConstants.textBlue)),
              ),
              Expanded(
                child: Container(
                  width: 1.5, color: isFreelancing? ColorConstants.white: ColorConstants.textBlue,),
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
                    fontWeight: FontWeight.w500, color: isFreelancing ? ColorConstants.white : ColorConstants.deepTextBlue,
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
                Text(companyData.companyName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.deepTextBlue,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.1,
                      color: isFreelancing ? ColorConstants.lightYellow : ColorConstants.deepBlue,
                    ),
                    const Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.5,
                      color: ColorConstants.cyanBlue,
                    ),
                  ],
                )),
                const SizedBox(height: 2,),
                Text(companyData.jobDuration, style: TextStyle(fontSize: 10, color: isFreelancing ? ColorConstants.glassWhite : ColorConstants.textBlue, fontWeight: FontWeight.w400,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.1,
                      color: isFreelancing ? ColorConstants.lightYellow : ColorConstants.deepBlue,
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
                                  border: Border.all(width: 1.5, color: isFreelancing ? ColorConstants.glassWhite : ColorConstants.glassBlack),
                                color: isFreelancing ? ColorConstants.white : ColorConstants.black
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(companyData.keyResponsibilities[keyIndex].title != "")
                                    Text(companyData.keyResponsibilities[keyIndex].title, style: const TextStyle(fontSize: 14, color: ColorConstants.black,
                                        fontWeight: FontWeight.w500)),
                                  if(companyData.keyResponsibilities[keyIndex].title != "")
                                    const SizedBox(height: 2,),
                                  Text.rich(TextSpan(
                                      children: List.generate(companyData.keyResponsibilities[keyIndex].responsibilityTexts.length, (textIndex) =>
                                      TextSpan(text: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].text,
                                          style: TextStyle(fontSize: 14, color: isFreelancing ? ColorConstants.white : ColorConstants.deepTextBlue,
                                              fontWeight: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].textType == TextType.bold ? FontWeight.w500
                                                  // : FontWeight.lerp(FontWeight.w400, FontWeight.w500, 0.5),
                                                  : FontWeight.w400,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 0.1,
                                                color: isFreelancing ? ColorConstants.lightQueenViolet : ColorConstants.deepBlue,
                                              ),
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.5,
                                                color: isFreelancing ? ColorConstants.glassBlack : ColorConstants.cyanBlue,
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
                  )
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
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.glassWhite.withOpacity(0.8),
                  image: DecorationImage(
                    image: const NetworkImage("https://img.freepik.com/premium-photo/beautiful-colorful-background-vector-gradation-set-wallpaper-printable-template_515653-42.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
                  )
              ),
              child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Technology Stack", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
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
                  Container(height: constraints.maxWidth/3, width: 1, color: ColorConstants.darkGray,),
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
                                  color: viewModel.technologyStackList[index].color,
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
                              const SizedBox(width: 16,),
                              Text(viewModel.technologyStackList[index].title, style:
                              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
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
          color: ColorConstants.darkGray,
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
                      color: viewModel.technologyStackList[index].color,
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
                  Text(viewModel.technologyStackList[index].title, style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
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
            padding: constraints.maxWidth > 434 ? const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 52) : const EdgeInsets.all(32),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                color: ColorConstants.glassWhite.withOpacity(0.8),
                image: DecorationImage(
                  image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
                )
            ),
            child:
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Programming Languages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
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
                          color: ColorConstants.darkGray,
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
                                      color: viewModel.programmingLanguageList[index].color,
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
                                  Text(viewModel.programmingLanguageList[index].title, style:
                                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                ],),
                          ),
                        ),
                      )
                    ],
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
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                color: ColorConstants.glassWhite.withOpacity(0.8),
                image: DecorationImage(
                  image: const NetworkImage("https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.5), BlendMode.dstATop),
                )
            ),
            child:
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Domain Knowledge", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
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
                          color: ColorConstants.darkGray,
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
                                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                ],),
                          ),
                        ),
                      )
                    ],
                  ),))
                ),
        ),
    );
  }
}
