import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _tasks =>
      _firestore.collection('tasks');

  Future<void> addTask({
    required String uid,
    required String title,
  }) {
    return _tasks.add({
      'uid': uid,
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks(String uid) {
    return _tasks
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      if (kDebugMode) {
        debugPrint(
          'Firestore sync: tasks update for uid=$uid, docs=${snapshot.docs.length}',
        );
      }
      return snapshot;
    });
  }
}
