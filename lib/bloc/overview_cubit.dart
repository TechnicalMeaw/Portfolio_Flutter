import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Skill/KPI keys used for the increase animation updates.
enum SkillKey {
  android,
  flutter,
  django,
  fastApi,
  problemSolving,
  firebase,
  python,
  dsa,
  aws,
  kotlin,
  dart,
  java,
  git,
}

class OverviewState {
  final double scrollProgress;
  final bool topBtnHovered;
  final bool isAnimationCompleted;

  final int androidSkillRating;
  final int flutterSkillRating;
  final int djangoSkillRating;
  final int fastApiSkillRating;
  final int problemSolvingSkillRating;
  final int firebaseSkillRating;
  final int pythonSkillRating;
  final int dsaSkillRating;
  final int awsSkillRating;
  final int kotlinSkillRating;
  final int dartSkillRating;
  final int javaSkillRating;
  final int gitSkillRating;

  final int bannerWidth;
  final double bannerHeight;
  final bool isProfileBannerOpened;
  final bool isProfileBannerTitleVisible;
  final bool isSummaryVisible;
  final bool isHireMeVisible;

  final bool isKPI1Visible;
  final bool isKPI2Visible;
  final bool isKPI3Visible;
  final bool isKPI4Visible;
  final bool isKPI5Visible;

  final int kpi1Value;
  final int kpi2Value;
  final int kpi3Value;
  final int kpi4Value;
  final int kpi5Value;

  final bool kpi1KnowMoreHovered;
  final bool kpi2KnowMoreHovered;
  final bool kpi3KnowMoreHovered;
  final bool kpi4KnowMoreHovered;
  final bool kpi5KnowMoreHovered;

  final bool educationViewAllHovered;
  final bool skillsViewAllHovered;
  final bool projectsViewAllHovered;

  final bool link1Hovered;
  final bool link2Hovered;
  final bool link3Hovered;
  final bool link4Hovered;
  final bool link5Hovered;

  final bool isSkillsVisible;

  final bool isLinkedInIconHovered;
  final bool isGitHubIconHovered;
  final bool isEmailIconHovered;
  final bool isPhoneIconHovered;

  final bool isDownloadCvBtnHovered;
  final bool isViewProjectsBtnHovered;

  final bool isEducationOverviewVisible;
  final bool isProjectsOverviewVisible;

  const OverviewState({
    this.scrollProgress = 0.0,
    this.topBtnHovered = false,
    this.isAnimationCompleted = true,
    this.androidSkillRating = 0,
    this.flutterSkillRating = 0,
    this.djangoSkillRating = 0,
    this.fastApiSkillRating = 0,
    this.problemSolvingSkillRating = 0,
    this.firebaseSkillRating = 0,
    this.pythonSkillRating = 0,
    this.dsaSkillRating = 0,
    this.awsSkillRating = 0,
    this.kotlinSkillRating = 0,
    this.dartSkillRating = 0,
    this.javaSkillRating = 0,
    this.gitSkillRating = 0,
    this.bannerWidth = 0,
    this.bannerHeight = 0.05,
    this.isProfileBannerOpened = false,
    this.isProfileBannerTitleVisible = false,
    this.isSummaryVisible = false,
    this.isHireMeVisible = false,
    this.isKPI1Visible = false,
    this.isKPI2Visible = false,
    this.isKPI3Visible = false,
    this.isKPI4Visible = false,
    this.isKPI5Visible = false,
    this.kpi1Value = 0,
    this.kpi2Value = 0,
    this.kpi3Value = 0,
    this.kpi4Value = 0,
    this.kpi5Value = 0,
    this.kpi1KnowMoreHovered = false,
    this.kpi2KnowMoreHovered = false,
    this.kpi3KnowMoreHovered = false,
    this.kpi4KnowMoreHovered = false,
    this.kpi5KnowMoreHovered = false,
    this.educationViewAllHovered = false,
    this.skillsViewAllHovered = false,
    this.projectsViewAllHovered = false,
    this.link1Hovered = false,
    this.link2Hovered = false,
    this.link3Hovered = false,
    this.link4Hovered = false,
    this.link5Hovered = false,
    this.isSkillsVisible = false,
    this.isLinkedInIconHovered = false,
    this.isGitHubIconHovered = false,
    this.isEmailIconHovered = false,
    this.isPhoneIconHovered = false,
    this.isDownloadCvBtnHovered = false,
    this.isViewProjectsBtnHovered = false,
    this.isEducationOverviewVisible = false,
    this.isProjectsOverviewVisible = false,
  });

