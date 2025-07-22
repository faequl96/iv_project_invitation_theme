import 'package:just_audio/just_audio.dart';

class Audio {
  static late final AudioPlayer player;

  static void initPlayer() async {
    player = AudioPlayer();
    // await player.setAudioSource(AudioSource.asset('assets/its_you.mp3'));
  }
}
