part of 'rsvp_cubit.dart';

class RSVPState extends Equatable {
  const RSVPState({this.isLoadingCreate = false, this.isLoadingGetsByInvitationId = false, this.rsvp, this.rsvps});

  final bool isLoadingCreate;
  final bool isLoadingGetsByInvitationId;
  final RSVPResponse? rsvp;
  final List<RSVPResponse>? rsvps;

  RSVPState copyWith({
    bool? isLoadingCreate,
    bool? isLoadingGetsByInvitationId,
    CopyWithValue<RSVPResponse?>? rsvp,
    CopyWithValue<List<RSVPResponse>?>? rsvps,
  }) {
    return RSVPState(
      isLoadingCreate: isLoadingCreate ?? this.isLoadingCreate,
      isLoadingGetsByInvitationId: isLoadingGetsByInvitationId ?? this.isLoadingGetsByInvitationId,
      rsvp: rsvp != null ? rsvp.value : this.rsvp,
      rsvps: rsvps != null ? rsvps.value : this.rsvps,
    );
  }

  void emitState() => GlobalContextService.value.read<RSVPCubit>().emitState(this);

  @override
  List<Object?> get props => [isLoadingCreate, isLoadingGetsByInvitationId, rsvp, rsvps];
}
