import 'package:equatable/equatable.dart';

class InvitationCreateRequestCache extends Equatable {
  const InvitationCreateRequestCache({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class InvitationUpdateRequestCache extends Equatable {
  const InvitationUpdateRequestCache({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
