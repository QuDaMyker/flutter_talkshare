import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/modules/grammar/views/detail_grammar_screen.dart';
import 'package:flutter_talkshare/modules/grammar/views/list_grammar_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/onboarding/views/onboarding_screen.dart';
import 'package:flutter_talkshare/modules/profile/view/profile_screen.dart';
import 'package:flutter_talkshare/modules/splash/views/splash_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'core/configuration/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SupabaseService.instance.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.full,
      showPerformanceOverlay: false,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // supportedLocales: [
      //   const Locale('vi', 'VI'),
      // ],
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      //home: ProfileScreen(),
    );
  }
}
