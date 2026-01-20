import 'package:just_audio/just_audio.dart';

class CoreStatic {
  static final player = AudioPlayer();

  static void setupAudioPlayer(String audioUrl) async {
    await player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
  }
}
