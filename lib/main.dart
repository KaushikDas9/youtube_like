import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:youtube_clone/3.Presentation/AddVideo/Add_Video.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/3.Presentation/LoginScreenn/Eamil_signup.dart';
import 'package:youtube_clone/3.Presentation/ManageAllScreen/Manage_All_Screen.dart';
import 'package:get_storage/get_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env["KEY"]!,
    anonKey: dotenv.env["PASSWORD"]! ,
  );
  runApp( GetMaterialApp(
    // darkTheme: ThemeData.dark(useMaterial3: true), 
    home: EmailLogin(),
    // home: Manage_All_Screen(),
  ));
}
