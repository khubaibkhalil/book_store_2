// import 'package:book_store/Components/book_tile.dart';
import 'package:book_store/Components/multi_line_text_form_field.dart';
import 'package:book_store/Components/my_back_button.dart';
import 'package:book_store/Components/my_text_form_field.dart';
import 'package:book_store/Config/colors.dart';
import 'package:book_store/Controller/book_controller.dart';
import 'package:book_store/Controller/pdf_controller.dart';
// import 'package:book_store/Models/data.dart';
// import 'package:book_store/Pages/BookDetails/book_detail.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddNewBookPage extends StatelessWidget {
  const AddNewBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    PdfController pdfController = Get.put(PdfController());
    BookController bookController = Get.put(BookController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MyBackButton(),
                          Text(
                            "ADD NEW BOOK",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          const SizedBox(width: 70)
                        ],
                      ),
                      const SizedBox(height: 60),
                      InkWell(
                          onTap: () {
                            bookController.pickImage();
                          },
                          child: Obx(
                            () => Container(
                              height: 190,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Center(
                                child: bookController.isImageUploading.value
                                    ? const CircularProgressIndicator(
                                        color: primaryColor,
                                      )
                                    : bookController.imageUrl.value == ""
                                        ? Image.asset(
                                            "assets/Icons/addImage.png")
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              bookController.imageUrl.value,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bookController.pdfUrl.value == ""
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: bookController.isPdfUploading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: backgroudColor,
                                  ),
                                )
                              : bookController.pdfUrl.value == ""
                                  ? InkWell(
                                      onTap: () {
                                        bookController.pickPDF();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/Icons/upload.png"),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Book PDF",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        bookController.pdfUrl.value = "";
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Icons/delete.png",
                                            width: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Delete Pdf",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Book title",
                  icon: Icons.book,
                  controller: bookController.title,
                ),
                const SizedBox(height: 10),
                MultiLineTextFormField(
                    hintText: "Book Description",
                    controller: bookController.des),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Author Name",
                  icon: Icons.person,
                  controller: bookController.auth,
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "About Author",
                  icon: Icons.person,
                  controller: bookController.aboutAuth,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        isNumber: true,
                        hintText: "Price",
                        icon: Icons.monetization_on,
                        controller: bookController.price,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Pages",
                        isNumber: true,
                        icon: Icons.book,
                        controller: bookController.pages,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Language",
                        icon: Icons.language,
                        controller: bookController.language,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Audio Len",
                        icon: Icons.audiotrack,
                        controller: bookController.audioLen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: Colors.red,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "CANCEL",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.red,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: bookController.isPdfUploading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  bookController.createBook();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_sharp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "POST",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    )),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
