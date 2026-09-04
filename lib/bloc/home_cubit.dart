import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/bloc/education_cubit.dart';
import 'package:portfolio/bloc/experience_cubit.dart';
import 'package:portfolio/bloc/overview_cubit.dart';
import 'package:portfolio/bloc/projects_cubit.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/ui/tabs/education.dart';
import 'package:portfolio/ui/tabs/experience.dart';
import 'package:portfolio/ui/tabs/overview.dart';
import 'package:portfolio/ui/tabs/projects.dart';
import 'package:url_launcher/url_launcher.dart';

/// App-level state shared across the home page (tab stack, current tab, top
/// bar hover flags and the overview intro animation values).
class HomeState {
  final int currentTab;
  final List<bool> allTabsStackStatus;
  final List<bool> backgroundTabsStackStatus;
  final String currentTime;

  final Animation<double>? overviewScaleAnimation;
  final Animation<double>? overviewOpacityAnimation;

  final bool isOptionsGithubHovered;
  final bool isOptionsLinkedInHovered;
  final bool isOptionsEmailHovered;
  final bool isOptionsPhoneHovered;
  final bool isOptionsDownloadCVHovered;

  final bool isOverviewBtnHovered;
  final bool isExperienceBtnHovered;
  final bool isProjectsBtnHovered;
  final bool isEducationBtnHovered;

  const HomeState({
    this.currentTab = 100,
    this.allTabsStackStatus = const [false, false, false, false],
    this.backgroundTabsStackStatus = const [false, false, false, false],
    this.currentTime = '',
    this.overviewScaleAnimation,
    this.overviewOpacityAnimation,
    this.isOptionsGithubHovered = false,
    this.isOptionsLinkedInHovered = false,
    this.isOptionsEmailHovered = false,
    this.isOptionsPhoneHovered = false,
    this.isOptionsDownloadCVHovered = false,
    this.isOverviewBtnHovered = false,
    this.isExperienceBtnHovered = false,
    this.isProjectsBtnHovered = false,
    this.isEducationBtnHovered = false,
  });

  HomeState copyWith({
    int? currentTab,
    List<bool>? allTabsStackStatus,
    List<bool>? backgroundTabsStackStatus,
    String? currentTime,
    Animation<double>? overviewScaleAnimation,
    Animation<double>? overviewOpacityAnimation,
    bool? isOptionsGithubHovered,
    bool? isOptionsLinkedInHovered,
    bool? isOptionsEmailHovered,
    bool? isOptionsPhoneHovered,
    bool? isOptionsDownloadCVHovered,
    bool? isOverviewBtnHovered,
    bool? isExperienceBtnHovered,
    bool? isProjectsBtnHovered,
    bool? isEducationBtnHovered,
  }) {
    return HomeState(
      currentTab: currentTab ?? this.currentTab,
      allTabsStackStatus:
          allTabsStackStatus ?? List.from(this.allTabsStackStatus),
      backgroundTabsStackStatus: backgroundTabsStackStatus ??
          List.from(this.backgroundTabsStackStatus),
      currentTime: currentTime ?? this.currentTime,
      overviewScaleAnimation:
          overviewScaleAnimation ?? this.overviewScaleAnimation,
      overviewOpacityAnimation:
          overviewOpacityAnimation ?? this.overviewOpacityAnimation,
      isOptionsGithubHovered:
          isOptionsGithubHovered ?? this.isOptionsGithubHovered,
      isOptionsLinkedInHovered:
          isOptionsLinkedInHovered ?? this.isOptionsLinkedInHovered,
      isOptionsEmailHovered: isOptionsEmailHovered ?? this.isOptionsEmailHovered,
      isOptionsPhoneHovered: isOptionsPhoneHovered ?? this.isOptionsPhoneHovered,
      isOptionsDownloadCVHovered:
          isOptionsDownloadCVHovered ?? this.isOptionsDownloadCVHovered,
      isOverviewBtnHovered: isOverviewBtnHovered ?? this.isOverviewBtnHovered,
      isExperienceBtnHovered:
          isExperienceBtnHovered ?? this.isExperienceBtnHovered,
      isProjectsBtnHovered: isProjectsBtnHovered ?? this.isProjectsBtnHovered,
      isEducationBtnHovered: isEducationBtnHovered ?? this.isEducationBtnHovered,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required TickerProvider vsync,
    required OverviewCubit overviewCubit,
    required ExperienceCubit experienceCubit,
    required ProjectsCubit projectsCubit,
    required EducationCubit educationCubit,
    required double screenWidth,
  })  : _overviewCubit = overviewCubit,
        _experienceCubit = experienceCubit,
        _projectsCubit = projectsCubit,
        _educationCubit = educationCubit,
        _vsync = vsync,
        _screenWidth = screenWidth,
        super(const HomeState()) {
    initState();
  }

