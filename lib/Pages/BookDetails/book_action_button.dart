import 'package:book_store/Pages/BookPage/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookActionBtn extends StatelessWidget {
  final String bookUrl;
  final String bookName;
  const BookActionBtn({super.key, required this.bookUrl, required this.bookName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(BookPage(
                bookUrl: bookUrl,
                bookName: bookName,
              ));
            },
            child: Row(
              children: [
                SvgPicture.asset("assets/Icons/book.svg"),
                const SizedBox(width: 10),
                Text(
                  "READ BOOK",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("assets/Icons/play.svg"),
              const SizedBox(width: 10),
              Text(
                "PLAY BOOK",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.background,
                      letterSpacing: 1.5,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
