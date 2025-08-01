import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/models/invitation_request.dart';

part 'elegant_black_and_white_glass_state.dart';

class ElegantBlackAndWhiteGlassCubit extends Cubit<ElegantBlackAndWhiteGlassState> {
  ElegantBlackAndWhiteGlassCubit() : super(const ElegantBlackAndWhiteGlassState());

  void emitState(ElegantBlackAndWhiteGlassState state) => emit(state);
  void createCache(InvitationCreateRequestCache value) => emit(state.copyWith(createCache: value.toCopyWithValue()));
  void editCache(InvitationUpdateRequestCache value) => emit(state.copyWith(editCache: value.toCopyWithValue()));
}
