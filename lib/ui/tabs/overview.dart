import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/home/home_page_view_model.dart';
import 'package:portfolio/view_model/tabs/overview_tab_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OverviewTab extends StatelessWidget {
  OverviewTab({super.key, required this.viewModel});

  OverviewTabViewModel viewModel;
  // HomePageViewModel get _homeViewModel => Get.find<HomePageViewModel>();


  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child:
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorConstants.glassWhite),
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
                    viewModel.closeTab(0);
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
                    viewModel.minimizeTab(0);
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
                        Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: rootConstrains.maxWidth * 0.6,
                              child: _leftColumn),
                          // const SizedBox(width: 4,),
                          Expanded(child: _rightColumn)
                        ],
                                        ),
                      ],
                    ),
                  )
                  : ListView(
                      shrinkWrap: true,
                    children: [
                      _leftColumn,
                      // const SizedBox(height: 10,),
                      _rightColumn,
                      const SizedBox(height: 100,)
                    ],
              ),),
          ))
        ],
      ),
    )));
  }

  Widget get _leftColumn =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Row(
                        children: [
                          Obx(
                          () =>
                              AnimatedContainer(duration: const Duration(milliseconds: 640),
                              margin: const EdgeInsets.only(left: 75),
                              height: constraints.maxHeight * viewModel.bannerHeight.value,
                              width: (constraints.maxWidth * viewModel.bannerWidth.value) > 75 ? (constraints.maxWidth * viewModel.bannerWidth.value) - 75 : (constraints.maxWidth * viewModel.bannerWidth.value),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                                // gradient: LinearGradient(
                                //     colors: [
                                //       ColorConstants.lightGlassBlue.withOpacity(0.5),
                                //       ColorConstants.glassBlue.withOpacity(0.5),
                                //     ],
                                //     begin: FractionalOffset(0.0, 0.0),
                                //     end: FractionalOffset(1.0, 0.0),
                                //     stops: [0.0, 1.0],
                                //     tileMode: TileMode.clamp),
                                  image: DecorationImage(
                                    image: const NetworkImage("https://img.freepik.com/free-vector/blank-blue-halftone-background_53876-114466.jpg"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.9), BlendMode.dstATop),
                                  )
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 75),
                                  child: Visibility(
                                        visible: viewModel.bannerHeight.value == 1,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        child: AnimatedOpacity(
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.fastOutSlowIn,
                                        opacity: viewModel.isProfileBannerOpened.value ? 1 : 0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(child: Text("Santanu Mukherjee", style: TextStyle(fontSize: constraints.maxWidth > 500 ? 24 : 16, fontWeight: FontWeight.w700, color: ColorConstants.white),),),
                                            Text("Software Engineer", style: TextStyle(fontSize: constraints.maxWidth > 500 ? 16 : 12, fontWeight: FontWeight.w400, color: ColorConstants.glassWhite),),
                                            const SizedBox(height: 10,),
                                            AnimatedContainer(width: viewModel.isProfileBannerTitleVisible.value ? (constraints.maxWidth - 75) * 0.4 : 0,
                                              height: 1,
                                              color: ColorConstants.white.withAlpha(80), duration: const Duration(milliseconds: 300),
                                            ),
                                            const SizedBox(height: 10,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25, right: 25),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MouseRegion(
                                                    onHover: (pointer) {
                                                      viewModel.isLinkedInIconHovered.value = true;
                                                    },
                                                    onExit: (pointer) {
                                                      viewModel.isLinkedInIconHovered.value = false;
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final Uri url = Uri.parse('https://www.linkedin.com/in/mukherjee-santanu/');
                                                        if (!await launchUrl(url)) {
                                                        throw Exception('Could not launch $url');
                                                        }
                                                      },
                                                      child: Obx(
                                                          () => Image(height: 18,
                                                            width: 18,
                                                            image: const AssetImage(AssetConstants.icLinkedin),
                                                            color: viewModel.isLinkedInIconHovered.value ? ColorConstants.white : ColorConstants.glassWhite,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: (constraints.maxWidth -75) * 0.06),
                                                  MouseRegion(
                                                    onHover: (pointer) {
                                                      viewModel.isGitHubIconHovered.value = true;
                                                    },
                                                    onExit: (pointer) {
                                                      viewModel.isGitHubIconHovered.value = false;
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final Uri url = Uri.parse('https://github.com/TechnicalMeaw');
                                                        if (!await launchUrl(url)) {
                                                          throw Exception('Could not launch $url');
                                                        }
                                                      },
                                                      child: Obx(
                                                            () => Image(height: 18,
                                                          width: 18,
                                                          image: const AssetImage(AssetConstants.icGithub),
                                                          color: viewModel.isGitHubIconHovered.value ? ColorConstants.white : ColorConstants.glassWhite,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: (constraints.maxWidth -75) * 0.06),
                                                  MouseRegion(
                                                    onHover: (pointer) {
                                                      viewModel.isEmailIconHovered.value = true;
                                                    },
                                                    onExit: (pointer) {
                                                      viewModel.isEmailIconHovered.value = false;
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final Uri url = Uri.parse('mailto:santanumukherjeebh@gmail.com');
                                                        if (!await launchUrl(url)) {
                                                          throw Exception('Could not launch $url');
                                                        }
                                                      },
                                                      child: Obx(
                                                            () => Image(height: 18,
                                                          width: 18,
                                                          image: const AssetImage(AssetConstants.icEmail),
                                                          color: viewModel.isEmailIconHovered.value ? ColorConstants.white : ColorConstants.glassWhite,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: (constraints.maxWidth -75) * 0.06),
                                                  MouseRegion(
                                                    onHover: (pointer) {
                                                      viewModel.isPhoneIconHovered.value = true;
                                                      // viewModel.isPhoneNumberCopied.value = false;
                                                    },
                                                    onExit: (pointer) {
                                                      viewModel.isPhoneIconHovered.value = false;
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        // viewModel.isPhoneNumberCopied.value = true;
                                                        const snackBar = SnackBar(
                                                          content: Text('Phone number copied.', style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.w400),),
                                                          backgroundColor: ColorConstants.glassBlue,
                                                          elevation: 10,
                                                          behavior: SnackBarBehavior.floating,
                                                          margin: EdgeInsets.all(5),
                                                        );
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                        final Uri url = Uri.parse('tel://+918240251373');
                                                        if (!await launchUrl(url)) {
                                                          throw Exception('Could not launch $url');
                                                        }

                                                      },
                                                      child: Obx(
                                                            () => Image(height: 18,
                                                              width: 18,
                                                              image: const AssetImage(AssetConstants.icPhone),
                                                              color: viewModel.isPhoneIconHovered.value ? ColorConstants.white : ColorConstants.glassWhite,),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                                              ),
                                )
                              )),
                                                          ),
                          )
                        ],
                      ),
                    ),
                    // child: OverflowBox(
                    //     minWidth: 0.0,
                    //     minHeight: 0.0,
                    //     maxWidth: double.infinity,
                    //     child: const Image(image: NetworkImage("https://marketplace.canva.com/EAFiJ2cVosI/1/0/1600w/canva-blue-%26-white-modern-social-manager-linkedin-banner-Bj943IZL3p4.jpg"), fit: BoxFit.fill,)),
                    ),

                    Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(75),
                          border: Border.all(width: 5, color: ColorConstants.glassBlue),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorConstants.glassBlue,
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const CircleAvatar(backgroundImage: NetworkImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFlo8urDNphNYN4hjlXRXIlaDhd72DJYI43haKClXGJTPZ3DIF1tXWTH-x8-8KLj2AMnkrYgnxXyponzgCx-jFodVL5U2ohfhQqH0ktV50iVB_kpBbWl-FtFDzvp3fJLZp4oyVmIleBTZHuFC4M7T1Mw0x2E80IZozrwH392DUDVGR4hRaTQha3sqoMsw/s320/20230305_174155.jpg"),)),
                  ],
                ),
                // const SizedBox(height: 10,),
                // const Text("Santanu Mukherjee", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorConstants.white),),
                // const Text("Software Engineer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorConstants.glassBlue),),
                const SizedBox(height: 32,),
                Obx(
                ()=>
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 700),
                  opacity: viewModel.isSummaryVisible.value ? 1: 0,
                  curve: Curves.easeIn,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                        color: ColorConstants.glassWhite.withOpacity(0.8),
                    image: DecorationImage(
                      image: const NetworkImage("https://images.squarespace-cdn.com/content/v1/5ffb7c47a24aef1e5b942c13/1618436873379-0JSK85ANOQC8Y2QN1O98/gs-gradientsite2.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.8), BlendMode.dstATop),
                    )
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                        const SizedBox(height: 10,),
                        const Text(
                          "I'm a seasoned Flutter and Android developer with 2+ years of experience. From enhancing apps to building from scratch, I've served 500k+ users. Proficient in Django, FastAPI, Firebase, and AWS, let's create exceptional software together!",
                          softWrap: true,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),
                          overflow: TextOverflow.visible,
                        ),

                        const SizedBox(height: 32,),
                        Obx(
                              ()=> AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: viewModel.isHireMeVisible.value ? 1: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // final Uri url = Uri.parse('mailto:santanumukherjeebh@gmail.com?subject=Exciting Opportunity: Join Our Team!&body=Hi Santanu,\n\nImpressed by your portfolio, we\'re keen on having you join our team. Ready to chat about it?\n\nBest regards,\n[Your Name]');
                                      final Uri url = Uri.parse('https://1drv.ms/b/s!AofcIzI1lmhnhLlwwjJGyPUD6OicEg?e=vUoFsM');
                                      if (!await launchUrl(url)) {
                                        throw Exception('Could not launch $url');
                                      }
                                    },
                                    onHover: (isHovered){
                                      viewModel.isDownloadCvBtnHovered.value = isHovered;
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      // margin: EdgeInsets.only(
                                      // left:  viewModel.isDownloadCvBtnHovered.value? 2.5 : 3,
                                      // right: viewModel.isDownloadCvBtnHovered.value? 2.5 : 3,
                                      // top: viewModel.isDownloadCvBtnHovered.value? 0: 1,
                                      // bottom: viewModel.isDownloadCvBtnHovered.value? 0: 1,
                                      // ),
                                      padding: EdgeInsets.symmetric(horizontal: !viewModel.isDownloadCvBtnHovered.value? 24 : 24,
                                          // vertical: viewModel.isDownloadCvBtnHovered.value? 12 : 12
                                          vertical: 12
                                      ),
                                      decoration: BoxDecoration(color:!viewModel.isDownloadCvBtnHovered.value? ColorConstants.white.withOpacity(0.8) : ColorConstants.black.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(width: 1, color: !viewModel.isDownloadCvBtnHovered.value? ColorConstants.black : ColorConstants.white),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorConstants.glassBlue.withOpacity(0.4),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 0), // changes position of shadow
                                          ),],),
                                      child: Text("Download CV", style: TextStyle(fontSize: 14,
                                          fontWeight: !viewModel.isDownloadCvBtnHovered.value? FontWeight.w500: FontWeight.w500,
                                          color: !viewModel.isDownloadCvBtnHovered.value? ColorConstants.black : ColorConstants.white),
                                      ),),
                                  ),
                                  const SizedBox(width: 24,),

                                  // AnimatedContainer(
                                  //   duration: const Duration(milliseconds: 200),
                                  // padding: EdgeInsets.symmetric(horizontal: viewModel.isDownloadCvBtnHovered.value? 22 : 20, vertical: viewModel.isDownloadCvBtnHovered.value? 14 : 12),
                                  // decoration: BoxDecoration(
                                  // color: viewModel.isDownloadCvBtnHovered.value? ColorConstants.black.withOpacity(0.8) : ColorConstants.black.withOpacity(0.6),
                                  // borderRadius: BorderRadius.circular(24),
                                  // border: Border.all(width: 1, color: ColorConstants.glassWhite),
                                  // ),
                                  // child:
                                  InkWell(
                                    onTap: (){
                                      viewModel.animateToProjectsTab();
                                    },
                                    onHover: (isHovered){
                                      viewModel.isViewProjectsBtnHovered.value = isHovered;
                                    },
                                    child: Obx(
                                          ()=> Text("View Projects",
                                        style: TextStyle(fontSize: 14, fontWeight: viewModel.isViewProjectsBtnHovered.value ? FontWeight.w700 : FontWeight.w500, color:viewModel.isViewProjectsBtnHovered.value ? ColorConstants.black : ColorConstants.darkGray,
                                            decoration: TextDecoration.underline,
                                            decorationColor: !viewModel.isViewProjectsBtnHovered.value ? ColorConstants.glassBlack : ColorConstants.darkGray),),
                                    ),
                                  )
                                  // ,)

                                ],
                              )),
                        ),
                      ],
                    ),))
                  ),
                )
                ),


                // const SizedBox(height: 32,),
                // LayoutBuilder(
                //   builder: (context, constraints) =>
                //       Obx(
                //             ()=>
                //             AnimatedOpacity(
                //                 duration: const Duration(milliseconds: 700),
                //                 opacity: viewModel.isSummaryVisible.value ? 1: 0,
                //                 curve: Curves.easeIn,
                //                 child:
                //                 // color: ColorConstants.glassBlue.withAlpha(70),
                //
                //                 // ),
                //                 Container(
                //                   // color: ColorConstants.crossRed,
                //                   // padding: const EdgeInsets.all(30.5),
                //
                //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                //                       // color: ColorConstants.glassWhite.withOpacity(0.4),
                //                       // border: Border.all(width: 1.5, color: ColorConstants.glassWhite.withOpacity(0.4))
                //                   ),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       // const Text("Projects", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                //                       // const SizedBox(height: 20,),
                //                       SizedBox(
                //                         width: constraints.maxWidth,
                //                         child: Wrap(
                //                           alignment: constraints.maxWidth < 400 ? WrapAlignment.spaceEvenly : WrapAlignment.spaceBetween,
                //                           runAlignment: WrapAlignment.spaceBetween,
                //                           crossAxisAlignment: WrapCrossAlignment.center,
                //                           spacing: 10,
                //                           runSpacing: 10,
                //                           children: [
                //                             Container(
                //                               // margin: const EdgeInsets.all(16),
                //                               padding: const EdgeInsets.all(32),
                //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.textBlue.withOpacity(0.5),),
                //                               child: ClipRect(
                //                                 child: BackdropFilter(
                //                                   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //                                   child:  const Column(
                //                                     children: [
                //                                       Text("7+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ColorConstants.white),),
                //                                       Text("Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),),
                //                                     ],
                //                                   ),
                //                                 ),),
                //                             ),
                //                             Container(
                //                               // margin: const EdgeInsets.all(16),
                //                               padding: const EdgeInsets.all(32),
                //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.glassWhite.withOpacity(0.4),),
                //                               child: ClipRect(
                //                                 child: BackdropFilter(
                //                                   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //                                   child:  const Column(
                //                                     children: [
                //                                       Text("7+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ColorConstants.black),),
                //                                       Text("Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),),
                //                                     ],
                //                                   ),
                //                                 ),),
                //                             ),
                //
                //                             Container(
                //                               // margin: const EdgeInsets.all(16),
                //                               padding: const EdgeInsets.all(32),
                //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.textBlue.withOpacity(0.5),),
                //                               child: ClipRect(
                //                                 child: BackdropFilter(
                //                                   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //                                   child:  const Column(
                //                                     children: [
                //                                       Text("7+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ColorConstants.white),),
                //                                       Text("Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),),
                //                                     ],
                //                                   ),
                //                                 ),),
                //                             ),
                //                             Container(
                //                               // margin: const EdgeInsets.all(16),
                //                               padding: const EdgeInsets.all(32),
                //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.glassWhite.withOpacity(0.4),),
                //                               child: ClipRect(
                //                                 child: BackdropFilter(
                //                                   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //                                   child:  const Column(
                //                                     children: [
                //                                       Text("7+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ColorConstants.black),),
                //                                       Text("Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),),
                //                                     ],
                //                                   ),
                //                                 ),),
                //                             ),
                //                             Container(
                //                               // margin: const EdgeInsets.all(16),
                //                               padding: const EdgeInsets.all(32),
                //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.textBlue.withOpacity(0.5),),
                //                               child: ClipRect(
                //                                 child: BackdropFilter(
                //                                   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //                                   child:  const Column(
                //                                     children: [
                //                                       Text("7+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ColorConstants.white),),
                //                                       Text("Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),),
                //                                     ],
                //                                   ),
                //                                 ),),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 )
                //             ),
                //       ),
                // ),








                const SizedBox(height: 32,),
                LayoutBuilder(
                  builder: (context, constraints) =>
                      Obx(
                            ()=>
                            Container(
                              // color: ColorConstants.crossRed,
                              // padding: const EdgeInsets.all(30.5),

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                  // color: ColorConstants.glassBlue.withOpacity(0.3),
                                  // border: Border.all(width: 1.5, color: ColorConstants.glassWhite.withOpacity(0.4))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Text("Achievements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                                  // const SizedBox(height: 20,),
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    child: Wrap(
                                      alignment: constraints.maxWidth < 500 ? WrapAlignment.spaceEvenly : WrapAlignment.spaceBetween,
                                      runAlignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        AnimatedOpacity(
                                        duration: const Duration(milliseconds: 700),
                                        opacity: viewModel.isKPI1Visible.value ? 1: 0,
                                        curve: Curves.easeIn,
                                        child: Obx(
                                            ()=> AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                              // margin: const EdgeInsets.all(16),
                                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.textBlue : ColorConstants.cyanBlue.withOpacity(0.8),),
                                              child: ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                  child: Column(
                                                    children: [
                                                      Text("${viewModel.kpi1Value.value}+", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue),),
                                                      const SizedBox(height: 12,),
                                                      Text("Years Experience",
                                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 8,),
                                                      InkWell(
                                                        onTap: (){
                                                          viewModel.animateToExperienceTab();
                                                        },
                                                        onHover: (isHovered){
                                                          viewModel.kpi1KnowMoreHovered.value = isHovered;
                                                        },
                                                        child: Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,
                                                            color: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue, decoration: TextDecoration.underline,
                                                              decorationColor: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue,
                                                          shadows: <Shadow>[
                                                            Shadow(
                                                            offset: const Offset(0.0, 0.0),
                                                          blurRadius: 15.0,
                                                          color: viewModel.kpi1KnowMoreHovered.value ? ColorConstants.white : ColorConstants.cyanBlue,
                                                        ),
                                                          ],
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),),
                                            ),
                                        ),
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(milliseconds: 700),
                                          opacity: viewModel.isKPI2Visible.value ? 1: 0,
                                          curve: Curves.easeIn,
                                          child: Obx(
                                          ()=> AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                              // margin: const EdgeInsets.all(16),
                                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.black.withOpacity(0.8): ColorConstants.white.withOpacity(0.8),
                                                                        // border: Border.all(color: ColorConstants.white, width: 1)

                                              ),
                                              child: ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                  child: Column(
                                                    children: [
                                                      Text("${viewModel.kpi2Value.value}+", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.white: ColorConstants.black),),
                                                      const SizedBox(height: 12,),
                                                      Text("Handled Project", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.white: ColorConstants.black),),
                                                      const SizedBox(height: 8,),
                                                      // const Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: ColorConstants.black,
                                                      //     decoration: TextDecoration.underline, decorationColor: ColorConstants.glassBlack),),
                                                      MouseRegion(
                                                        onHover: (pointer){
                                                          viewModel.kpi2KnowMoreHovered.value = true;
                                                        },
                                                        onExit: (pointer){
                                                          viewModel.kpi2KnowMoreHovered.value = false;
                                                        },
                                                        child: InkWell(
                                                          onTap: (){
                                                            viewModel.animateToProjectsTab();
                                                          },
                                                          child: Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,
                                                                                                                      color: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.white : ColorConstants.black, decoration: TextDecoration.underline,
                                                                                                                      decorationColor: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.white : ColorConstants.black,
                                                                                                                      shadows: <Shadow>[
                                                          Shadow(
                                                            offset: const Offset(0.0, 0.0),
                                                            blurRadius: 10.0,
                                                            color: viewModel.kpi2KnowMoreHovered.value ? ColorConstants.white : ColorConstants.glassWhite,
                                                          ),
                                                                                                                      ],
                                                                                                                    ),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),),
                                            ),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(milliseconds: 700),
                                          opacity: viewModel.isKPI3Visible.value ? 1: 0,
                                          curve: Curves.easeIn,
                                          child: Obx(
                                              ()=> AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                              // margin: const EdgeInsets.all(16),
                                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.lightYellow : ColorConstants.lightGlassBlue.withOpacity(0.8),),
                                              child: ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                  child: Column(
                                                    children: [
                                                      Text("${viewModel.kpi3Value.value}+", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white),),
                                                      const SizedBox(height: 12,),
                                                      Text("Finished Apps", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white),),
                                                      const SizedBox(height: 8,),
                                                      // const Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: ColorConstants.white, decoration: TextDecoration.underline, decorationColor: ColorConstants.white),),
                                                      MouseRegion(
                                                        onHover: (pointer){
                                                          viewModel.kpi3KnowMoreHovered.value = true;
                                                        },
                                                        onExit: (pointer){
                                                          viewModel.kpi3KnowMoreHovered.value = false;
                                                        },
                                                        child: InkWell(
                                                          onTap: (){
                                                            viewModel.animateToProjectsTab();
                                                          },
                                                          child: Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,
                                                                                                                        color: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white, decoration: TextDecoration.underline,
                                                                                                                        decorationColor: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white,
                                                                                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: const Offset(0.0, 0.0),
                                                            blurRadius: 10.0,
                                                            color: viewModel.kpi3KnowMoreHovered.value ? ColorConstants.glassBlack : ColorConstants.glassBlue,
                                                          ),
                                                                                                                        ],
                                                                                                                      ),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),),
                                            ),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(milliseconds: 700),
                                          opacity: viewModel.isKPI4Visible.value ? 1: 0,
                                          curve: Curves.easeIn,
                                          child: Obx(
                                              ()=> AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                              // margin: const EdgeInsets.all(16),
                                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: viewModel.kpi4KnowMoreHovered.value? ColorConstants.white.withOpacity(0.8) : ColorConstants.textBlue.withOpacity(0.8),),
                                              child: ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                  child: Column(
                                                    children: [
                                                      Text("${viewModel.kpi4Value.value}+", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: viewModel.kpi4KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white),),
                                                      const SizedBox(height: 12,),
                                                      Text("Architected Apps", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.kpi4KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white),),
                                                      const SizedBox(height: 8,),
                                                      MouseRegion(
                                                          onHover: (pointer){
                                                            viewModel.kpi4KnowMoreHovered.value = true;
                                                          },
                                                          onExit: (pointer){
                                                            viewModel.kpi4KnowMoreHovered.value = false;
                                                          },
                                                          child: InkWell(
                                                            onTap: (){
                                                              viewModel.animateToProjectsTab();
                                                            },
                                                            child: Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,
                                                              color: viewModel.kpi4KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white, decoration: TextDecoration.underline,
                                                              decorationColor: viewModel.kpi4KnowMoreHovered.value ? ColorConstants.black : ColorConstants.white,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                  offset: const Offset(0.0, 0.0),
                                                                  blurRadius: 15.0,
                                                                  color: viewModel.kpi4KnowMoreHovered.value ? ColorConstants.black : ColorConstants.glassBlue,
                                                                ),
                                                              ],
                                                            ),),
                                                          ),
                                                      )],
                                                  ),
                                                ),),
                                            ),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(milliseconds: 700),
                                          opacity: viewModel.isKPI5Visible.value ? 1: 0,
                                          curve: Curves.easeIn,
                                          child: Obx(
                                                ()=> AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                              // margin: const EdgeInsets.all(16),
                                                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: viewModel.kpi5KnowMoreHovered.value ? ColorConstants.black : ColorConstants.cyanBlue.withOpacity(0.8),),
                                                child: ClipRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                    child: Column(
                                                      children: [
                                                        Text("${viewModel.kpi5Value.value}k+", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: viewModel.kpi5KnowMoreHovered.value ?ColorConstants.white : ColorConstants.textBlue),),
                                                        const SizedBox(height: 12,),
                                                        Text("Lines of Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: viewModel.kpi5KnowMoreHovered.value ?ColorConstants.white : ColorConstants.textBlue),),
                                                        const SizedBox(height: 8,),
                                                        // const Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: ColorConstants.black,
                                                        //     decoration: TextDecoration.underline, decorationColor: ColorConstants.glassBlack),),
                                                        MouseRegion(
                                                          onHover: (pointer){
                                                            viewModel.kpi5KnowMoreHovered.value = true;
                                                          },
                                                          onExit: (pointer){
                                                            viewModel.kpi5KnowMoreHovered.value = false;
                                                          },
                                                          child: InkWell(
                                                            onTap: (){
                                                              viewModel.animateToExperienceTab();
                                                            },
                                                            child: Text("Know More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,
                                                              color: viewModel.kpi5KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue, decoration: TextDecoration.underline,
                                                              decorationColor: viewModel.kpi5KnowMoreHovered.value ? ColorConstants.white : ColorConstants.textBlue,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                  offset: const Offset(0.0, 0.0),
                                                                  blurRadius: 15.0,
                                                                  color: viewModel.kpi5KnowMoreHovered.value ? ColorConstants.white : ColorConstants.cyanBlue,
                                                                ),
                                                              ],
                                                            ),),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                ),

                const SizedBox(height: 32,),
                Obx(
                        ()=>
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 700),
                          opacity: viewModel.isKPI3Visible.value ? 1: 0,
                          curve: Curves.easeIn,
                          child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                  color: ColorConstants.glassWhite.withAlpha(70),
                                  image: DecorationImage(
                                    image: const NetworkImage("https://img.freepik.com/premium-photo/beautiful-colorful-background-vector-gradation-set-wallpaper-printable-template_515653-42.jpg"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.8), BlendMode.dstATop),
                                  )
                              ),
                              child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text("Education", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                                            // Text("Know More", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.black, decoration: TextDecoration.underline),),
                                            InkWell(
                                              onTap: (){
                                                viewModel.animateToExperienceTab();
                                              },
                                              onHover: (isHovered){
                                                viewModel.educationViewAllHovered.value = isHovered;
                                              },
                                              child: Obx(
                                                    () => Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Text("View All", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,
                                                                                                          color: viewModel.educationViewAllHovered.value ? ColorConstants.white : ColorConstants.black, decoration: TextDecoration.underline,
                                                                                                          decorationColor: viewModel.educationViewAllHovered.value ? ColorConstants.white : ColorConstants.black,
                                                                                                          shadows: <Shadow>[
                                                      Shadow(
                                                        offset: const Offset(0.0, 0.0),
                                                        blurRadius: 10.0,
                                                        color: viewModel.educationViewAllHovered.value ? ColorConstants.black : ColorConstants.white,
                                                      ),
                                                                                                          ],
                                                                                                        ),),
                                                    ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        const Wrap(
                                          children: [
                                            Text("Bachelor of Technology, Computer Science & Engineering", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                          ],
                                        ),
                                        const Text("Dream Institute of Technology", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                        const SizedBox(height: 2,),
                                        const Text("2018 - 2022", style: TextStyle(fontSize: 10, color: ColorConstants.textBlue, fontWeight: FontWeight.w400)),
                                        const SizedBox(height: 6,),
                                        const Text("CGPA: 9.04", style: TextStyle(fontSize: 12, color: ColorConstants.black, fontWeight: FontWeight.w500)),
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Container(
                                        //         height: 300,
                                        //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.glassBlue.withOpacity(0.4),),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 16,),
                                        //     Expanded(
                                        //       child: Container(
                                        //         height: 300,
                                        //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorConstants.glassWhite.withOpacity(0.2),),
                                        //       ),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),))
                          ),
                        )
                ),

                const SizedBox(height: 16,),

              ],
            ),
          )

        ],
      );

  Widget get _rightColumn =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
          () => AnimatedOpacity(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
            opacity: viewModel.isSkillsVisible.value ? 1: 0,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: ColorConstants.cyanBlue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: const NetworkImage("https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.8), BlendMode.dstATop),

                )
                // gradient: LinearGradient(
                //     colors: [
                //       ColorConstants.lightYellow.withAlpha(20),
                //       ColorConstants.cyanBlue.withAlpha(50),
                //     ],
                //     begin: const FractionalOffset(0.0, 0.0),
                //     end: const FractionalOffset(1.0, 0.0),
                //     stops: const [0.0, 1.0],
                //     tileMode: TileMode.clamp),
                // color: ColorConstants.glassWhite
              ),
              child:
              ClipRect(
              child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                        InkWell(
                          onTap: (){
                            viewModel.animateToExperienceTab();
                          },
                          onHover: (isHovered){
                            viewModel.skillsViewAllHovered.value = isHovered;
                          },
                          child: Text("View All", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,
                            color: viewModel.skillsViewAllHovered.value ? ColorConstants.white : ColorConstants.black, decoration: TextDecoration.underline,
                            decorationColor: viewModel.skillsViewAllHovered.value ? ColorConstants.white : ColorConstants.black,
                            shadows: <Shadow>[
                              Shadow(
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                color: viewModel.skillsViewAllHovered.value ? ColorConstants.black : ColorConstants.white,
                              ),
                            ],
                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Android development", rating: viewModel.androidSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Flutter", rating: viewModel.flutterSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Django", rating: viewModel.djangoSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "FastApi", rating: viewModel.fastApiSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Problem Solving", rating: viewModel.problemSolvingSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Firebase", rating: viewModel.firebaseSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Python", rating: viewModel.pythonSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "DSA", rating: viewModel.dsaSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "AWS", rating: viewModel.awsSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Kotlin", rating: viewModel.kotlinSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Dart", rating: viewModel.dartSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Java", rating: viewModel.javaSkillRating.value)),
                    const SizedBox(height: 10,),
                    Obx(()=> skillRatingWidget(skillName: "Git", rating: viewModel.gitSkillRating.value)),
                    const SizedBox(height: 32,),
                  ],
                ),
              ),))
            ),
          ),
          ),

          const SizedBox(height: 16,),
          Obx(()=>
              AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: viewModel.isKPI1Visible.value ? 1: 0,
              curve: Curves.easeIn,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                      color: ColorConstants.glassWhite.withOpacity(0.8),
                      // image: DecorationImage(
                      //   image: const NetworkImage("https://images.squarespace-cdn.com/content/v1/5ffb7c47a24aef1e5b942c13/1618436873379-0JSK85ANOQC8Y2QN1O98/gs-gradientsite2.png"),
                      //   fit: BoxFit.cover,
                      //   colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.5), BlendMode.dstATop),
                      // )
                  ),
                  child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Row(
                             children: [
                               Text("Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.black),),
                             ],
                           ),
                           const SizedBox(height: 10,),
                           Wrap(
                             children: [
                               const Text(
                                 "https://play.google.com/store/apps/details?id=com.sbig.insurance",
                                 softWrap: true,
                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),
                                 overflow: TextOverflow.visible,
                               ),
                               const SizedBox(width: 4,),
                               InkWell(
                                   onTap: () async {
                                      final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.sbig.insurance');
                                      if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                   }},
                                   onHover: (isHovered){
                                     viewModel.link1Hovered.value = isHovered;
                                   },
                                   child: Obx(()=> Icon(Icons.open_in_new_rounded, size: 10, color: viewModel.link1Hovered.value? ColorConstants.orange : ColorConstants.textBlue,)))
                             ],
                           ),
                           Wrap(
                             children: [
                               const Text(
                                 "https://plantonic.co.in",
                                 softWrap: true,
                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),
                                 overflow: TextOverflow.visible,
                               ),
                               const SizedBox(width: 4,),
                               InkWell(
                                   onTap: () async {
                                     final Uri url = Uri.parse('https://plantonic.co.in');
                                     if (!await launchUrl(url)) {
                                       throw Exception('Could not launch $url');
                                     }},
                                   onHover: (isHovered){
                                     viewModel.link2Hovered.value = isHovered;
                                   },
                                   child: Obx(()=> Icon(Icons.open_in_new_rounded, size: 10, color: viewModel.link2Hovered.value? ColorConstants.orange : ColorConstants.textBlue,)))
                             ],
                           ),
                           Wrap(
                             children: [
                               const Text(
                                 "https://play.google.com/store/apps/details?id=com.religare.healthinsurance",
                                 softWrap: true,
                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),
                                 overflow: TextOverflow.visible,
                               ),
                               const SizedBox(width: 4,),
                               InkWell(
                                   onTap: () async {
                                     final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.religare.healthinsurance');
                                     if (!await launchUrl(url)) {
                                       throw Exception('Could not launch $url');
                                     }},
                                   onHover: (isHovered){
                                     viewModel.link3Hovered.value = isHovered;
                                   },
                                   child: Obx(()=> Icon(Icons.open_in_new_rounded, size: 10, color: viewModel.link3Hovered.value? ColorConstants.orange : ColorConstants.textBlue,)))
                             ],
                           ),
                           Wrap(
                             children: [
                               const Text(
                                 "https://blaze.solar",
                                 softWrap: true,
                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.black),
                                 overflow: TextOverflow.visible,
                               ),
                               const SizedBox(width: 4,),
                               InkWell(
                                   onTap: () async {
                                     final Uri url = Uri.parse('https://blaze.solar');
                                     if (!await launchUrl(url)) {
                                       throw Exception('Could not launch $url');
                                     }},
                                   onHover: (isHovered){
                                     viewModel.link4Hovered.value = isHovered;
                                   },
                                   child: Obx(()=> Icon(Icons.open_in_new_rounded, size: 10, color: viewModel.link4Hovered.value? ColorConstants.orange : ColorConstants.textBlue,)))
                             ],
                           ),
                         ],
                                                    ),))
              ),
            ),
          ),

          const SizedBox(height: 20,),

        ],
      );


  Widget skillRatingWidget({required String skillName, required int rating}){
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: 28,
        child: Stack(
          children: [
            Container(
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 0.8, color: ColorConstants.textBlue),
                    // color: ColorConstants.white,
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: ColorConstants.glassBlue,
                    //     spreadRadius: 0,
                    //     blurRadius: 1,
                    //     offset: Offset(0, 0), // changes position of shadow
                    //   ),]
                )
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 40),
                curve: Curves.easeIn,
                width: constraints.maxWidth * rating * 0.01,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.cyanBlue.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 0), // changes position of shadow
                      ),],
                    gradient: LinearGradient(
                        colors: [

                          ColorConstants.glassWhite.withOpacity(0.8),
                          ColorConstants.textBlue.withOpacity(0.8),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(4),
                    color: ColorConstants.darkBlack
                ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                opacity: rating > 20 ? 1 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const SizedBox(width: 5,),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Text(skillName,
                    //     softWrap: true,
                    //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ColorConstants.textBlue),
                    //     overflow: TextOverflow.visible,
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("$rating%",
                        softWrap: true,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.white),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(skillName,
                  softWrap: true,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ColorConstants.glassBlack,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 15.0,
                        color: ColorConstants.white,
                      ),
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 1.0,
                        color: ColorConstants.glassBlue,
                      ),
                    ],
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
