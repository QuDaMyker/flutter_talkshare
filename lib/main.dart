import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/modules/create_new_list_vocab/view/creare_new%20_list_vocab_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/root_view/view/root_view_screen.dart';
import 'package:flutter_talkshare/modules/vocab_list_folder/views/vocab_list_folder.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SupabaseService.instance.init();

  //test supabase
  Vocab vocab =
      await SupabaseService.instance.getVocabByWord('trace').then((value) {
    print("${value.word}: ${value.primaryMeaning}");
    return value;
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const RootViewScreen(),
    );
  }
}
