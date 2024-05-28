import 'dart:math';

import 'package:book_store/Config/colors.dart';
import 'package:book_store/Config/default_profile.dart';
import 'package:book_store/Config/messages.dart';
import 'package:book_store/Controller/auth_controller.dart';
import 'package:book_store/Pages/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    final List<String> quotes = [
      "Books are a uniquely portable magic. — Stephen King",
      "A room without books is like a body without a soul. — Marcus Tullius Cicero",
      "So many books, so little time. — Frank Zappa",
      "A book is a dream that you hold in your hand. — Neil Gaiman",
      "Books are the quietest and most constant of friends. — Charles W. Eliot",
      "Books are the plane, and the train, and the road. They are the destination and the journey. — Anna Quindlen",
      "Reading gives us someplace to go when we have to stay where we are. — Mason Cooley",
      "Books are mirrors: you only see in them what you already have inside you. — Carlos Ruiz Zafón",
      "Books are the treasured wealth of the world. — Henry David Thoreau",
      "A book is like a garden carried in the pocket. — Chinese Proverb"
    ];
    String showRandomQuote() {
      final random = Random();
      return quotes[random.nextInt(quotes.length)];
    }

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: primaryColor),
              accountName: Text(
                authController.auth.currentUser!.displayName ?? "Local User",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              accountEmail: Text("${authController.auth.currentUser!.email}"),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: primaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    authController.auth.currentUser!.photoURL ?? defaultProfile,
                    fit: BoxFit.cover,
                  ),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Get.to(const ProfilePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My Uploads '),
            onTap: () {
              Get.to(const ProfilePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Magic '),
            onTap: () {
              successMessage(showRandomQuote());
            },
          ),

          // ListTile(
          //   leading: const Icon(Icons.edit),
          //   title: const Text(' Edit Profile '),
          //   onTap: () {
          //     // Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              authController.signout();
            },
          ),
        ],
      ),
    );
  }
}
