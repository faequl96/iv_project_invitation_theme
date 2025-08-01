part of 'core_cubit.dart';

class CoreState extends Equatable {
  const CoreState({this.size = const Size(0, 0), this.countdownsTimerAnimationTrigger = 0});

  final Size size;

  final int countdownsTimerAnimationTrigger;

  CoreState copyWith({Size? size, int? countdownsTimerAnimationTrigger}) {
    return CoreState(
      size: size ?? this.size,
      countdownsTimerAnimationTrigger: countdownsTimerAnimationTrigger ?? this.countdownsTimerAnimationTrigger,
    );
  }

  void emitState() => GlobalContextService.value.read<CoreCubit>().emitState(this);

  @override
  List<Object?> get props => [size, countdownsTimerAnimationTrigger];
}
