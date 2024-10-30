// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/service/database.dart';
import 'package:random_string/random_string.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});
  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final ImagePicker _picker = ImagePicker();
  File? selecteddImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selecteddImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selecteddImage != null &&
        option1controller.text != "" &&
        option2controller.text != "" &&
        option3controller.text != "" &&
        option4controller.text != "" &&
        correctcontroller.text != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selecteddImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addQuiz = {
        "Image": downloadUrl,
        "option1": option1controller.text,
        "option2": option2controller.text,
        "option3": option3controller.text,
        "option4": option4controller.text,
        "correct": correctcontroller.text,
        //"category":
      };

      await DatabaseMethods().addQuizCategory(addQuiz, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Quiz has been added Successfully!",
              style: TextStyle(fontSize: 18),
            )));

        // Clear the image and text fields after adding the quiz
        setState(() {
          selecteddImage = null; // Clear the selected image
          option1controller.clear(); // Clear Option 1
          option2controller.clear(); // Clear Option 2
          option3controller.clear(); // Clear Option 3
          option4controller.clear(); // Clear Option 4
          correctcontroller.clear(); // Clear Correct Answer
          value = null; // Clear the selected category if needed
        });
      });
    }
  }

  String? value;
  final List<String> quizitems = [
    'Place',
    'Animal',
    'Sports',
    'Fruits',
    'Random',
    'Object'
  ];

  TextEditingController option1controller = TextEditingController();
  TextEditingController option2controller = TextEditingController();
  TextEditingController option3controller = TextEditingController();
  TextEditingController option4controller = TextEditingController();
  TextEditingController correctcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Quiz",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload the Quiz picture",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              selecteddImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          // Allow changing the image
                          getImage();
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    selecteddImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  selecteddImage =
                                      null; // Remove the selected image
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 1",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: option1controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 1",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 2",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: option2controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 2",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 3",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: option3controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 3",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 4",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: option4controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 4",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Correct Answer",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: correctcontroller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Correct Answer",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  items: quizitems
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                  dropdownColor: Colors.white,
                  hint: const Text("Select Category"),
                  iconSize: 36,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  value: value,
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
