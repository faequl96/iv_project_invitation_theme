import 'dart:io';

class ImagesRaw {
  const ImagesRaw({this.coverImage, this.brideImage, this.groomImage, required this.galleries});

  final File? coverImage;
  final File? brideImage;
  final File? groomImage;
  final List<File?> galleries;
}
