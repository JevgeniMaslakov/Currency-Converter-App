import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Добавляем запись конверсии в Firestore
  Future<void> addConversion(String from, String to, double amount, double result) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // Если пользователь не авторизован, не сохраняем

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('history')
        .add({
      'from': from,
      'to': to,
      'amount': amount,
      'result': result,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Получаем поток истории конверсий пользователя
  Stream<QuerySnapshot> getUserHistory() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Возвращаем пустой поток если не авторизован
      return const Stream.empty();
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
