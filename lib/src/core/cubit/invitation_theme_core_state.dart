part of 'invitation_theme_core_cubit.dart';

class InvitationThemeCoreState extends Equatable {
  const InvitationThemeCoreState({this.size = const Size(0, 0), this.animationTrigger = 0});

  final Size size;

  final int animationTrigger;

  InvitationThemeCoreState copyWith({Size? size, int? animationTrigger}) {
    return InvitationThemeCoreState(size: size ?? this.size, animationTrigger: animationTrigger ?? this.animationTrigger);
  }

  void emitState() => GlobalContextService.value.read<InvitationThemeCoreCubit>().emitState(this);

  @override
  List<Object?> get props => [size, animationTrigger];
}
