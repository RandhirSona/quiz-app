import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/service/database.dart';

// ignore: must_be_immutable
class Question extends StatefulWidget {
  String category;
  Question({super.key, required this.category});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool show = false;

  getontheload() async {
    QuizStream = await DatabaseMethods().getCategoryQuiz(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Stream? QuizStream;
  PageController controller = PageController();

  Widget allQuiz() {
    return StreamBuilder(
        stream: QuizStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
                  controller: controller,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              show = true;
                              setState(() {});
                            },
                            child: show
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ds["correct"] == ds["option1"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option1"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF818181),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option1"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              show = true;
                              setState(() {});
                            },
                            child: show
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ds["correct"] == ds["option2"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option2"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF818181),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option2"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              show = true;
                              setState(() {});
                            },
                            child: show
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ds["correct"] == ds["option3"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option3"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF818181),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option3"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              show = true;
                              setState(() {});
                            },
                            child: show
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ds["correct"] == ds["option4"]
                                              ? Colors.green
                                              : Colors.red,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option4"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF818181),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ds["option4"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                show = false;
                              });
                              controller.nextPage(
                                  duration: const Duration(microseconds: 200),
                                  curve: Curves.easeIn);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xFF004840),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 62, 6),
      body: Container(
        // margin: const EdgeInsets.only(top: 50, left: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: const Color(0xFFf35b32),
                        borderRadius: BorderRadius.circular(60)),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 120.0,
                  ),
                  Text(
                    widget.category,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: allQuiz()),
          ],
        ),
      ),
    );
  }
}
