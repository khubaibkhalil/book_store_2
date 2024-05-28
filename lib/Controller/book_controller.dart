import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:book_store/Config/messages.dart';
import 'package:book_store/Models/book_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController aboutAuth = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController audioLen = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController price = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = true.obs;
  var bookData = RxList<BookModel>();
  var currentUserBooks = RxList<BookModel>();
  RxList<BookModel> filteredBooks = RxList<BookModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBooks();
  }

  void getAllBooks() async {
    bookData.clear();
    successMessage("Books fetched successfully");
    var books = await db.collection("Books").get();
    for (var book in books.docs) {
      bookData.add(BookModel.fromJson(book.data()));
    }
    filteredBooks.assignAll(bookData); // Initialize filteredBooks with all books initially
  }

  void getUserBook() async {
    currentUserBooks.clear();
    var books = await db
        .collection("userBook")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .get();
    currentUserBooks.assignAll(books.docs.map((doc) => BookModel.fromJson(doc.data())).toList());
  }

  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      uploadImageToFirebase(File(image.path));
    }
    isImageUploading.value = false;
  }

  void uploadImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isImageUploading.value = false;
  }

  void removeBook(String bookTitle) async {
    try {
      // Query to find the book's ID based on its title
      QuerySnapshot titleQuery = await db.collection("Books").where("title", isEqualTo: bookTitle).get();

      if (titleQuery.docs.isNotEmpty) {
        String bookId = titleQuery.docs.first.id;

        // Delete the book from the 'Books' collection
        await db.collection("Books").doc(bookId).delete();

        // Delete the book from the user's collection
        await db
            .collection("userBook")
            .doc(fAuth.currentUser!.uid)
            .collection("Books")
            .where("title", isEqualTo: bookTitle) // Query by title to ensure correctness
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the book from the local list
        bookData.removeWhere((book) => book.id == bookId);
        currentUserBooks.removeWhere((book) => book.id == bookId);

        successMessage("Book removed successfully");
      } else {
        errorMessage("Book not found with title: $bookTitle");
      }
    } catch (e) {
      // Handle any errors
      errorMessage("Failed to remove book: $e");
    }
  }

  void createBook() async {
    isPostUploading.value = true;
    var newBook = BookModel(
      id: "$index",
      title: title.text,
      description: des.text,
      coverUrl: imageUrl.value,
      bookurl: pdfUrl.value,
      author: auth.text,
      aboutAuthor: aboutAuth.text,
      price: int.parse(price.text),
      pages: int.parse(pages.text),
      language: language.text,
      audioLen: audioLen.text,
      audioUrl: "",
      rating: "",
    );

    await db.collection("Books").add(newBook.toJson());
    addBookInUserDb(newBook);
    isPostUploading.value = false;
    title.clear();
    des.clear();
    aboutAuth.clear();
    pages.clear();
    language.clear();
    audioLen.clear();
    auth.clear();
    price.clear();
    imageUrl.value = "";
    pdfUrl.value = "";
    successMessage("Book added to the db");
    getAllBooks();
    getUserBook();
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("File Bytes: $fileBytes");

        final response =
        await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        print(downloadURL);
      } else {
        print("File does not exist");
      }
    } else {
      print("No file selected");
    }
    isPdfUploading.value = false;
  }

  void addBookInUserDb(BookModel book) async {
    await db
        .collection("userBook")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .add(book.toJson());
  }

  void filterBooks(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all books
      filteredBooks.assignAll(bookData);
    } else {
      // Filter books based on the search query
      filteredBooks.assignAll(
        bookData.where(
              (book) => book.title!.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