  OverviewState copyWith({
    double? scrollProgress,
    bool? topBtnHovered,
    bool? isAnimationCompleted,
    int? androidSkillRating,
    int? flutterSkillRating,
    int? djangoSkillRating,
    int? fastApiSkillRating,
    int? problemSolvingSkillRating,
    int? firebaseSkillRating,
    int? pythonSkillRating,
    int? dsaSkillRating,
    int? awsSkillRating,
    int? kotlinSkillRating,
    int? dartSkillRating,
    int? javaSkillRating,
    int? gitSkillRating,
    int? bannerWidth,
    double? bannerHeight,
    bool? isProfileBannerOpened,
    bool? isProfileBannerTitleVisible,
    bool? isSummaryVisible,
    bool? isHireMeVisible,
    bool? isKPI1Visible,
    bool? isKPI2Visible,
    bool? isKPI3Visible,
    bool? isKPI4Visible,
    bool? isKPI5Visible,
    int? kpi1Value,
    int? kpi2Value,
    int? kpi3Value,
    int? kpi4Value,
    int? kpi5Value,
    bool? kpi1KnowMoreHovered,
    bool? kpi2KnowMoreHovered,
    bool? kpi3KnowMoreHovered,
    bool? kpi4KnowMoreHovered,
    bool? kpi5KnowMoreHovered,
    bool? educationViewAllHovered,
    bool? skillsViewAllHovered,
    bool? projectsViewAllHovered,
    bool? link1Hovered,
    bool? link2Hovered,
    bool? link3Hovered,
    bool? link4Hovered,
    bool? link5Hovered,
    bool? isSkillsVisible,
    bool? isLinkedInIconHovered,
    bool? isGitHubIconHovered,
    bool? isEmailIconHovered,
    bool? isPhoneIconHovered,
    bool? isDownloadCvBtnHovered,
    bool? isViewProjectsBtnHovered,
    bool? isEducationOverviewVisible,
    bool? isProjectsOverviewVisible,
  }) {
    return OverviewState(
      scrollProgress: scrollProgress ?? this.scrollProgress,
      topBtnHovered: topBtnHovered ?? this.topBtnHovered,
      isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
      androidSkillRating: androidSkillRating ?? this.androidSkillRating,
      flutterSkillRating: flutterSkillRating ?? this.flutterSkillRating,
      djangoSkillRating: djangoSkillRating ?? this.djangoSkillRating,
      fastApiSkillRating: fastApiSkillRating ?? this.fastApiSkillRating,
      problemSolvingSkillRating:
          problemSolvingSkillRating ?? this.problemSolvingSkillRating,
      firebaseSkillRating: firebaseSkillRating ?? this.firebaseSkillRating,
      pythonSkillRating: pythonSkillRating ?? this.pythonSkillRating,
      dsaSkillRating: dsaSkillRating ?? this.dsaSkillRating,
      awsSkillRating: awsSkillRating ?? this.awsSkillRating,
      kotlinSkillRating: kotlinSkillRating ?? this.kotlinSkillRating,
      dartSkillRating: dartSkillRating ?? this.dartSkillRating,
      javaSkillRating: javaSkillRating ?? this.javaSkillRating,
      gitSkillRating: gitSkillRating ?? this.gitSkillRating,
      bannerWidth: bannerWidth ?? this.bannerWidth,
      bannerHeight: bannerHeight ?? this.bannerHeight,
      isProfileBannerOpened:
          isProfileBannerOpened ?? this.isProfileBannerOpened,
      isProfileBannerTitleVisible:
          isProfileBannerTitleVisible ?? this.isProfileBannerTitleVisible,
      isSummaryVisible: isSummaryVisible ?? this.isSummaryVisible,
      isHireMeVisible: isHireMeVisible ?? this.isHireMeVisible,
      isKPI1Visible: isKPI1Visible ?? this.isKPI1Visible,
      isKPI2Visible: isKPI2Visible ?? this.isKPI2Visible,
      isKPI3Visible: isKPI3Visible ?? this.isKPI3Visible,
      isKPI4Visible: isKPI4Visible ?? this.isKPI4Visible,
      isKPI5Visible: isKPI5Visible ?? this.isKPI5Visible,
      kpi1Value: kpi1Value ?? this.kpi1Value,
      kpi2Value: kpi2Value ?? this.kpi2Value,
      kpi3Value: kpi3Value ?? this.kpi3Value,
      kpi4Value: kpi4Value ?? this.kpi4Value,
      kpi5Value: kpi5Value ?? this.kpi5Value,
      kpi1KnowMoreHovered: kpi1KnowMoreHovered ?? this.kpi1KnowMoreHovered,
      kpi2KnowMoreHovered: kpi2KnowMoreHovered ?? this.kpi2KnowMoreHovered,
      kpi3KnowMoreHovered: kpi3KnowMoreHovered ?? this.kpi3KnowMoreHovered,
      kpi4KnowMoreHovered: kpi4KnowMoreHovered ?? this.kpi4KnowMoreHovered,
      kpi5KnowMoreHovered: kpi5KnowMoreHovered ?? this.kpi5KnowMoreHovered,
      educationViewAllHovered:
          educationViewAllHovered ?? this.educationViewAllHovered,
      skillsViewAllHovered: skillsViewAllHovered ?? this.skillsViewAllHovered,
      projectsViewAllHovered:
          projectsViewAllHovered ?? this.projectsViewAllHovered,
      link1Hovered: link1Hovered ?? this.link1Hovered,
      link2Hovered: link2Hovered ?? this.link2Hovered,
      link3Hovered: link3Hovered ?? this.link3Hovered,
      link4Hovered: link4Hovered ?? this.link4Hovered,
      link5Hovered: link5Hovered ?? this.link5Hovered,
      isSkillsVisible: isSkillsVisible ?? this.isSkillsVisible,
      isLinkedInIconHovered:
          isLinkedInIconHovered ?? this.isLinkedInIconHovered,
      isGitHubIconHovered: isGitHubIconHovered ?? this.isGitHubIconHovered,
      isEmailIconHovered: isEmailIconHovered ?? this.isEmailIconHovered,
      isPhoneIconHovered: isPhoneIconHovered ?? this.isPhoneIconHovered,
      isDownloadCvBtnHovered:
          isDownloadCvBtnHovered ?? this.isDownloadCvBtnHovered,
      isViewProjectsBtnHovered:
          isViewProjectsBtnHovered ?? this.isViewProjectsBtnHovered,
      isEducationOverviewVisible:
          isEducationOverviewVisible ?? this.isEducationOverviewVisible,
      isProjectsOverviewVisible:
          isProjectsOverviewVisible ?? this.isProjectsOverviewVisible,
    );
  }
}

