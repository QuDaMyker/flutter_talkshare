import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:flutter_talkshare/modules/game/view/game_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/profile/view/profile_screen.dart';
import 'package:flutter_talkshare/modules/root_view/controller/root_view_controller.dart';
import 'package:flutter_talkshare/modules/splash/controller/splash_controller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_plus/translator_plus.dart';

final getIt = GetIt.instance;

void configureDependencies() async {
  configureHelper();
  configureController();
}

void configureHelper() async {
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
  getIt.registerSingleton<FlutterTts>(FlutterTts());
  getIt.registerSingleton<GoogleTranslator>(GoogleTranslator());
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  await GetIt.instance.isReady<SharedPreferences>(); // Add this line
}

void configureController() async {
  getIt.registerSingleton<SplashController>(SplashController(),
      signalsReady: true);
  getIt.registerSingleton<AuthController>(AuthController(), signalsReady: true);
  getIt.registerSingleton<RootViewController>(RootViewController(),
      signalsReady: true);
  getIt.registerSingleton<HomeScreen>(HomeScreen(), signalsReady: true);
  getIt.registerSingleton<CommnityScreen>(CommnityScreen(), signalsReady: true);
  getIt.registerSingleton<GameScreen>(GameScreen(), signalsReady: true);
  getIt.registerSingleton<ProfileScreen>(ProfileScreen(), signalsReady: true);

  // Get.lazyPut(() => HomeScreen());
  // Get.lazyPut(() => CommnityScreen());
  // // Get.lazyPut(() => const HomeworkScreen());
  // Get.lazyPut(() => const GameScreen());
  // Get.lazyPut(() => const ProfileScreen());
}
