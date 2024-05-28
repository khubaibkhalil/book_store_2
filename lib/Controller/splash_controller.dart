import 'package:book_store/Pages/Homepage/home_page.dart';
import 'package:book_store/Pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splaceController();
  }

  void splaceController() {
    Future.delayed(const Duration(seconds: 1), () {
      if (auth.currentUser != null) {
        Get.offAll(const HomePage());
      } else {
        Get.offAll(const WelcomePage());
      }
    });
  }
}
