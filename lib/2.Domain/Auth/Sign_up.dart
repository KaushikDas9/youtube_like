import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/3.Presentation/ManageAllScreen/Manage_All_Screen.dart';

class Sign_Up_SupaBase {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signUpNewUser(
      {required String email, required String password}) async {
    try {

            supabase.auth.signUp(email: email.replaceAll(" ", "") , password: password).then((value) { 
            Get.snackbar("SIGN UP", "Successfully Sign up");
            Get.off(const Manage_All_Screen());} );
      
      
    } on AuthException catch (e) {
      Get.snackbar("ERROR", e.message.toString());
      print(e.message.toString());
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      supabase.auth.signInWithPassword(email: email.replaceAll(" ", ""), password: password).then((value) {
        Get.snackbar("Login", "Successfully Login");
        Get.off(const Manage_All_Screen());
      });


    }on AuthException catch (e) {
      Get.snackbar("ERROR", e.message.toString());
    }
  }
}
