import 'package:flutter_bloc/flutter_bloc.dart';

class EducationState {
  final bool topBtnHovered;
  final bool isProject1KnowMoreBtnHovered;

  const EducationState({
    this.topBtnHovered = false,
    this.isProject1KnowMoreBtnHovered = false,
  });

  EducationState copyWith({
    bool? topBtnHovered,
    bool? isProject1KnowMoreBtnHovered,
  }) {
    return EducationState(
      topBtnHovered: topBtnHovered ?? this.topBtnHovered,
      isProject1KnowMoreBtnHovered:
          isProject1KnowMoreBtnHovered ?? this.isProject1KnowMoreBtnHovered,
    );
  }
}

class EducationCubit extends Cubit<EducationState> {
  EducationCubit() : super(const EducationState());

  void setTopBtnHovered(bool value) =>
      emit(state.copyWith(topBtnHovered: value));

  void setProject1KnowMoreHovered(bool value) =>
      emit(state.copyWith(isProject1KnowMoreBtnHovered: value));
}
