// ignore_for_file: constant_identifier_names

enum H { Xs, Sm, Md, Lg, Xl }

enum W { Xs, Sm, Md, Lg, Xl }

enum InvitationType { create, edit, view }

enum Attendance {
  yes('Hadir'),
  no('Tidak Hadir');

  const Attendance(this.description);

  final String description;
}
