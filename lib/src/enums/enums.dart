enum SlideFrom { top, left, right, bottom }

enum GroundSlideFrom { left, right }

enum ViewType { example, preview, draft, live }

enum Attendance {
  yes('Mungkin Hadir'),
  no('Mungkin Tidak Hadir');

  const Attendance(this.description);

  final String description;
}

enum Avatars { love, calm, unpleasant, worry, cry, happy, laughing, shock, pensive, angry }
