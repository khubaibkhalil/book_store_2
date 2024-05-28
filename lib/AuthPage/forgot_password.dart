// import 'dart:math';

import 'package:book_store/Config/messages.dart';
// import 'package:book_store/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future passwordRest() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email.text.trim());

        successMessage("Password Reset Email Sent");
      } on FirebaseAuthException catch (e) {
        errorMessage(e.toString());
      }
    }

    // AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).colorScheme.background),
        // leading: Icon(Icons.arrow_back),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Forgot Password",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email id and we will send you reset password link on email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Email id",
                fillColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  passwordRest();
                },
                child: const Text("Reset Now")),
          ],
        ),
      ),
    );
  }
}
