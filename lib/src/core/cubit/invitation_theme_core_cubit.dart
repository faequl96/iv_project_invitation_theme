import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';

part 'invitation_theme_core_state.dart';

class InvitationThemeCoreCubit extends Cubit<InvitationThemeCoreState> {
  InvitationThemeCoreCubit() : super(const InvitationThemeCoreState());

  void emitState(InvitationThemeCoreState state) => emit(state);
}
