class RSVP {
  RSVP({
    this.id = '',
    required this.invitedGuestId,
    this.guestName = '',
    required this.avatar,
    required this.invited,
    required this.attendance,
    required this.remark,
    required this.dateTime,
  });

  final String id;
  final String invitedGuestId;
  final String guestName;
  late final String avatar;
  late final bool invited;
  late final String attendance;
  final String remark;
  final int dateTime;
}
