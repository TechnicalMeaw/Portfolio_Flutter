import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/education_cubit.dart';
import 'package:portfolio/bloc/experience_cubit.dart';
import 'package:portfolio/bloc/home_cubit.dart';
import 'package:portfolio/bloc/overview_cubit.dart';
import 'package:portfolio/bloc/projects_cubit.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late final OverviewCubit _overviewCubit;
  late final ExperienceCubit _experienceCubit;
  late final ProjectsCubit _projectsCubit;
  late final EducationCubit _educationCubit;
  late HomeCubit _homeCubit;
  bool _isHomeCubitInitialized = false;

  @override
  void initState() {
    super.initState();
    _overviewCubit = OverviewCubit();
    _experienceCubit = ExperienceCubit();
    _projectsCubit = ProjectsCubit();
    _educationCubit = EducationCubit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isHomeCubitInitialized) {
      _isHomeCubitInitialized = true;
      final width = MediaQuery.of(context).size.width;
      _homeCubit = HomeCubit(
        vsync: this,
        overviewCubit: _overviewCubit,
        experienceCubit: _experienceCubit,
        projectsCubit: _projectsCubit,
        educationCubit: _educationCubit,
        screenWidth: width,
      );
    }
  }

  @override
  void dispose() {
    _homeCubit.close();
    _overviewCubit.close();
    _experienceCubit.close();
    _projectsCubit.close();
    _educationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: _homeCubit),
        BlocProvider<OverviewCubit>.value(value: _overviewCubit),
        BlocProvider<ExperienceCubit>.value(value: _experienceCubit),
        BlocProvider<ProjectsCubit>.value(value: _projectsCubit),
        BlocProvider<EducationCubit>.value(value: _educationCubit),
      ],
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => _HomePageView(cubit: _homeCubit),
        ),
      ),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            AssetConstants.imgBackgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: state.currentTab != 100 ? 0.05 : 0.2,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                AssetConstants.imgInitialBackgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => AnimatedContainer(
            duration: Duration(
                milliseconds: state.currentTab == 100 ? 800 : 1000),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: (MediaQuery.of(context).size.width *
                                (MediaQuery.of(context).size.width < 650
                                    ? 2
                                    : 1) +
                            MediaQuery.of(context).size.height) /
                        2 *
                        0.00115,
                colors: cubit.getBgGradient(state.currentTab),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcome to my portfolio!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.glassWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text("Consider using desktop for better experience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.glassWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text(
                    "This is a simulation of Linux based Operating System, feel free to explore!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.glassWhite, fontSize: 12)),
                SizedBox(height: 10),
                Text("Created with 💗 by Santanu.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.glassWhite, fontSize: 12)),
              ],
            ),
          ),
        ),
        _topStatusBarWidget(context),
        Align(
            alignment: Alignment.topCenter,
            child: _mainWidget(context)),
        _bottomMainTabs(context),
      ],
    );
  }

  Widget _topStatusBarWidget(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        ColorConstants.black.withAlpha(140),
                        ColorConstants.transparent,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 1.2),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: ColorConstants.darkBlack),
              child: LayoutBuilder(
                builder: (context, constrains) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    constrains.maxWidth > 500
                        ? Row(children: [
                            const SizedBox(width: 5),
                            _topOptionInkWell(
                              context,
                              label: "GitHub",
                              hovered: (s) => s.isOptionsGithubHovered,
                              onHover: (v) =>
                                  cubit.setOptionsHovered('github', v),
                              onTap: () async {
                                final Uri url =
                                    Uri.parse('https://github.com/TechnicalMeaw');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "|",
                              style: TextStyle(
                                  color: ColorConstants.glassBlack,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            _topOptionInkWell(
                              context,
                              label: "LinkedIn",
                              hovered: (s) => s.isOptionsLinkedInHovered,
                              onHover: (v) =>
                                  cubit.setOptionsHovered('linkedin', v),
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://www.linkedin.com/in/mukherjee-santanu/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "|",
                              style: TextStyle(
                                  color: ColorConstants.glassBlack,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            _topOptionInkWell(
                              context,
                              label: "Email",
                              hovered: (s) => s.isOptionsEmailHovered,
                              onHover: (v) =>
                                  cubit.setOptionsHovered('email', v),
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'mailto:hello@santanumukherjee.com');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "|",
                              style: TextStyle(
                                  color: ColorConstants.glassBlack,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            _topOptionInkWell(
                              context,
                              label: "Phone",
                              hovered: (s) => s.isOptionsPhoneHovered,
                              onHover: (v) =>
                                  cubit.setOptionsHovered('phone', v),
                              onTap: () async {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Phone number copied.',
                                      style: TextStyle(
                                          color: ColorConstants.darkGray,
                                          fontWeight: FontWeight.w400)),
                                  backgroundColor: ColorConstants.glassBlue,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                final Uri url =
                                    Uri.parse('tel://+918240251373');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "|",
                              style: TextStyle(
                                  color: ColorConstants.glassBlack,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            _topOptionInkWell(
                              context,
                              label: "View Resume",
                              hovered: (s) => s.isOptionsDownloadCVHovered,
                              onHover: (v) =>
                                  cubit.setOptionsHovered('cv', v),
                              onTap: () async {
                                await Utils.openResumePopup(context);
                              },
                            ),
                          ])
                        : _topOptionInkWell(
                            context,
                            label: "Learn More",
                            hovered: (s) => s.isOptionsDownloadCVHovered,
                            onHover: (v) => cubit.setOptionsHovered('cv', v),
                            onTap: () async {
                              await Utils.openResumePopup(context);
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0)),
                    Row(
                      children: [
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) => Text(state.currentTime,
                              style: const TextStyle(
                                  color: ColorConstants.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _topOptionInkWell(
    BuildContext context, {
    required String label,
    required bool Function(HomeState) hovered,
    required ValueChanged<bool> onHover,
    required VoidCallback onTap,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isHovered = hovered(state);
        return InkWell(
          onHover: onHover,
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Text(
              label,
              style: TextStyle(
                  color:
                      isHovered ? ColorConstants.white : ColorConstants.glassWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomMainTabs(BuildContext context) {
    return Align(
      alignment: MediaQuery.of(context).size.width < 700
          ? Alignment.bottomCenter
          : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width < 700 ? 0 : 5.0,
            bottom: MediaQuery.of(context).size.width < 700 ? 5 : 0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.glassWhite),
                      gradient: LinearGradient(
                          colors: [
                            ColorConstants.deepTeal.withAlpha(40),
                            ColorConstants.darkTextBlue.withAlpha(16),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(24)),
                  child: MediaQuery.of(context).size.width < 700
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: menuItems(context),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: menuItems(context),
                        ),
                ))),
      ),
    );
  }

  List<Widget> menuItems(BuildContext context) => [
        _mainTabWidget(
          context,
          logo: AssetConstants.icOverview,
          toolTipText: "Overview",
          index: 0,
          onClick: () {
            cubit.animateToOverviewTab();
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
          width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
        ),
        _mainTabWidget(
          context,
          logo: AssetConstants.icExperience,
          toolTipText: "Experience",
          index: 1,
          onClick: () {
            cubit.stopIntroAnimation();
            cubit.animateToExperienceTab();
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
          width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
        ),
        _mainTabWidget(
          context,
          logo: AssetConstants.icProjects,
          toolTipText: "Projects",
          index: 2,
          onClick: () {
            cubit.stopIntroAnimation();
            cubit.animateToProjectsTab();
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width < 700 ? 0 : 5,
          width: MediaQuery.of(context).size.width < 700 ? 5 : 0,
        ),
        _mainTabWidget(
          context,
          logo: AssetConstants.icEducation,
          toolTipText: "Blog",
          index: 3,
          onClick: () {
            cubit.stopIntroAnimation();
            cubit.animateToBlog();
          },
        ),
      ];

  Widget _mainTabWidget(
    BuildContext context, {
    required String toolTipText,
    required String logo,
    required int index,
    Function()? onClick,
  }) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isHovered;
        switch (index) {
          case 0:
            isHovered = state.isOverviewBtnHovered;
            break;
          case 1:
            isHovered = state.isExperienceBtnHovered;
            break;
          case 2:
            isHovered = state.isProjectsBtnHovered;
            break;
          default:
            isHovered = state.isEducationBtnHovered;
        }
        final isInMemoryStack = state.allTabsStackStatus[index];
        final currentTab = state.currentTab;
        final scaleAnimation = state.overviewScaleAnimation;
        final opacityAnimation = state.overviewOpacityAnimation;
        return FadeTransition(
          opacity: opacityAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: ScaleTransition(
            scale: scaleAnimation ?? const AlwaysStoppedAnimation(1.0),
            child: InkWell(
              onTap: () {
                if (onClick != null) {
                  cubit.stopIntroAnimation();
                  onClick();
                }
              },
              onHover: (hovered) {
                cubit.setMainTabHovered(index, hovered);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeIn,
                height: isHovered ? 62 : 56,
                width: isHovered ? 59 : 55,
                padding: const EdgeInsets.all(2),
                margin: isHovered
                    ? const EdgeInsets.symmetric(horizontal: 4.5)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isHovered
                      ? ColorConstants.glassBlack
                      : ColorConstants.glassBlack.withAlpha(50),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: ColorConstants.glassWhite.withOpacity(0.2),
                      width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, left: 6.0, right: 6.0, bottom: 1.0),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.cover,
                        height: isHovered ? 24 : null,
                      ),
                    ),
                    isHovered
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              toolTipText,
                              style: TextStyle(
                                  fontSize: 9.5,
                                  color: ColorConstants.white.withAlpha(230),
                                  fontWeight: FontWeight.w200),
                            ),
                          )
                        : Offstage(),
                    isInMemoryStack
                        ? Container(
                            height: 3,
                            width: currentTab == index ? 11 : 5.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: ColorConstants.glassWhite,
                            ),
                          )
                        : const SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _mainWidget(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width < 700 ? 81.5 : 2,
            top: 26,
            left: MediaQuery.of(context).size.width < 700 ? 2 : 82,
            right: 2),
        child: state.currentTab > 3
            ? const Offstage()
            : TabBarView(
                controller: cubit.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: cubit.allTabs,
              ),
      ),
    );
  }
}
