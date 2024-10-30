import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addQuizCategory(
      Map<String, dynamic> userQuizCategory, String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .add(userQuizCategory);
  }

  Future<Stream<QuerySnapshot>> getCategoryQuiz(String category) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }
}
