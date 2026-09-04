import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsState {
  final double scrollProgress;
  final bool topBtnHovered;
  final bool isAnimationCompleted;
  final bool isProject1Visible;
  final bool isProject1ImageVisible;
  final bool isProject1DescVisible;
  final bool isProject2Visible;
  final bool isProject2ImageVisible;
  final bool isProject2DescVisible;
  final bool isProject3Visible;
  final bool isProject3ImageVisible;
  final bool isProject3DescVisible;
  final bool isProject4Visible;
  final bool isProject4ImageVisible;
  final bool isProject4DescVisible;
  final bool isProject5Visible;
  final bool isProject5ImageVisible;
  final bool isProject5DescVisible;
  final bool isComingSoonVisible;
  final bool isProject1KnowMoreBtnHovered;
  final bool isProject2KnowMoreBtnHovered;
  final bool isProject3KnowMoreBtnHovered;
  final bool isProject4KnowMoreBtnHovered;
  final bool isProject5KnowMoreBtnHovered;

  const ProjectsState({
    this.scrollProgress = 0.0,
    this.topBtnHovered = false,
    this.isAnimationCompleted = true,
    this.isProject1Visible = false,
    this.isProject1ImageVisible = false,
    this.isProject1DescVisible = false,
    this.isProject2Visible = false,
    this.isProject2ImageVisible = false,
    this.isProject2DescVisible = false,
    this.isProject3Visible = false,
    this.isProject3ImageVisible = false,
    this.isProject3DescVisible = false,
    this.isProject4Visible = false,
    this.isProject4ImageVisible = false,
    this.isProject4DescVisible = false,
    this.isProject5Visible = false,
    this.isProject5ImageVisible = false,
    this.isProject5DescVisible = false,
    this.isComingSoonVisible = false,
    this.isProject1KnowMoreBtnHovered = false,
    this.isProject2KnowMoreBtnHovered = false,
    this.isProject3KnowMoreBtnHovered = false,
    this.isProject4KnowMoreBtnHovered = false,
    this.isProject5KnowMoreBtnHovered = false,
  });

  ProjectsState copyWith({
    double? scrollProgress,
    bool? topBtnHovered,
    bool? isAnimationCompleted,
    bool? isProject1Visible,
    bool? isProject1ImageVisible,
    bool? isProject1DescVisible,
    bool? isProject2Visible,
    bool? isProject2ImageVisible,
    bool? isProject2DescVisible,
    bool? isProject3Visible,
    bool? isProject3ImageVisible,
    bool? isProject3DescVisible,
    bool? isProject4Visible,
    bool? isProject4ImageVisible,
    bool? isProject4DescVisible,
    bool? isProject5Visible,
    bool? isProject5ImageVisible,
    bool? isProject5DescVisible,
    bool? isComingSoonVisible,
    bool? isProject1KnowMoreBtnHovered,
    bool? isProject2KnowMoreBtnHovered,
    bool? isProject3KnowMoreBtnHovered,
    bool? isProject4KnowMoreBtnHovered,
    bool? isProject5KnowMoreBtnHovered,
  }) {
    return ProjectsState(
      scrollProgress: scrollProgress ?? this.scrollProgress,
      topBtnHovered: topBtnHovered ?? this.topBtnHovered,
      isAnimationCompleted:
          isAnimationCompleted ?? this.isAnimationCompleted,
      isProject1Visible: isProject1Visible ?? this.isProject1Visible,
      isProject1ImageVisible:
          isProject1ImageVisible ?? this.isProject1ImageVisible,
      isProject1DescVisible:
          isProject1DescVisible ?? this.isProject1DescVisible,
      isProject2Visible: isProject2Visible ?? this.isProject2Visible,
      isProject2ImageVisible:
          isProject2ImageVisible ?? this.isProject2ImageVisible,
      isProject2DescVisible:
          isProject2DescVisible ?? this.isProject2DescVisible,
      isProject3Visible: isProject3Visible ?? this.isProject3Visible,
      isProject3ImageVisible:
          isProject3ImageVisible ?? this.isProject3ImageVisible,
      isProject3DescVisible:
          isProject3DescVisible ?? this.isProject3DescVisible,
      isProject4Visible: isProject4Visible ?? this.isProject4Visible,
      isProject4ImageVisible:
          isProject4ImageVisible ?? this.isProject4ImageVisible,
      isProject4DescVisible:
          isProject4DescVisible ?? this.isProject4DescVisible,
      isProject5Visible: isProject5Visible ?? this.isProject5Visible,
      isProject5ImageVisible:
          isProject5ImageVisible ?? this.isProject5ImageVisible,
      isProject5DescVisible:
          isProject5DescVisible ?? this.isProject5DescVisible,
      isComingSoonVisible: isComingSoonVisible ?? this.isComingSoonVisible,
      isProject1KnowMoreBtnHovered: isProject1KnowMoreBtnHovered ??
          this.isProject1KnowMoreBtnHovered,
      isProject2KnowMoreBtnHovered: isProject2KnowMoreBtnHovered ??
          this.isProject2KnowMoreBtnHovered,
      isProject3KnowMoreBtnHovered: isProject3KnowMoreBtnHovered ??
          this.isProject3KnowMoreBtnHovered,
      isProject4KnowMoreBtnHovered: isProject4KnowMoreBtnHovered ??
          this.isProject4KnowMoreBtnHovered,
      isProject5KnowMoreBtnHovered: isProject5KnowMoreBtnHovered ??
          this.isProject5KnowMoreBtnHovered,
    );
  }
}

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit() : super(const ProjectsState()) {
    _init();
  }

  final ScrollController scrollController = ScrollController();

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
      startPageAnimations();
    }
    emit(state.copyWith(scrollProgress: 0));
  }

  void resetAnimations() {
    emit(state.copyWith(
      isProject1Visible: false,
      isProject1ImageVisible: false,
      isProject1DescVisible: false,
      isProject2Visible: false,
      isProject2ImageVisible: false,
      isProject2DescVisible: false,
      isProject3Visible: false,
      isProject3ImageVisible: false,
      isProject3DescVisible: false,
      isProject4Visible: false,
      isProject4ImageVisible: false,
      isProject4DescVisible: false,
      isProject5Visible: false,
      isProject5ImageVisible: false,
      isProject5DescVisible: false,
      isComingSoonVisible: false,
    ));
  }

  void startPageAnimations() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (isClosed) return;
      emit(state.copyWith(isProject1Visible: true));
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (isClosed) return;
      emit(state.copyWith(isProject1ImageVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (isClosed) return;
      emit(state.copyWith(isProject1DescVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (isClosed) return;
      emit(state.copyWith(isProject2Visible: true));
    });
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (isClosed) return;
      emit(state.copyWith(isProject2ImageVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 2900), () {
      if (isClosed) return;
      emit(state.copyWith(isProject2DescVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 3800), () {
      if (isClosed) return;
      emit(state.copyWith(isProject3Visible: true));
    });
    Future.delayed(const Duration(milliseconds: 4400), () {
      if (isClosed) return;
      emit(state.copyWith(isProject3ImageVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 4700), () {
      if (isClosed) return;
      emit(state.copyWith(isProject3DescVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 5600), () {
      if (isClosed) return;
      emit(state.copyWith(isProject4Visible: true));
    });
    Future.delayed(const Duration(milliseconds: 6200), () {
      if (isClosed) return;
      emit(state.copyWith(isProject4ImageVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 6500), () {
      if (isClosed) return;
      emit(state.copyWith(isProject4DescVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 7400), () {
      if (isClosed) return;
      emit(state.copyWith(isProject5Visible: true));
    });
    Future.delayed(const Duration(milliseconds: 8000), () {
      if (isClosed) return;
      emit(state.copyWith(isProject5ImageVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 8300), () {
      if (isClosed) return;
      emit(state.copyWith(isProject5DescVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 9100), () {
      if (isClosed) return;
      emit(state.copyWith(isComingSoonVisible: true));
    });
    Future.delayed(const Duration(milliseconds: 9700), () {
      if (isClosed) return;
      emit(state.copyWith(isAnimationCompleted: true));
    });
  }

  void setProjectKnowMoreHovered(int index, bool value) {
    switch (index) {
      case 1:
        emit(state.copyWith(isProject1KnowMoreBtnHovered: value));
        break;
      case 2:
        emit(state.copyWith(isProject2KnowMoreBtnHovered: value));
        break;
      case 3:
        emit(state.copyWith(isProject3KnowMoreBtnHovered: value));
        break;
      case 4:
        emit(state.copyWith(isProject4KnowMoreBtnHovered: value));
        break;
      case 5:
        emit(state.copyWith(isProject5KnowMoreBtnHovered: value));
        break;
    }
  }

  void setTopBtnHovered(bool value) =>
      emit(state.copyWith(topBtnHovered: value));

  @override
  Future<void> close() {
    scrollController.removeListener(_updateScrollProgress);
    scrollController.dispose();
    return super.close();
  }
}
