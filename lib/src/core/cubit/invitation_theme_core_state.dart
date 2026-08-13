part of 'invitation_theme_core_cubit.dart';

class const InvitationThemeCoreState({
  final Size size = const Size(0, 0),
  final int animationTrigger = 0,
  final int pageActive = 0,
}) extends Equatable {
  InvitationThemeCoreState copyWith({Size? size, int? animationTrigger, int? pageActive}) {
    return InvitationThemeCoreState(
      size: size ?? this.size,
      animationTrigger: animationTrigger ?? this.animationTrigger,
      pageActive: pageActive ?? this.pageActive,
    );
  }

  void emitState() => GlobalContextService.value.read<InvitationThemeCoreCubit>().emitState(this);

  @override
  List<Object?> get props => [size, animationTrigger, pageActive];
}
