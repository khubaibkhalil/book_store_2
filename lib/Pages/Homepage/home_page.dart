import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_store/Components/book_card.dart';
import 'package:book_store/Components/book_tile.dart';
import 'package:book_store/Components/my_drawer.dart';
import 'package:book_store/Controller/book_controller.dart';
import 'package:book_store/Models/data.dart';
import 'package:book_store/Pages/BookDetails/book_detail.dart';
import 'package:book_store/Pages/Homepage/Widgets/category_widget.dart';
import 'package:book_store/Pages/Homepage/Widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  String greeting() {
    final now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      return "Good Morning 🌻 ";
    } else if (hour < 17) {
      return "Good Afternoon 🌅 ";
    } else if (hour < 20) {
      return "Good Evening 🌆 ";
    } else {
      return "Good Night 🌙 ";
    }
  }

  const HomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          // Fetch all books again from Firebase
          bookController.getAllBooks();
          // Return a Future indicating that the refresh has completed
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                color: Theme.of(context).colorScheme.primary,
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            const HomeAppBar(),
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Text(
                                  greeting(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Discover new books and topics based on your interest",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search for books',
                                prefixIcon: const Icon(Icons.search),
                                border: const OutlineInputBorder(
                                ),
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .background,
                                filled: true,

                              ),
                              onChanged: (value) {
                                // Filter the list of books based on the search query
                                bookController.filterBooks(value);
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Topics",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: categoryData
                                    .map(
                                      (e) => CategoryWidget(
                                      iconPath: e["icon"]!,
                                      btnName: e["lebel"]!),
                                )
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Trending",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                            () => Row(
                          children: bookController.filteredBooks
                              .map(
                                (e) => BookCard(
                              title: e.title!,
                              coverUrl: e.coverUrl!,
                              ontap: () {
                                Get.to(BookDetails(
                                  book: e,
                                ));
                              },
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Your Interests",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Column(
                      children: bookController.filteredBooks
                          .map(
                            (e) => BookTile(
                          ontap: () {
                            Get.to(BookDetails(book: e));
                          },
                          title: e.title!,
                          coverUrl: e.coverUrl!,
                          author: e.author!,
                          price: e.price!,
                          rating: e.rating!,
                          totalRating: 12,
                        ),
                      )
                          .toList(),
                    ))
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
