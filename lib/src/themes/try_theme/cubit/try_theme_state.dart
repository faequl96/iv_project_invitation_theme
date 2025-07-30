part of 'try_theme_cubit.dart';

class TryThemeState extends Equatable {
  const TryThemeState({this.createCache, this.editCache, this.size = const Size(0, 0), this.countdownsTimerAnimationTrigger = 0});

  final InvitationCreateRequestCache? createCache;
  final InvitationUpdateRequestCache? editCache;

  final Size size;

  final int countdownsTimerAnimationTrigger;

  TryThemeState copyWith({
    CopyWithValue<InvitationCreateRequestCache?>? createCache,
    CopyWithValue<InvitationUpdateRequestCache?>? editCache,
    Size? size,
    int? countdownsTimerAnimationTrigger,
  }) {
    return TryThemeState(
      createCache: createCache != null ? createCache.value : this.createCache,
      editCache: editCache != null ? editCache.value : this.editCache,
      size: size ?? this.size,
      countdownsTimerAnimationTrigger: countdownsTimerAnimationTrigger ?? this.countdownsTimerAnimationTrigger,
    );
  }

  void emitState() => GlobalContextService.value.read<TryThemeCubit>().emitState(this);

  @override
  List<Object?> get props => [createCache, editCache, size, countdownsTimerAnimationTrigger];
}
