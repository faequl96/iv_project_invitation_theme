// ignore_for_file: constant_identifier_names

enum ThemePreviewType { fromResponse, fromRaw }

enum Attendance {
  yes('Hadir'),
  no('Tidak Hadir');

  const Attendance(this.description);

  final String description;
}

enum Avatars { love, calm, unpleasant, worry, cry, happy, laughing, shock, pensive, angry }
