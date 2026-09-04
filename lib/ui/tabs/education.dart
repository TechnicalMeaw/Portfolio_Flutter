import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/education_cubit.dart';
import 'package:portfolio/bloc/home_cubit.dart';
import 'package:portfolio/resources/color_constants.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  Widget _buildTopBarButton({
    required bool isHovered,
    required VoidCallback onTap,
    required ValueChanged<bool> onHover,
    required Color buttonColor,
    required IconData iconData,
    required bool isCloseButton,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        onHover(false);
      },
      onHover: onHover,
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
                child: Icon(
                iconData,
                size: 10,
                color: ColorConstants.black.withAlpha(200),
              ))
            : const SizedBox(height: 8, width: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EducationCubit>();
    final homeCubit = context.read<HomeCubit>();

    return BlocBuilder<EducationCubit, EducationState>(
      builder: (context, state) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorConstants.glassWhite.withOpacity(0.04),
                      border: Border.all(
                          color: ColorConstants.glassWhite, width: 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 12,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Row(
                          children: [
                            _buildTopBarButton(
                                isHovered: state.topBtnHovered,
                                onTap: () => homeCubit.closeTab(3),
                                onHover: cubit.setTopBtnHovered,
                                buttonColor: ColorConstants.crossRed,
                                iconData: Icons.close,
                                isCloseButton: true),
                            _buildTopBarButton(
                                isHovered: state.topBtnHovered,
                                onTap: () => homeCubit.minimizeTab(3),
                                onHover: cubit.setTopBtnHovered,
                                buttonColor: ColorConstants.minimizeYellow,
                                iconData: Icons.remove,
                                isCloseButton: false),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  ColorConstants.glassBlack.withOpacity(0.1),
                              border: Border.all(
                                  color: ColorConstants.glassWhite
                                      .withOpacity(0.2),
                                  width: 1)),
                          child: const Center(
                            child: Text(
                              "Coming Soon",
                              style: TextStyle(
                                  color: ColorConstants.glassWhite),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}
