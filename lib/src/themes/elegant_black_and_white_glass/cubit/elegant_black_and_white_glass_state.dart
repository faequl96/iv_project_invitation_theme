part of 'elegant_black_and_white_glass_cubit.dart';

class ElegantBlackAndWhiteGlassState extends Equatable {
  const ElegantBlackAndWhiteGlassState({this.createCache, this.editCache});

  final InvitationCreateRequestCache? createCache;
  final InvitationUpdateRequestCache? editCache;

  ElegantBlackAndWhiteGlassState copyWith({
    CopyWithValue<InvitationCreateRequestCache?>? createCache,
    CopyWithValue<InvitationUpdateRequestCache?>? editCache,
  }) {
    return ElegantBlackAndWhiteGlassState(
      createCache: createCache != null ? createCache.value : this.createCache,
      editCache: editCache != null ? editCache.value : this.editCache,
    );
  }

  void emitState() => GlobalContextService.value.read<ElegantBlackAndWhiteGlassCubit>().emitState(this);

  @override
  List<Object?> get props => [createCache, editCache];
}
