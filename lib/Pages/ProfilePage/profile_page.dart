import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_store/Components/profile_tile.dart';
import 'package:book_store/Config/default_profile.dart';
import 'package:book_store/Controller/auth_controller.dart';
import 'package:book_store/Controller/book_controller.dart';
import 'package:book_store/Pages/AddNewBook/add_new_book.dart';
import 'package:book_store/Pages/BookDetails/book_detail.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    BookController bookController = Get.put(BookController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Get.to(AddNewBookPage());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      appBar: AppBar(




        leading: BackButton(
          color: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(

            onPressed: () {
              authController.signout();

            },
            icon: Icon(Icons.logout, color: Colors.white),
          )],
        title:  Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // Fetch the user's books again from Firebase
          bookController.getUserBook();
          // Return a Future indicating that the refresh has completed
          return Future.value();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                color: Theme.of(context).colorScheme.primary,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Your header content here
                          ],
                        ),
                        SizedBox(height:40),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.background,
                              )),
                          child: Container(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "${authController.auth.currentUser!.photoURL ?? defaultProfile}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${authController.auth.currentUser!.displayName ?? "Local User"}",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.background),
                        ),
                        Text(
                          "${authController.auth.currentUser!.email}",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                    Row(
                      children: [
                        Text("Your Books",
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                    SizedBox(height: 20),
                    Obx(
                          () => Column(
                        children: bookController.currentUserBooks
                            .map((e) => ProfileBookTile(
                          title: e.title!,
                          coverUrl: e.coverUrl!,
                          author: e.author!,
                          price: e.price!,
                          rating: e.rating!,
                          totalRating: 12,
                          ontap: () {
                            Get.to(BookDetails(book: e));
                          },
                        ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
