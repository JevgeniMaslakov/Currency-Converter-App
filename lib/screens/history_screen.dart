import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/history_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyService = HistoryService();

    return Scaffold(
      appBar: AppBar(title: const Text('История конверсий')),
      body: StreamBuilder<QuerySnapshot>(
        stream: historyService.getUserHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Нет истории'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final from = data['from'] ?? '';
              final to = data['to'] ?? '';
              final amount = data['amount'] ?? '';
              final result = data['result'] ?? '';
              final time = (data['timestamp'] as Timestamp?)?.toDate();

              return ListTile(
                title: Text('$amount $from → $result $to'),
                subtitle: time != null ? Text(time.toString()) : null,
              );
            },
          );
        },
      ),
    );
  }
}
