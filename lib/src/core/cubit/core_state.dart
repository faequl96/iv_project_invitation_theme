part of 'core_cubit.dart';

class CoreState extends Equatable {
  const CoreState({this.size = const Size(0, 0), this.animationTrigger = 0});

  final Size size;

  final int animationTrigger;

  CoreState copyWith({Size? size, int? animationTrigger}) {
    return CoreState(size: size ?? this.size, animationTrigger: animationTrigger ?? this.animationTrigger);
  }

  void emitState() => GlobalContextService.value.read<CoreCubit>().emitState(this);

  @override
  List<Object?> get props => [size, animationTrigger];
}
