part of 'invited_guest_cubit.dart';

class InvitedGuestState extends Equatable {
  const InvitedGuestState({
    this.isLoadingCheck = false,
    this.isLoadingUpsert = false,
    this.isLoadingGetById = false,
    this.isLoadingGetsByInvitationId = false,
    this.isLoadingUpdateById = false,
    this.invitedGuest,
    this.invitedGuests = const [],
  });

  final bool isLoadingCheck;
  final bool isLoadingUpsert;
  final bool isLoadingGetById;
  final bool isLoadingGetsByInvitationId;
  final bool isLoadingUpdateById;
  final InvitedGuestResponse? invitedGuest;
  final List<InvitedGuestResponse> invitedGuests;

  InvitedGuestState copyWith({
    bool? isLoadingCheck,
    bool? isLoadingUpsert,
    bool? isLoadingGetById,
    bool? isLoadingGetsByInvitationId,
    bool? isLoadingUpdateById,
    CopyWithValue<InvitedGuestResponse?>? invitedGuest,
    CopyWithValue<List<InvitedGuestResponse>>? invitedGuests,
  }) {
    return InvitedGuestState(
      isLoadingCheck: isLoadingCheck ?? this.isLoadingCheck,
      isLoadingUpsert: isLoadingUpsert ?? this.isLoadingUpsert,
      isLoadingGetById: isLoadingGetById ?? this.isLoadingGetById,
      isLoadingGetsByInvitationId: isLoadingGetsByInvitationId ?? this.isLoadingGetsByInvitationId,
      isLoadingUpdateById: isLoadingUpdateById ?? this.isLoadingUpdateById,
      invitedGuest: invitedGuest != null ? invitedGuest.value : this.invitedGuest,
      invitedGuests: invitedGuests != null ? invitedGuests.value : this.invitedGuests,
    );
  }

  void emitState() => GlobalContextService.value.read<InvitedGuestCubit>().emitState(this);

  @override
  List<Object?> get props => [
    isLoadingCheck,
    isLoadingUpsert,
    isLoadingGetById,
    isLoadingGetsByInvitationId,
    isLoadingUpdateById,
    invitedGuest,
  ];
}
