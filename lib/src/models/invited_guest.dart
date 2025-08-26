class InvitedGuest {
  InvitedGuest({
    this.id = '',
    required this.nameInstance,
    required this.name,
    required this.instance,
    this.nickName = '',
    this.avatar = '',
    this.attendance = '',
  });

  final String id;
  final String nameInstance;
  final String name;
  final String instance;
  final String nickName;
  final String avatar;
  final String attendance;
}
