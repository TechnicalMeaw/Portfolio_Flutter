import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/experience_cubit.dart';
import 'package:portfolio/bloc/home_cubit.dart';
import 'package:portfolio/model/experience_company_data_model.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/widgets/experience/hoverable_project_card.dart';
import 'package:portfolio/view_model/widget/pie_chart_widget_v1.dart';

class ExperienceTab extends StatelessWidget {
  const ExperienceTab({super.key});

  Widget _buildTopBarButton({
    required bool isHovered,
    required ValueChanged<bool> onHoverChanged,
    required VoidCallback onTap,
    required Color buttonColor,
    required IconData iconData,
    required bool isCloseButton, // To differentiate margin logic
  }) {
    return InkWell(
      onTap: () {
        onTap();
        onHoverChanged(false);
      },
      onHover: (isHovering) {
        onHoverChanged(isHovering);
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(
            left: isHovered
                ? (isCloseButton ? 0 : 4)
                : (isCloseButton ? 2 : 3),
            right: isHovered ? 0 : (isCloseButton ? 4 : 0)),
        height: isHovered ? 12 : 8,
        width: isHovered ? 12 : 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5), color: buttonColor),
        duration: const Duration(milliseconds: 125),
        child: isHovered
            ? Center(
                child:
                    Icon(iconData, size: 10, color: ColorConstants.black.withAlpha(236),))
            : const SizedBox(height: 8, width: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExperienceCubit>();
    final homeCubit = context.read<HomeCubit>();
    return ClipRect(
        // borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.glassWhite.withOpacity(0.04),
                  border: Border.all(color: ColorConstants.glassWhite, width: 1)
              ),
              child: Column(
                children: [
                  // Top Common Widget
                  BlocBuilder<ExperienceCubit, ExperienceState>(
                    buildWhen: (prev, curr) =>
                        prev.topBtnHovered != curr.topBtnHovered,
                    builder: (context, state) => Container(
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Row(
                        children: [
                          _buildTopBarButton(
                              isHovered: state.topBtnHovered,
                              onHoverChanged: cubit.setTopBtnHovered,
                              onTap: () => homeCubit.closeTab(1),
                              buttonColor: ColorConstants.crossRed,
                              iconData: Icons.close,
                              isCloseButton: true
                          ),
                          // const SizedBox(width: 2,),
                          _buildTopBarButton(
                              isHovered: state.topBtnHovered,
                              onHoverChanged: cubit.setTopBtnHovered,
                              onTap: () => homeCubit.minimizeTab(1),
                              buttonColor: ColorConstants.minimizeYellow,
                              iconData: Icons.remove,
                              isCloseButton: false
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Main Content
                  Expanded(child: LayoutBuilder(
                    builder:(context, rootConstrains) => Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: ColorConstants.glassBlack.withOpacity(0.1),
                              border: Border.all(
                                  color: ColorConstants.glassWhite.withOpacity(0.2),
                                  width: 1)
                          ),
                          child: rootConstrains.maxWidth > 1100
                              ? SingleChildScrollView(
                            controller: cubit.scrollController,
                            child: Column(
                              children: [
                                const SizedBox(height: 16,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 9,),
                                    SizedBox(
                                        width: rootConstrains.maxWidth * 0.6,
                                        child: _leftColumn(context)),
                                    // const SizedBox(width: 4,),
                                    const SizedBox(width: 16,),
                                    Expanded(child: _rightColumn(context)),
                                    const SizedBox(width: 8,),
                                  ],
                                ),
                                const SizedBox(height: 16,),
                              ],
                            ),
                          )
                              : ListView(
                            controller: cubit.scrollController,
                            shrinkWrap: true,
                            children: [
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: _leftColumn(context),
                              ),
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: _rightColumn(context),
                              ),
                              const SizedBox(height: 16,)
                            ],
                          ),),
                        // ignore: dead_code
                        BlocBuilder<ExperienceCubit, ExperienceState>(
                          buildWhen: (prev, curr) =>
                              prev.scrollProgress != curr.scrollProgress ||
                              prev.isFreelanceExperienceVisible !=
                                  curr.isFreelanceExperienceVisible,
                          builder: (context, state) {
                            double scrollProgress = state.scrollProgress;
                            bool isAtBottom = scrollProgress == 1.0;

                            return AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              bottom: 16,
                              right: 12,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: state.isFreelanceExperienceVisible ? 1: 0,
                                curve: Curves.easeIn,
                                child: InkWell(
                                  onTap: isAtBottom ? () => homeCubit.animateToProjectsTab() : ()=> cubit.scrollController.animateTo(cubit.scrollController.offset + rootConstrains.maxHeight/1.5, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut),
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
                                        AnimatedBuilder(
                                          animation: homeCubit.animationController,
                                          builder: (context, child) {
                                            return Transform.translate(
                                              offset: homeCubit.leftRightAnimation.value,
                                              child: const Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            );
                                          },
                                        )
                                            : AnimatedBuilder(
                                          animation: homeCubit.animationController,
                                          builder: (context, child) {
                                            return Transform.translate(
                                              offset: homeCubit.upDownAnimation.value,
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
                          },
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }

  Widget _leftColumn(BuildContext context) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) => Column(
        children: [

          AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: state.isProExperienceVisible == true ? 1 : 0,
              child: Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: ColorConstants.white.withOpacity(0.6), width: 1),
                      gradient: LinearGradient(
                          colors: [
                            ColorConstants.textBlue.withOpacity(0.15),
                            ColorConstants.deepTextBlue.withOpacity(0.15),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      image: DecorationImage(
                        image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(ColorConstants.black.withOpacity(0.05), BlendMode.dstATop),
                      )
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Professional Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236), shadows: [
                                    Shadow(
                                      color: ColorConstants.black.withAlpha(50),
                                      offset: const Offset(0, 2),
                                      blurRadius: 10,
                                    )
                                  ]),),
                                ],
                              ),
                              const SizedBox(height: 10,),

                              ...List.generate(state.experienceCompanyList.length, (index) =>
                              Column(
                                children: [
                                  if(index != 0)
                                    const SizedBox(height: 16,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.lightCyanBlue.withOpacity(0.4),
                                        border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.2), width: 1),
                                        gradient: LinearGradient(
                                            colors: [
                                              ColorConstants.black.withOpacity(0.11),
                                              ColorConstants.deepTextBlue.withOpacity(0.16),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        borderRadius: BorderRadius.circular(32)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(32),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                            enabled: false,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: _companyWidget(
                                                companyData: state.experienceCompanyList[index],
                                                index: index,
                                              ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              )
                                            )
                            ],
                          ),
                        ),))
              ),
          ),
          const SizedBox(height: 16,),
          AnimatedOpacity(
            opacity: state.isFreelanceExperienceVisible ? 1: 0,
            duration: const Duration(milliseconds: 800),
            child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.6), width: 1),
                      gradient: LinearGradient(
                          colors: [
                            ColorConstants.textBlue.withOpacity(0.15),
                            ColorConstants.indicatorHighlight.withOpacity(0.05),

                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      image: DecorationImage(
                        image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(ColorConstants.black.withOpacity(0.082), BlendMode.dstATop),
                      )
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Freelancing Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236), shadows: [
                                    Shadow(
                                      color: ColorConstants.black.withAlpha(50),
                                      offset: const Offset(0, 2),
                                      blurRadius: 10,
                                    )
                                  ]),),
                                ],
                              ),
                              const SizedBox(height: 10,),

                              ...List.generate(state.freelanceExperienceList.length, (index) =>
                                  Column(
                                    children: [
                                      if(index != 0)
                                        const SizedBox(height: 16,),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstants.glassWhite.withOpacity(0.4),
                                            border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.2), width: 1),
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorConstants.darkTextBlue.withOpacity(0.12),
                                                  ColorConstants.black.withOpacity(0.18),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                            borderRadius: BorderRadius.circular(32)),
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(32),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                            enabled: false,
                                            child: _companyWidget(
                                              companyData: state.freelanceExperienceList[index],
                                              index: index,
                                              isFreelancing: true
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                              )
                            ],
                          ),
                        ),))
              ),
          ),
        ],
      ),
    );
  }

  Widget _companyWidget({
    required ExperienceCompanyDataModel companyData,
    required int index,
    isFreelancing = false
  }) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                children: [
                  Text(companyData.jobTitle, style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w400, color: isFreelancing ? ColorConstants.white.withAlpha(236) : ColorConstants.white.withAlpha(236),
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.1,
                        color: isFreelancing ? ColorConstants.deepBlue : ColorConstants.deepBlue,
                      ),
                      const Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.5,
                        color: ColorConstants.cyanBlue,
                      ),
                    ],
                  ),),
                  if (companyData.companyName != "")
                  Text(companyData.companyName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236),
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.1,
                        color: isFreelancing ? ColorConstants.deepBlue.withAlpha(236) : ColorConstants.deepBlue.withAlpha(236),
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
                        color: isFreelancing ? ColorConstants.deepBlue : ColorConstants.deepBlue,
                      ),
                      const Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.5,
                        color: ColorConstants.cyanBlue,
                      ),
                    ],
                  )),
                  const SizedBox(height: 16,),
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
                                  color: isFreelancing ? ColorConstants.white : ColorConstants.white
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
                                            style: TextStyle(fontSize: 14, color: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].textType == TextType.bold ?
                                              (isFreelancing ? ColorConstants.lightYellow.withAlpha(218) : ColorConstants.lightYellow.withAlpha(218)) : ColorConstants.white.withAlpha(236),
                                                fontWeight: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].textType == TextType.bold ? FontWeight.w300
                                                    : FontWeight.w400,
                                              shadows: [
                                                Shadow(
                                                  color: ColorConstants.black.withAlpha(80),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 10,
                                                ),
                                              ]
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
                    const SizedBox(height: 16,),
                  if (companyData.projects.isNotEmpty)
                  Text("Contributed to",
                    style: TextStyle(color: isFreelancing ? ColorConstants.white.withAlpha(236) : ColorConstants.white.withAlpha(236), fontWeight: FontWeight.w500, fontSize: 14),),
                  if (companyData.projects.isNotEmpty)
                    const SizedBox(height: 8,),
                  if (companyData.projects.isNotEmpty)
                    Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      alignment: WrapAlignment.start,
                      children: List.generate(companyData.projects.length, (pIndex) {
                        final project = companyData.projects[pIndex];
                        final hasRedirect =
                            project.redirectUrl != null && project.redirectUrl!.trim().isNotEmpty;

                        return HoverableProjectCard(
                          project: project,
                          enabled: hasRedirect,
                        );
                      }),
                    )
                ],
              ),
            ),
            const SizedBox(width: 6,),
          ],
        ),
      ),
    );
  }



  Widget _rightColumn(BuildContext context) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) => Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: state.isTechStackVisible ? 1 : 0,
            child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                      colors: [
                        ColorConstants.darkTextBlue.withOpacity(0.12),
                        ColorConstants.darkTextBlue.withOpacity(0.24),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                    border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.6), width: 1),

                    image: DecorationImage(
                      image: const NetworkImage("https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(ColorConstants.black.withOpacity(0.05), BlendMode.dstATop),
                    )
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Technology Stack", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236),
                                shadows: [
                                  Shadow(
                                    color: ColorConstants.black.withAlpha(50),
                                    offset: const Offset(0, 2),
                                    blurRadius: 10,
                                  )
                                ]),),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32)),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return
                                    constraints.maxWidth > 680 ?
                                    _pieChart1Web(state.technologyStackList)
                                        : _pieChart1(constraints, state.technologyStackList);
                                }
                              ),
                            )

                          ],
                        ),
                      ),))
              ),
          ),

          const SizedBox(height: 16,),

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
                const SizedBox(width: 16,),
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
                const SizedBox(height: 16,),
                _pieChart3(constraints)
              ],)

              ;
            }
          )
        ],
      ),
    );
  }


  Widget _pieChart1Web(List<PieChartDataModel> technologyStackList) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: Container(
          padding: const EdgeInsets.all( 16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Center(child:
              PieChart(
                  size: Size(constraints.maxWidth/2.8, constraints.maxWidth/2.8),
                  textDistance: 12,
                  textGap: 24,
                  isLabelVisible: true,
                  stroke: 1.3,
                  textCenterAdjustmentOffset: const Offset(-14, -6),
                  dataList: technologyStackList
              ));
            },
          ))),
      Expanded(child:
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: constraints.maxWidth/1.6,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(32),
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
                        children: List.generate(technologyStackList.length, (index) =>
                            Row(children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                  color: technologyStackList[index].color.withAlpha(190),
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
                              Text("${technologyStackList[index].title} (${technologyStackList[index].percentage}%)", style:
                                TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorConstants.white.withAlpha(236)),)
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

  Widget _pieChart1(BoxConstraints constraints, List<PieChartDataModel> technologyStackList) => Column(
    children: [
      const SizedBox(height: 64,),
      Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(24),
        child: Center(
          child:

          PieChart(
              size: Size(constraints.maxWidth/1.65 > 200 ? 200 : constraints.maxWidth/1.9 < 180 ? constraints.maxWidth/2.1 : constraints.maxWidth/1.75,
                  constraints.maxWidth/1.65 > 200 ? 200 : constraints.maxWidth/1.9 < 180 ? constraints.maxWidth/2.1 : constraints.maxWidth/1.75),
              textDistance: 12,
              textGap: 24,
              isLabelVisible: true,
              stroke: 1.3,
              textCenterAdjustmentOffset: const Offset(-14, -6),
              dataList: technologyStackList
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
          children: List.generate(technologyStackList.length, (index) =>
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                      color: technologyStackList[index].color.withAlpha(190),
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
                  Text("${technologyStackList[index].title} (${technologyStackList[index].percentage}%)", style:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236)),)
                ],),
          ),
        ),
      )
    ],
  );


  Widget _pieChart2(BoxConstraints constraints) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) => AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: state.isLangVisible ? 1 : 0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                    colors: [
                      ColorConstants.darkTextBlue.withOpacity(0.16),
                      ColorConstants.darkTextBlue.withOpacity(0.32),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.6), width: 1),
                image: DecorationImage(
                  image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.05), BlendMode.dstATop),
                )
            ),
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: constraints.maxWidth > 434 ? const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 52) : const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Programming Languages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236), shadows: [
                          Shadow(
                            color: ColorConstants.black.withAlpha(50),
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                          )
                        ]),),
                        const SizedBox(height: 64,),
                        Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child:
                            PieChart(
                                size: Size(constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9, constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9),
                                textDistance: 12,
                                textGap: 24,
                                isLabelVisible: true,
                                stroke: 1,
                                textCenterAdjustmentOffset: const Offset(-8, -6),
                                dataList: state.programmingLanguageList
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
                            children: List.generate(state.programmingLanguageList.length, (index) =>
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                        color: state.programmingLanguageList[index].color.withAlpha(190),
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
                                    Text("${state.programmingLanguageList[index].title} (${state.programmingLanguageList[index].percentage}%)", style:
                                      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236)),)
                                  ],),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),))
                ),
        ),
    );
  }


  Widget _pieChart3(BoxConstraints constraints) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) => AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: state.isDomainVisible ? 1 : 0,
          child: Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                    colors: [
                      ColorConstants.deepTextBlue.withOpacity(0.08),
                      ColorConstants.deepTextBlue.withOpacity(0.15),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.6), width: 1),
                image: DecorationImage(
                  image: const NetworkImage("https://images.pexels.com/photos/4915606/pexels-photo-4915606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.05), BlendMode.dstATop),
                )
            ),
            child:
            ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Domain Knowledge", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.white.withAlpha(236),
                        shadows: [
                          Shadow(
                            color: ColorConstants.black.withAlpha(50),
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                          )
                        ]),),
                        const SizedBox(height: 64,),
                        Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child:
                            PieChart(
                                size: Size(constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9, constraints.maxWidth/1.9 > 150 ? 150 : constraints.maxWidth/1.9),
                                textDistance: 12,
                                textGap: 24,
                                isLabelVisible: true,
                                stroke: 1,
                                textCenterAdjustmentOffset: const Offset(-14, -6),
                                dataList: state.domainKnowledgeList
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
                            children: List.generate(state.domainKnowledgeList.length, (index) =>
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                        color: state.domainKnowledgeList[index].color,
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
                                    Text("${state.domainKnowledgeList[index].title} (${state.domainKnowledgeList[index].percentage}%)", style:
                                      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.white.withAlpha(236)),)
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