  final OverviewCubit _overviewCubit;
  final ExperienceCubit _experienceCubit;
  final ProjectsCubit _projectsCubit;
  final EducationCubit _educationCubit;
  final TickerProvider _vsync;
  final double _screenWidth;

  late TabController tabController;
  late List<Widget> allTabs;

  late AnimationController animationController;
  late Animation<Offset> upDownAnimation;
  late Animation<Offset> leftRightAnimation;

  late AnimationController overviewAnimationController;

  Timer? _timer;
  Future? _initialAction;

  // Separate notifiers so the tab widgets can rebuild against the state held
  // here [kept for parity with the original GetX tab-stack quick access].
  bool isTabInMemoryStack(int tabIndex) =>
      state.allTabsStackStatus[tabIndex];

  bool isTabInBackground(int tabIndex) =>
      state.backgroundTabsStackStatus[tabIndex];

  void initState() {
    allTabs = const <Widget>[
      OverviewTab(),
      ExperienceTab(),
      ProjectsTab(),
      EducationTab(),
    ];

    tabController = TabController(vsync: _vsync, length: allTabs.length);
    tabController.addListener(_onTabChanged);

    animationController = AnimationController(
      vsync: _vsync,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    upDownAnimation = Tween<Offset>(
      begin: const Offset(0, -5),
      end: const Offset(0, 5),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    leftRightAnimation = Tween<Offset>(
      begin: const Offset(-5, 0),
      end: const Offset(5, 0),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    overviewAnimationController = AnimationController(
      vsync: _vsync,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateCurrentTime());

    Future.delayed(const Duration(milliseconds: 1050), () {
      final scale = Tween<double>(begin: 0.88, end: 1.0).animate(
        CurvedAnimation(
            parent: overviewAnimationController, curve: Curves.easeInOut),
      );
      final opacity = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
            parent: overviewAnimationController, curve: Curves.easeInOut),
      );
      emit(state.copyWith(
        overviewScaleAnimation: scale,
        overviewOpacityAnimation: opacity,
        isOverviewBtnHovered: true,
      ));

      _initialAction = Future.delayed(
          Duration(milliseconds: _screenWidth < 850 ? 3400 : 350), () {
        if (overviewAnimationController.isAnimating) {
          overviewAnimationController.stop();
          emit(state.copyWith(
            overviewScaleAnimation: null,
            overviewOpacityAnimation: null,
            isOverviewBtnHovered: false,
          ));
          animateToOverviewTab();
        }
      });
    });
  }

  void _onTabChanged() {
    switch (tabController.index) {
      case 0:
        animateToOverviewTab();
        break;
      case 1:
        animateToExperienceTab();
        break;
      case 2:
        animateToProjectsTab();
        break;
      case 3:
        animateToBlog();
        break;
    }
  }

  void _updateCurrentTime() {
    emit(state.copyWith(
        currentTime: DateFormat('hh:mm a').format(DateTime.now())));
  }

  void animateToOverviewTab() {
    _overviewCubit.animateToTab(isFirstOpen: !state.allTabsStackStatus[0]);
    final stack = List<bool>.from(state.allTabsStackStatus);
    final bg = List<bool>.from(state.backgroundTabsStackStatus);
    stack[0] = true;
    if (state.currentTab < 4) {
      bg[state.currentTab] = true;
    }
    bg[0] = false;
    emit(state.copyWith(
      allTabsStackStatus: stack,
      backgroundTabsStackStatus: bg,
      currentTab: 0,
    ));
    if (tabController.index != 0) {
      tabController.animateTo(0);
    }
  }

  void animateToExperienceTab() {
    _experienceCubit.animateToTab(isFirstOpen: !state.allTabsStackStatus[1]);
    final stack = List<bool>.from(state.allTabsStackStatus);
    final bg = List<bool>.from(state.backgroundTabsStackStatus);
    stack[1] = true;
    if (state.currentTab < 4) {
      bg[state.currentTab] = true;
    }
    bg[1] = false;
    emit(state.copyWith(
      allTabsStackStatus: stack,
      backgroundTabsStackStatus: bg,
      currentTab: 1,
    ));
    tabController.animateTo(1);
  }

  void animateToProjectsTab() {
    _projectsCubit.animateToTab(isFirstOpen: !state.allTabsStackStatus[2]);
    final stack = List<bool>.from(state.allTabsStackStatus);
    final bg = List<bool>.from(state.backgroundTabsStackStatus);
    stack[2] = true;
    bg[2] = false;
    if (state.currentTab < 4) {
      bg[state.currentTab] = true;
    }
    emit(state.copyWith(
      allTabsStackStatus: stack,
      backgroundTabsStackStatus: bg,
      currentTab: 2,
    ));
    tabController.animateTo(2);
  }

  void animateToBlog() {
    launchUrl(Uri.parse("https://blog.santanumukherjee.com"));
  }

  void closeTab(int tabIndex) {
    final stack = List<bool>.from(state.allTabsStackStatus);
    final bg = List<bool>.from(state.backgroundTabsStackStatus);
    stack[tabIndex] = false;
    bg[tabIndex] = false;
    emit(state.copyWith(
      allTabsStackStatus: stack,
      backgroundTabsStackStatus: bg,
      currentTab: 100,
    ));
  }

  void minimizeTab(int tabIndex) {
    final stack = List<bool>.from(state.allTabsStackStatus);
    final bg = List<bool>.from(state.backgroundTabsStackStatus);
    stack[tabIndex] = true;
    bg[tabIndex] = true;
    emit(state.copyWith(
      allTabsStackStatus: stack,
      backgroundTabsStackStatus: bg,
      currentTab: 100,
    ));
  }

  void setOptionsHovered(String key, bool value) {
    switch (key) {
      case 'github':
        emit(state.copyWith(isOptionsGithubHovered: value));
        break;
      case 'linkedin':
        emit(state.copyWith(isOptionsLinkedInHovered: value));
        break;
      case 'email':
        emit(state.copyWith(isOptionsEmailHovered: value));
        break;
      case 'phone':
        emit(state.copyWith(isOptionsPhoneHovered: value));
        break;
      case 'cv':
        emit(state.copyWith(isOptionsDownloadCVHovered: value));
        break;
    }
  }

  void setMainTabHovered(int index, bool value) {
    switch (index) {
      case 0:
        emit(state.copyWith(isOverviewBtnHovered: value));
        break;
      case 1:
        emit(state.copyWith(isExperienceBtnHovered: value));
        break;
      case 2:
        emit(state.copyWith(isProjectsBtnHovered: value));
        break;
      case 3:
        emit(state.copyWith(isEducationBtnHovered: value));
        break;
    }
  }

  void stopIntroAnimation() {
    overviewAnimationController.stop();
    emit(state.copyWith(
      overviewScaleAnimation: null,
      overviewOpacityAnimation: null,
      isOverviewBtnHovered: false,
    ));
  }

  List<Color> getBgGradient(int index) {
    switch (index) {
      case 0:
        return [
          ColorConstants.cyanBlue.withAlpha(80),
          ColorConstants.deepTextBlue.withAlpha(60),
        ];
      case 1:
        return [
          ColorConstants.indicatorHighlight.withAlpha(100),
          ColorConstants.grassGreen.withAlpha(10),
          ColorConstants.deepTextBlue.withAlpha(40),
        ];
      case 2:
        return [
          ColorConstants.indicatorHighlight.withAlpha(100),
          ColorConstants.lightYellow.withAlpha(10),
          ColorConstants.deepTextBlue.withAlpha(40),
        ];
      case 3:
        return [
          ColorConstants.deepBlue.withAlpha(60),
          ColorConstants.black.withAlpha(40),
          ColorConstants.deepTextBlue.withAlpha(20),
        ];
      default:
        return [
          ColorConstants.deepTextBlue.withAlpha(100),
          ColorConstants.deepTextBlue.withAlpha(20),
        ];
    }
  }

  @override
  Future<void> close() {
    tabController.dispose();
    animationController.dispose();
    overviewAnimationController.dispose();
    _timer?.cancel();
    _initialAction?.ignore();
    return super.close();
  }
}
