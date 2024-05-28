import 'package:book_store/AuthPage/auth_page.dart';
import 'package:book_store/Components/primary_button.dart';
import 'package:book_store/Controller/auth_controller.dart';
import 'package:book_store/Pages/Homepage/home_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      "assets/Images/book.png",
                      width: 380,
                    ),
                    const SizedBox(height: 60),
                    Text(
                      "E - Book Store",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 22.0, // Increased font size for the main text
                            color: Theme.of(context).colorScheme.background,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(text: "Read your "),
                            TextSpan(
                              text: "favorite books",
                              style: TextStyle(
                                fontSize: 24.0, // Increased font size for "favorite books"
                                color: Colors.orangeAccent,
                              ),
                            ),
                            TextSpan(text: " on the "),
                            TextSpan(text: "go", style: TextStyle(color: Colors.greenAccent)),
                          ],
                        ),
                      ),


                    ),
                  ],
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Disclaimer",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(

                        "All eBooks available in this store are the property of their respective authors and publishers. You are free to download and read them. We do not charge for the books. We only provide the platform for easy access to the books. Enjoy reading!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                PrimaryButton(
                  btnName: "Google",
                  imgPath: "assets/Icons/google.png",
                  ontap: () {
                    authController.loginWithEmail();
                  },
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  btnName: "Email",
                  imgPath: "assets/Icons/mail.png",
                  ontap: () {
                    Get.to(AuthPage());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
