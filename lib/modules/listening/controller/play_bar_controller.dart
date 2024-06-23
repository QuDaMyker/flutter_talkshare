import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/modules/listening/view/listening_read_screen.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

enum VolumeState { muted, min, max }
enum SpeedState { x0_5, x1_0, x2_0 }

class PlayBarController extends GetxController {
  late AudioPlayer _audioPlayer;
  late RxInt currentIndex= 0.obs;
  RxBool isPlaying = true.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<VolumeState> volumeState = VolumeState.max.obs;
  Rx<SpeedState> speedState = SpeedState.x1_0.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  Future<void> initializeAudio(String audioUrl) async {
    await _audioPlayer.setUrl(audioUrl);
    totalDuration.value = _audioPlayer.duration ?? Duration.zero;
    _audioPlayer.play();
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
      update();
    });

    _audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _audioPlayer.play();
        isPlaying.value = true;
        currentPosition.value = totalDuration.value;
        _audioPlayer.seek(Duration.zero); 
        update();
      }
    });    
  }

  void playPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    isPlaying.value = !isPlaying.value;
    update();
  }

  void seekTo(double seconds) {
    final position = Duration(seconds: seconds.toInt());
    _audioPlayer.seek(position);
    update();
  }

  void setVolume(VolumeState state) {
    switch (state) {
      case VolumeState.muted:
        _audioPlayer.setVolume(0.0);
        break;
      case VolumeState.min:
        _audioPlayer.setVolume(0.3);
        break;
      case VolumeState.max:
        _audioPlayer.setVolume(1.0);
        break;
    }
    volumeState.value = state;
    update();
  }

  void setSpeed(SpeedState state) {
    switch (state) {
      case SpeedState.x0_5:
        _audioPlayer.setSpeed(0.6);
        break;
      case SpeedState.x1_0:
        _audioPlayer.setSpeed(1.0);
        break;
      case SpeedState.x2_0:
        _audioPlayer.setSpeed(1.7);
        break;
    }
    speedState.value = state;
    update();
  }

  @override
  void onClose() {
    _audioPlayer.pause();
    _audioPlayer.dispose();
    super.onClose();
  }

  void goNextListening() {
    if (currentIndex.value < ListeningList.listeningShortList.length - 1) {
      currentIndex.value++;
      print('Current index: ${currentIndex.value}');
      update();

      Get.off(() => ListeningReadScreen(listening: ListeningList.listeningShortList[currentIndex.value]));
    }
  }
}
