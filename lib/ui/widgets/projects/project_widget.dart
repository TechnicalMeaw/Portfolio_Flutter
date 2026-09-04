import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/projects_cubit.dart';
import 'package:portfolio/resources/color_constants.dart';

enum ProjectStyle { violet, blue }
enum ProjectAlignment { leftThumb, rightThumb }

class ProjectData {
  final String title;
  final String subtitle;
  final String year;
  final String imageAsset;
  final String? imageUrl;
  final List<String> bulletPoints;
  final String actionUrl;
  final String actionText;

  ProjectData({
    required this.title,
    required this.subtitle,
    required this.year,
    required this.imageAsset,
    this.imageUrl,
    required this.bulletPoints,
    required this.actionUrl,
    required this.actionText,
  });
}

class ProjectWidget extends StatelessWidget {
  final int projectIndex;
  final ProjectData projectData;
  final ProjectStyle style;
  final ProjectAlignment projectAlignment;

  const ProjectWidget({
    super.key,
    required this.projectIndex,
    required this.projectData,
    required this.style,
    required this.projectAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final isVisible = _getVisibility(state);
        final imageVisible = _getImageVisibility(state);
        final descVisible = _getDescVisibility(state);
        final buttonHovered = _getButtonHovered(state);

        return AnimatedOpacity(
          opacity: isVisible ? 1 : 0,
          duration: const Duration(milliseconds: 800),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: _getContainerDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth > 800
                            ? _buildDesktopLayout()
                            : _buildMobileLayout(constraints);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _getVisibility(ProjectsState state) {
    switch (projectIndex) {
      case 1: return state.isProject1Visible;
      case 2: return state.isProject2Visible;
      case 3: return state.isProject3Visible;
      case 4: return state.isProject4Visible;
      case 5: return state.isProject5Visible;
      default: return false;
    }
  }

  bool _getImageVisibility(ProjectsState state) {
    switch (projectIndex) {
      case 1: return state.isProject1ImageVisible;
      case 2: return state.isProject2ImageVisible;
      case 3: return state.isProject3ImageVisible;
      case 4: return state.isProject4ImageVisible;
      case 5: return state.isProject5ImageVisible;
      default: return false;
    }
  }

  bool _getDescVisibility(ProjectsState state) {
    switch (projectIndex) {
      case 1: return state.isProject1DescVisible;
      case 2: return state.isProject2DescVisible;
      case 3: return state.isProject3DescVisible;
      case 4: return state.isProject4DescVisible;
      case 5: return state.isProject5DescVisible;
      default: return false;
    }
  }

  bool _getButtonHovered(ProjectsState state) {
    switch (projectIndex) {
      case 1: return state.isProject1KnowMoreBtnHovered;
      case 2: return state.isProject2KnowMoreBtnHovered;
      case 3: return state.isProject3KnowMoreBtnHovered;
      case 4: return state.isProject4KnowMoreBtnHovered;
      case 5: return state.isProject5KnowMoreBtnHovered;
      default: return false;
    }
  }

  Widget _buildDesktopLayout() {
    if (projectAlignment == ProjectAlignment.leftThumb) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProjectImage(const BoxConstraints(maxWidth: 420)),
          const SizedBox(width: 32),
          Expanded(child: _buildProjectDescription(isMobile: false)),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildProjectDescription(isMobile: false)),
          const SizedBox(width: 32),
          _buildProjectImage(const BoxConstraints(maxWidth: 420)),
        ],
      );
    }
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Column(
      children: [
        _buildProjectImage(constraints),
        const SizedBox(height: 32),
        _buildProjectDescription(isMobile: true),
      ],
    );
  }

  BoxDecoration _getContainerDecoration() {
    final baseDecoration = BoxDecoration(
      border: Border.all(
        color: ColorConstants.glassWhite.withOpacity(0.6),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(32),
    );

    if (style == ProjectStyle.violet) {
      return baseDecoration.copyWith(
          gradient: LinearGradient(
            colors: [
              ColorConstants.textBlue.withOpacity(0.15),
              ColorConstants.indicatorHighlight.withOpacity(0.05),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          image: projectData.imageUrl != null
            ? DecorationImage(
          image: NetworkImage(projectData.imageUrl!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            ColorConstants.black.withOpacity(style == ProjectStyle.violet ? 0.07 : 0.04),
            BlendMode.dstATop,
          ),
        )
            : null,
      );
    } else {
      return baseDecoration.copyWith(
        color: ColorConstants.darkGray,
        gradient: LinearGradient(
          colors: [
            ColorConstants.textBlue.withOpacity(0.1),
            ColorConstants.deepTextBlue.withOpacity(0.06),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        image: projectData.imageUrl != null
            ? DecorationImage(
          image: NetworkImage(projectData.imageUrl!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            ColorConstants.black.withOpacity(0.249),
            BlendMode.dstATop,
          ),
        )
            : null,
      );
    }
  }

  Widget _buildProjectImage(BoxConstraints constraints) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 700),
          opacity: _getImageVisibility(state) ? 1 : 0,
          child: Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(projectData.imageAsset),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectDescription({bool isMobile = false}) {
    final isRightAligned = false;

    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: _getDescVisibility(state) ? 1 : 0,
          duration: const Duration(milliseconds: 800),
          child: Container(
            decoration: _getDescriptionDecoration(),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: isRightAligned
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                _buildProjectHeader(isRightAligned),
                const SizedBox(height: 24),
                _buildBulletPoints(isRightAligned, isMobile),
                const SizedBox(height: 32),
                _buildActionButton(context, isMobile)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectHeader(bool isRightAligned) {
    return Column(
      crossAxisAlignment: isRightAligned
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          projectData.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorConstants.white.withAlpha(236),
            shadows: [
              Shadow(
                offset: const Offset(0.0, 2.0),
                blurRadius: 10,
                color: ColorConstants.black.withAlpha(50),
              ),
            ]
          ),
          textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 4),
        Text(
          projectData.subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorConstants.white.withAlpha(236),
            shadows: [
              Shadow(
                offset: const Offset(0.0, 2.0),
                blurRadius: 10,
                color: ColorConstants.black.withAlpha(50),
              ),
            ]
          ),
          textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 2),
        Text(
          projectData.year,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorConstants.cyanBlue.withAlpha(236),
            shadows: [
              Shadow(
                offset: const Offset(0.0, 2.0),
                blurRadius: 10,
                color: ColorConstants.black.withAlpha(50),
              ),
            ]
          ),
          textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildBulletPoints(bool isRightAligned, bool isMobile) {
    return Column(
      children: projectData.bulletPoints
          .map((point) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _buildBulletPoint(point, isRightAligned),
      ))
          .toList(),
    );
  }

  BoxDecoration _getDescriptionDecoration() {
    return BoxDecoration(
      color: ColorConstants.glassWhite.withOpacity(0.56),
      borderRadius: BorderRadius.circular(32),
      border: Border.all(
        color: ColorConstants.glassWhite.withOpacity(0.2),
        width: 1,
      ),
      gradient: LinearGradient(
        colors: [
          style == ProjectStyle.violet
              ? ColorConstants.darkTextBlue.withOpacity(0.14)
              : ColorConstants.black.withOpacity(0.09),
          style == ProjectStyle.violet
              ? ColorConstants.black.withOpacity(0.16)
              : ColorConstants.deepTextBlue.withOpacity(0.14),
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: const [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
    );
  }

  Widget _buildBulletPoint(String title, bool isRightAligned) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: isRightAligned ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1.5, color: ColorConstants.glassWhite),
            color: ColorConstants.white,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.white.withAlpha(236),
                shadows: [
                  Shadow(
                    offset: const Offset(0.0, 2.0),
                    blurRadius: 10,
                    color: ColorConstants.black.withAlpha(80),
                  ),
                ]
            ),
            textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, bool isMobile) {
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.centerLeft,
      child: InkWell(
        onTap: () async {
          final Uri url = Uri.parse(projectData.actionUrl);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        },
        onHover: (isHovered) =>
            context.read<ProjectsCubit>().setProjectKnowMoreHovered(projectIndex, isHovered),
        child: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            final isHovered = _getButtonHovered(state);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: isHovered
                    ? ColorConstants.white.withOpacity(0.8)
                    : ColorConstants.black.withOpacity(0.9),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  width: 1,
                  color: isHovered
                      ? ColorConstants.black
                      : ColorConstants.white,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.glassBlue.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: isMobile ? Container(
                constraints: const BoxConstraints(maxWidth: 220),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      projectData.actionText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isHovered
                            ? ColorConstants.black
                            : ColorConstants.white.withAlpha(236),
                      ),
                    ),
                  ],
                ),
              ) : Text(
                projectData.actionText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isHovered
                      ? ColorConstants.black
                      : ColorConstants.white.withAlpha(236),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
