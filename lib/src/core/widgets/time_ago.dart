import 'package:flutter/material.dart';

class TimeAgo extends StatelessWidget {
  const TimeAgo({super.key, required this.dateTime, this.textStyle = const TextStyle(fontSize: 13)});

  final DateTime dateTime;
  final TextStyle textStyle;

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'Baru saja';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam lalu';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} hari lalu';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks minggu lalu';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months bulan lalu';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years tahun lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeAgo(dateTime), style: textStyle);
  }
}
