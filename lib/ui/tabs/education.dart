import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/tabs/education_tab_view_model.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key, required this.viewModel});

  final EducationTabViewModel viewModel;

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
                            viewModel.closeTab(3);
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
                            viewModel.minimizeTab(3);
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
                  Expanded(
                    child: Container(
                      color: ColorConstants.glassBlack.withOpacity(0.1),
                      child: Center(
                        child:  Text("Coming Soon"),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
