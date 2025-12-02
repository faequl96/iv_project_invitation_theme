import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';

class TimeAgo extends StatelessWidget {
  const TimeAgo({super.key, required this.dateTime, this.textStyle = const TextStyle(fontSize: 13)});

  final DateTime dateTime;
  final TextStyle textStyle;

  String _timeAgo(DateTime dateTime, Locale locale) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return locale.languageCode == 'id' ? 'Baru saja' : 'Recently';
    } else if (diff.inMinutes < 60) {
      return locale.languageCode == 'id' ? '${diff.inMinutes} menit lalu' : '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return locale.languageCode == 'id' ? '${diff.inHours} jam lalu' : '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return locale.languageCode == 'id' ? '${diff.inDays} hari lalu' : '${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return locale.languageCode == 'id' ? '$weeks minggu lalu' : '$weeks weeks ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return locale.languageCode == 'id' ? '$months bulan lalu' : '$months months ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return locale.languageCode == 'id' ? '$years tahun lalu' : '$years years ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();

    return Text(_timeAgo(dateTime, localeCubit.state), style: textStyle);
  }
}
