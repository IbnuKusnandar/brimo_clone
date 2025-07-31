import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:brimo_clone/presentation/pages/transaction_detail_page.dart';
import 'package:brimo_clone/presentation/widgets/activity_card.dart';
import 'package:brimo_clone/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  final String userId;
  const ActivityPage({super.key, required this.userId});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final FirestoreService _firestoreService = FirestoreService();

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _transactionType = 'Semua';

  void _showFilter() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (context) => FilterBottomSheet(
        initialStartDate: _startDate,
        initialEndDate: _endDate,
      ),
    );

    if (result != null) {
      setState(() {
        _startDate = result['startDate'];
        _endDate = result['endDate'];
        _transactionType = result['type'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktivitas"),
        actions: [
          IconButton(
            onPressed: _showFilter,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: _firestoreService.getTransactionsStream(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada aktivitas."));
          }

          final filteredList = snapshot.data!.where((trx) {
            final trxDate = trx.timestamp.toDate();
            final isAfterStartDate = trxDate.isAfter(_startDate.subtract(const Duration(days: 1)));
            final isBeforeEndDate = trxDate.isBefore(_endDate.add(const Duration(days: 1)));
            bool typeMatch = true;
            if (_transactionType == 'Uang Masuk') {
              typeMatch = trx.amount > 0;
            } else if (_transactionType == 'Uang Keluar') {
              typeMatch = trx.amount < 0;
            }
            return isAfterStartDate && isBeforeEndDate && typeMatch;
          }).toList();

          if (filteredList.isEmpty) {
            return const Center(child: Text("Tidak ada aktivitas pada periode ini."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final trx = filteredList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailPage(transaction: trx)));
                },
                child: ActivityCard(transaction: trx),
              );
            },
          );
        },
      ),
    );
  }
}