import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_plus/translator_plus.dart';

final getIt = GetIt.instance;

void configureDependencies() async {
  getIt.registerFactory<AudioPlayer>(() => AudioPlayer());
  getIt.registerFactory<FlutterTts>(() => FlutterTts());
  getIt.registerFactory<GoogleTranslator>(() => GoogleTranslator());
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  // getIt.registerSingleton(AuthController());

  await GetIt.instance.isReady<SharedPreferences>(); // Add this line
}
