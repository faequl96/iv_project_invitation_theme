import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/models/invitation_request.dart';

part 'try_theme_state.dart';

class TryThemeCubit extends Cubit<TryThemeState> {
  TryThemeCubit() : super(const TryThemeState());

  void emitState(TryThemeState state) => emit(state);
  void createCache(InvitationCreateRequestCache value) => emit(state.copyWith(createCache: value.toCopyWithValue()));
  void editCache(InvitationUpdateRequestCache value) => emit(state.copyWith(editCache: value.toCopyWithValue()));
}
