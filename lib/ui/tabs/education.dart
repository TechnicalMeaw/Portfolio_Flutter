import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/tabs/education_tab_view_model.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key, required this.viewModel});

  final EducationTabViewModel viewModel;

  Widget _buildTopBarButton({
    required RxBool hoverVariable,
    required VoidCallback onTap,
    required Color buttonColor,
    required IconData iconData,
    required bool isCloseButton, // To differentiate margin logic
  }) {
    return InkWell(
      onTap: () {
        onTap();
        hoverVariable.value = false;
      },
      onHover: (isHovered) {
        hoverVariable.value = isHovered;
      },
      child: Obx(
            () => AnimatedContainer(
          margin: EdgeInsets.only(
              left: hoverVariable.value
                  ? (isCloseButton ? 0 : 4)
                  : (isCloseButton ? 2 : 3),
              right: hoverVariable.value ? 0 : (isCloseButton ? 4 : 0)),
          height: hoverVariable.value ? 12 : 8,
          width: hoverVariable.value ? 12 : 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5), color: buttonColor),
          duration: const Duration(milliseconds: 125),
          child: hoverVariable.value
              ? Center(child: Icon(iconData, size: 10, color: ColorConstants.black.withAlpha(200),))
              : const SizedBox(height: 8, width: 8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child:
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.glassWhite.withOpacity(0.1),
                  border: Border.all(color: ColorConstants.glassWhite, width: 1)              ),
              child: Column(
                children: [
                  // Top Common Widget
                  Container(
                    height: 12,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    child: Row(
                      children: [
                        _buildTopBarButton(
                            hoverVariable: viewModel.topBtnHovered,
                            onTap: () => viewModel.closeTab(3),
                            buttonColor: ColorConstants.crossRed,
                            iconData: Icons.close,
                            isCloseButton: true
                        ),
                        // const SizedBox(width: 2,),
                        _buildTopBarButton(
                            hoverVariable: viewModel.topBtnHovered,
                            onTap: () => viewModel.minimizeTab(3),
                            buttonColor: ColorConstants.minimizeYellow,
                            iconData: Icons.remove,
                            isCloseButton: false
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
