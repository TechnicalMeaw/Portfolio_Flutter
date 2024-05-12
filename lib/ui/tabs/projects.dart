import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/tabs/projects_tab_view_model.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key, required this.viewModel});

  final ProjectsTabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child:
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.glassWhite),
              child: Column(
                children: [
                  // Top Common Widget
                  Container(
                    height: 12,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            viewModel.closeTab(2);
                            viewModel.crossBtnHovered.value = false;
                          },
                          onHover: (isHovered) {
                            viewModel.crossBtnHovered.value = isHovered;
                          },
                          child: Obx(
                                () =>
                                AnimatedContainer(
                                    margin: EdgeInsets.only(
                                        left: viewModel.crossBtnHovered.value
                                            ? 0
                                            : 2,
                                        right: viewModel.crossBtnHovered.value
                                            ? 0
                                            : 2),
                                    height: viewModel.crossBtnHovered.value
                                        ? 12
                                        : 8,
                                    width: viewModel.crossBtnHovered.value
                                        ? 12
                                        : 8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            7.5),
                                        color: ColorConstants.crossRed),
                                    duration: const Duration(milliseconds: 125),
                                    child: viewModel.crossBtnHovered.value
                                        ? const Icon(Icons.close, size: 10,)
                                        : const SizedBox(height: 8, width: 8,)),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            viewModel.minimizeTab(2);
                            viewModel.minimizeBtnHovered.value = false;
                          },
                          onHover: (isHovered) {
                            viewModel.minimizeBtnHovered.value = isHovered;
                          },
                          child: Obx(
                                () =>
                                AnimatedContainer(
                                    margin: EdgeInsets.only(
                                        left: viewModel.minimizeBtnHovered.value
                                            ? 1
                                            : 3),
                                    height: viewModel.minimizeBtnHovered.value
                                        ? 12
                                        : 8,
                                    width: viewModel.minimizeBtnHovered.value
                                        ? 12
                                        : 8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            7.5),
                                        color: ColorConstants.minimizeYellow),
                                    duration: const Duration(milliseconds: 125),
                                    child: viewModel.minimizeBtnHovered.value
                                        ? const Icon(Icons.remove, size: 10,)
                                        : const SizedBox(height: 8, width: 8,)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Expanded(child: LayoutBuilder(
                    builder: (context, rootConstrains) =>
                        Container(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          color: ColorConstants.glassBlack.withOpacity(0.1),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const SizedBox(height: 16,),

                              _project1Widget,
                              const SizedBox(height: 32,),
                              _project2Widget,
                              const SizedBox(height: 100,)
                            ],
                          ),),
                  ))
                ],
              ),
            )));
  }

  Widget get _project1Widget => Obx(
      ()=> AnimatedOpacity(
        opacity: viewModel.isProject1Visible.value ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: ColorConstants.cyanBlue.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
              )
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 800 ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  project1Image(const BoxConstraints(maxWidth: 420)),
                  const SizedBox(width: 32,),
                  Expanded(child: project1Desc),
                ],
              ) : Column(
                children: [
                  project1Image(constraints),
                  const SizedBox(height: 32,),
                  project1Desc,
                ],
              );
            }
          ),
        ),
            ),
      ),
  );


  Widget get _project2Widget => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          color: ColorConstants.glassWhite,
          borderRadius: BorderRadius.circular(16),
          // image: DecorationImage(
          //   image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.6), BlendMode.dstATop),
          // )
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text("Coming Soon"),
        ),
      )
    ),
  );

  Widget project1Image(BoxConstraints constraints) => Obx(
    ()=> AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      opacity: viewModel.isProject1ImageVisible.value ? 1 : 0,
      child: Container(
          width: constraints.maxWidth,
          // margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: ColorConstants.lightQueenViolet.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(
              color: ColorConstants.glassBlack.withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(1, 1), // changes position of shadow
            ),],
          ),
          // padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(AssetConstants.imgPlantonicThumb))
      ),
    ),
  );


  Widget get project1Desc =>
      Obx(
          ()=> AnimatedOpacity(
            opacity: viewModel.isProject1DescVisible.value ? 1 : 0,
            duration: const Duration(milliseconds: 800),
            child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.glassWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              // boxShadow: [BoxShadow(
              //   color: ColorConstants.glassWhite.withOpacity(0.6),
              //   spreadRadius: 0,
              //   blurRadius: 5,
              //   offset: const Offset(1, 1), // changes position of shadow
              // ),],
              // image: DecorationImage(
              //   image: const NetworkImage("https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkwNC1udW5ueS0wMTIteC1qb2I1OTguanBn.jpg"),
              //   fit: BoxFit.cover,
              //   colorFilter: ColorFilter.mode(ColorConstants.white.withOpacity(0.2), BlendMode.dstATop),
              // )
            ),
            padding: EdgeInsets.all(32),
            // decoration: BoxDecoration(
            //   color: ColorConstants.white.withOpacity(0.3),
            //   borderRadius: BorderRadius.circular(16),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Plantonic", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: ColorConstants.darkGray),),
                const SizedBox(height: 4),
                const Text("An E-Commerce Application", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ColorConstants.darkGray),),
                const SizedBox(height: 2),
                const Text("2023 - 2024", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.textBlue),),
                const SizedBox(height: 24),

                point("End-to-end plant shopping e-commerce application."),
                const SizedBox(height: 4,),
                point("Search plant, mark as favourite, add to cart, and place order and get track of your order seamlessly."),
                const SizedBox(height: 4,),
                point("Smooth order processing and inventory management through admin app."),
                const SizedBox(height: 4,),
                point("User authentication with phone number and Google OAuth with AES-256 encryption for secure data transfer."),
                // const Text("Crafted front-end development in native Android, creating scalable UIs, alongside back-end in Python with FastAPI for seamless API integration.\nManaged databases with a blend of MySQL and Firebase, tailoring storage solutions based on usage and data type for product information and user data.\nEngineered a secure custom authentication solution with Firebase OAuth (phone number, Google OAuth) and JWT tokens, leveraging FastAPI OAuth2PasswordBearer and AES-256 Encryption.\nSeamlessly integrated with third-party delivery partners for streamlined order delivery.",
                //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.darkGray),),
                const SizedBox(height: 32,),

                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse('https://plantonic.co.in/');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  onHover: (isHovered){
                    viewModel.isProject1KnowMoreBtnHovered.value = isHovered;
                  },
                  child: Obx(
                        () => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),

                      padding: EdgeInsets.symmetric(horizontal: !viewModel.isProject1KnowMoreBtnHovered.value? 24 : 24,
                          // vertical: viewModel.isDownloadCvBtnHovered.value? 12 : 12
                          vertical: 12
                      ),
                      decoration: BoxDecoration(color: !viewModel.isProject1KnowMoreBtnHovered.value? ColorConstants.white.withOpacity(0.8) : ColorConstants.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(width: 1, color: !viewModel.isProject1KnowMoreBtnHovered.value? ColorConstants.black : ColorConstants.white),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.glassBlue.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),],),
                      child: Text("Know More", style: TextStyle(fontSize: 14,
                          fontWeight: !viewModel.isProject1KnowMoreBtnHovered.value? FontWeight.w500: FontWeight.w500,
                          color: !viewModel.isProject1KnowMoreBtnHovered.value? ColorConstants.black : ColorConstants.white),
                      ),),

                    //   Text("Know More",
                    // style: TextStyle(fontSize: 14, fontWeight: !viewModel.isProject1KnowMoreBtnHovered.value ? FontWeight.w700 : FontWeight.w500, color: !viewModel.isProject1KnowMoreBtnHovered.value ? ColorConstants.black : ColorConstants.white,
                    //     decoration: TextDecoration.underline,
                    //     decorationColor: viewModel.isProject1KnowMoreBtnHovered.value ? ColorConstants.glassWhite : ColorConstants.glassBlack),),
                  ),
                ),
              ],
            ),
                    ),
          ),
      );

  Widget point(String title) =>  Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(width: 4,),
    Container(
      margin: const EdgeInsets.only(top: 8),
      height: 5,
      width: 5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1.5, color: ColorConstants.glassBlack),
          color: ColorConstants.black
      ),
    ),
    const SizedBox(width: 10,),
    Flexible(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if(companyData.keyResponsibilities[keyIndex].title != "")
        //   Text("companyData.keyResponsibilities[keyIndex].title", style: const TextStyle(fontSize: 14, color: ColorConstants.black,
        //       fontWeight: FontWeight.w500)),
        // if(companyData.keyResponsibilities[keyIndex].title != "")
        //   const SizedBox(height: 2,),
        Text.rich(TextSpan(
            children: List.generate(1, (textIndex) =>
                TextSpan(text: title,
                    style: const TextStyle(fontSize: 14, color: ColorConstants.darkGray,
                      // fontWeight: companyData.keyResponsibilities[keyIndex].responsibilityTexts[textIndex].textType == TextType.bold ? FontWeight.w500
                      // : FontWeight.lerp(FontWeight.w400, FontWeight.w500, 0.5),
                      //     : FontWeight.w400,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.1,
                          color: ColorConstants.deepBlue,
                        ),
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.5,
                          color: ColorConstants.textBlue,
                        ),
                      ],
                    )))),
        ),
      ],
    )
    ),
  ],
);

}