class OverviewCubit extends Cubit<OverviewState> {
  OverviewCubit() : super(const OverviewState()) {
    _init();
  }

  final ScrollController scrollController = ScrollController();
  final List<Timer> _timers = [];

  void _init() {
    scrollController.addListener(_updateScrollProgress);
  }

  void _updateScrollProgress() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    emit(state.copyWith(
        scrollProgress: (currentScroll / maxScroll).clamp(0.0, 1.0)));
  }

  void animateToTab({required bool isFirstOpen}) {
    if (isFirstOpen) {
      emit(state.copyWith(isAnimationCompleted: false));
      resetAnimations();
      startOverviewPageAnimations();
    }
    emit(state.copyWith(scrollProgress: 0));
  }

  void setTopBtnHovered(bool value) =>
      emit(state.copyWith(topBtnHovered: value));

  void setKpiKnowMoreHovered(int index, bool value) {
    switch (index) {
      case 1:
        emit(state.copyWith(kpi1KnowMoreHovered: value));
        break;
      case 2:
        emit(state.copyWith(kpi2KnowMoreHovered: value));
        break;
      case 3:
        emit(state.copyWith(kpi3KnowMoreHovered: value));
        break;
      case 4:
        emit(state.copyWith(kpi4KnowMoreHovered: value));
        break;
      case 5:
        emit(state.copyWith(kpi5KnowMoreHovered: value));
        break;
    }
  }

  void setViewAllHovered(String key, bool value) {
    switch (key) {
      case 'education':
        emit(state.copyWith(educationViewAllHovered: value));
        break;
      case 'skills':
        emit(state.copyWith(skillsViewAllHovered: value));
        break;
      case 'projects':
        emit(state.copyWith(projectsViewAllHovered: value));
        break;
    }
  }

  void setLinkHovered(int index, bool value) {
    switch (index) {
      case 1:
        emit(state.copyWith(link1Hovered: value));
        break;
      case 2:
        emit(state.copyWith(link2Hovered: value));
        break;
      case 3:
        emit(state.copyWith(link3Hovered: value));
        break;
      case 4:
        emit(state.copyWith(link4Hovered: value));
        break;
      case 5:
        emit(state.copyWith(link5Hovered: value));
        break;
    }
  }

  void setSocialIconHovered(String key, bool value) {
    switch (key) {
      case 'linkedin':
        emit(state.copyWith(isLinkedInIconHovered: value));
        break;
      case 'github':
        emit(state.copyWith(isGitHubIconHovered: value));
        break;
      case 'email':
        emit(state.copyWith(isEmailIconHovered: value));
        break;
      case 'phone':
        emit(state.copyWith(isPhoneIconHovered: value));
        break;
    }
  }

  void setDownloadCvHovered(bool value) =>
      emit(state.copyWith(isDownloadCvBtnHovered: value));

  void setViewProjectsHovered(bool value) =>
      emit(state.copyWith(isViewProjectsBtnHovered: value));

  int skillRating(SkillKey key) {
    switch (key) {
      case SkillKey.android:
        return state.androidSkillRating;
      case SkillKey.flutter:
        return state.flutterSkillRating;
      case SkillKey.django:
        return state.djangoSkillRating;
      case SkillKey.fastApi:
        return state.fastApiSkillRating;
      case SkillKey.problemSolving:
        return state.problemSolvingSkillRating;
      case SkillKey.firebase:
        return state.firebaseSkillRating;
      case SkillKey.python:
        return state.pythonSkillRating;
      case SkillKey.dsa:
        return state.dsaSkillRating;
      case SkillKey.aws:
        return state.awsSkillRating;
      case SkillKey.kotlin:
        return state.kotlinSkillRating;
      case SkillKey.dart:
        return state.dartSkillRating;
      case SkillKey.java:
        return state.javaSkillRating;
      case SkillKey.git:
        return state.gitSkillRating;
    }
  }

  void _setSkillRating(SkillKey key, int value) {
    switch (key) {
      case SkillKey.android:
        emit(state.copyWith(androidSkillRating: value));
        break;
      case SkillKey.flutter:
        emit(state.copyWith(flutterSkillRating: value));
        break;
      case SkillKey.django:
        emit(state.copyWith(djangoSkillRating: value));
        break;
      case SkillKey.fastApi:
        emit(state.copyWith(fastApiSkillRating: value));
        break;
      case SkillKey.problemSolving:
        emit(state.copyWith(problemSolvingSkillRating: value));
        break;
      case SkillKey.firebase:
        emit(state.copyWith(firebaseSkillRating: value));
        break;
      case SkillKey.python:
        emit(state.copyWith(pythonSkillRating: value));
        break;
      case SkillKey.dsa:
        emit(state.copyWith(dsaSkillRating: value));
        break;
      case SkillKey.aws:
        emit(state.copyWith(awsSkillRating: value));
        break;
      case SkillKey.kotlin:
        emit(state.copyWith(kotlinSkillRating: value));
        break;
      case SkillKey.dart:
        emit(state.copyWith(dartSkillRating: value));
        break;
      case SkillKey.java:
        emit(state.copyWith(javaSkillRating: value));
        break;
      case SkillKey.git:
        emit(state.copyWith(gitSkillRating: value));
        break;
    }
  }

  void startOverviewPageAnimations() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (isClosed) return;
        emit(state.copyWith(bannerWidth: 1));
      },
    );

    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        if (isClosed) return;
        emit(state.copyWith(bannerHeight: 1));
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1700),
      () {
        if (isClosed) return;
        emit(state.copyWith(isProfileBannerOpened: true));
      },
    );
    Future.delayed(
      const Duration(milliseconds: 2900),
      () {
        if (isClosed) return;
        emit(state.copyWith(isProfileBannerTitleVisible: true));
        Future.delayed(const Duration(milliseconds: 200), () {
          if (isClosed) return;
          emit(state.copyWith(isSummaryVisible: true));
        });
        Future.delayed(const Duration(milliseconds: 900), () {
          if (isClosed) return;
          emit(state.copyWith(isHireMeVisible: true));
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (isClosed) return;
          emit(state.copyWith(isKPI1Visible: true));
          startIncreasingAnimation(
            set: (v) => emit(state.copyWith(kpi1Value: v)),
            get: () => state.kpi1Value,
            maxSkillRating: 4,
            delay: 100,
            increaseDelay: 400,
            increaseValue: 1,
          );
        });
        Future.delayed(const Duration(milliseconds: 2400), () {
          if (isClosed) return;
          emit(state.copyWith(isKPI2Visible: true));
          startIncreasingAnimation(
            set: (v) => emit(state.copyWith(kpi2Value: v)),
            get: () => state.kpi2Value,
            maxSkillRating: 14,
            delay: 100,
            increaseDelay: 160,
            increaseValue: 1,
          );
        });
        Future.delayed(const Duration(milliseconds: 4400), () {
          if (isClosed) return;
          emit(state.copyWith(isKPI3Visible: true));
          startIncreasingAnimation(
            set: (v) => emit(state.copyWith(kpi3Value: v)),
            get: () => state.kpi3Value,
            maxSkillRating: 9,
            delay: 500,
            increaseDelay: 310,
            increaseValue: 1,
          );
        });
        Future.delayed(const Duration(milliseconds: 7200), () {
          if (isClosed) return;
          emit(state.copyWith(isKPI4Visible: true));
          startIncreasingAnimation(
            set: (v) => emit(state.copyWith(kpi4Value: v)),
            get: () => state.kpi4Value,
            maxSkillRating: 11,
            delay: 1800,
            increaseDelay: 280,
            increaseValue: 1,
          );
        });
        Future.delayed(const Duration(milliseconds: 10400), () {
          if (isClosed) return;
          emit(state.copyWith(isKPI5Visible: true));
          startIncreasingAnimation(
            set: (v) => emit(state.copyWith(kpi5Value: v)),
            get: () => state.kpi5Value,
            maxSkillRating: 532,
            delay: 2600,
            increaseDelay: 25,
            increaseValue: 4,
          );
        });
      },
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (isClosed) return;
      emit(state.copyWith(isSkillsVisible: true));
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.android, v),
          get: () => state.androidSkillRating,
          maxSkillRating: 91,
          delay: 750,
          increaseDelay: 35 ~/ 2);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.flutter, v),
          get: () => state.flutterSkillRating,
          maxSkillRating: 93,
          delay: 200,
          increaseDelay: 30 ~/ 2);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.django, v),
          get: () => state.djangoSkillRating,
          maxSkillRating: 74,
          delay: 300,
          increaseDelay: 45 ~/ 2);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.fastApi, v),
          get: () => state.fastApiSkillRating,
          maxSkillRating: 86,
          delay: 400,
          increaseDelay: 25 ~/ 2);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.problemSolving, v),
          get: () => state.problemSolvingSkillRating,
          maxSkillRating: 92,
          delay: 850,
          increaseDelay: 40 ~/ 6);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.firebase, v),
          get: () => state.firebaseSkillRating,
          maxSkillRating: 85,
          delay: 600,
          increaseDelay: 30 ~/ 6);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.python, v),
          get: () => state.pythonSkillRating,
          maxSkillRating: 90,
          delay: 700,
          increaseDelay: 25 ~/ 8);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.dsa, v),
          get: () => state.dsaSkillRating,
          maxSkillRating: 86,
          delay: 750,
          increaseDelay: 35 ~/ 8);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.aws, v),
          get: () => state.awsSkillRating,
          maxSkillRating: 91,
          delay: 800,
          increaseDelay: 45 ~/ 10);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.kotlin, v),
          get: () => state.kotlinSkillRating,
          maxSkillRating: 86,
          delay: 950,
          increaseDelay: 60 ~/ 10);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.dart, v),
          get: () => state.dartSkillRating,
          maxSkillRating: 78,
          delay: 1000,
          increaseDelay: 35 ~/ 14);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.java, v),
          get: () => state.javaSkillRating,
          maxSkillRating: 80,
          delay: 1150,
          increaseDelay: 25 ~/ 16);
      startIncreasingAnimation(
          set: (v) => _setSkillRating(SkillKey.git, v),
          get: () => state.gitSkillRating,
          maxSkillRating: 82,
          delay: 1200,
          increaseDelay: 45 ~/ 18);
    });

    Future.delayed(const Duration(milliseconds: 6200), () {
      if (isClosed) return;
      emit(state.copyWith(isEducationOverviewVisible: true));
    });

    Future.delayed(const Duration(milliseconds: 7200), () {
      if (isClosed) return;
      emit(state.copyWith(isProjectsOverviewVisible: true));
    });

    Future.delayed(const Duration(milliseconds: 7500), () {
      if (isClosed) return;
      emit(state.copyWith(isAnimationCompleted: true));
    });
  }

  void startIncreasingAnimation({
    required void Function(int) set,
    required int Function() get,
    required int maxSkillRating,
    required int delay,
    required int increaseDelay,
    int increaseValue = 1,
  }) {
    Future.delayed(
      Duration(milliseconds: delay),
      () {
        if (isClosed) return;
        final timer = Timer.periodic(
          Duration(milliseconds: increaseDelay),
          (timer) {
            if (isClosed) {
              timer.cancel();
              return;
            }
            if (get() >= maxSkillRating) {
              timer.cancel();
            } else {
              set(get() + increaseValue);
            }
          },
        );
        _timers.add(timer);
      },
    );
  }

  void resetAnimations() {
    emit(state.copyWith(
      androidSkillRating: 0,
      flutterSkillRating: 0,
      djangoSkillRating: 0,
      fastApiSkillRating: 0,
      problemSolvingSkillRating: 0,
      firebaseSkillRating: 0,
      pythonSkillRating: 0,
      dsaSkillRating: 0,
      awsSkillRating: 0,
      kotlinSkillRating: 0,
      dartSkillRating: 0,
      javaSkillRating: 0,
      gitSkillRating: 0,
      bannerWidth: 0,
      bannerHeight: 0.05,
      isProfileBannerOpened: false,
      isProfileBannerTitleVisible: false,
      isSummaryVisible: false,
      isHireMeVisible: false,
      isKPI1Visible: false,
      isKPI2Visible: false,
      isKPI3Visible: false,
      isKPI4Visible: false,
      isKPI5Visible: false,
      kpi1Value: 0,
      kpi2Value: 0,
      kpi3Value: 0,
      kpi4Value: 0,
      kpi5Value: 0,
      isSkillsVisible: false,
      isEducationOverviewVisible: false,
      isProjectsOverviewVisible: false,
    ));
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_updateScrollProgress);
    scrollController.dispose();
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
    return super.close();
  }
}
