import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:brimo_clone/presentation/pages/estatement_option_page.dart';
import 'package:brimo_clone/presentation/pages/transaction_detail_page.dart';
import 'package:brimo_clone/presentation/widgets/account_selection_sheet.dart';
import 'package:brimo_clone/presentation/widgets/filter_bottom_sheet.dart';
import 'package:brimo_clone/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MutasiPage extends StatefulWidget {
  final String userId;
  const MutasiPage({super.key, required this.userId});

  @override
  State<MutasiPage> createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> {
  final FirestoreService _firestoreService = FirestoreService();

  // State untuk menyimpan filter
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _transactionType = 'Semua';

  // Data rekening contoh
  final List<Map<String, String>> _accounts = [
    {'name': 'Rekening Utama', 'number': '0820 0101 4099 500'},
  ];
  late Map<String, String> _selectedAccount;

  @override
  void initState() {
    super.initState();
    // Set rekening pertama sebagai default
    _selectedAccount = _accounts.first;
  }

  void _showFilter() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape:
      const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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

  void _showAccountSelection() {
    showModalBottomSheet(
      context: context,
      shape:
      const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => AccountSelectionSheet(
        accounts: _accounts,
        onAccountSelected: (account) {
          setState(() {
            _selectedAccount = account;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mutasi"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _showFilter, // Panggil fungsi filter
              icon: const Icon(Icons.filter_list)
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor),
                        child: const Text("Mutasi Transaksi"))),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EStatementOptionPage(userId: widget.userId)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white)),
                    child: const Text("e-Statement"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            // --- PERBAIKAN DI SINI ---
            // Widget Row yang berisi tombol filter dihilangkan,
            // hanya menyisakan dropdown rekening.
            child: InkWell(
              onTap: _showAccountSelection,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedAccount['number']!),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<TransactionModel>>(
              stream: _firestoreService.getTransactionsStream(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada riwayat transaksi."));
                }

                final filteredList = snapshot.data!.where((trx) {
                  final trxDate = trx.timestamp.toDate();
                  final isAfterStartDate =
                  trxDate.isAfter(_startDate.subtract(const Duration(days: 1)));
                  final isBeforeEndDate =
                  trxDate.isBefore(_endDate.add(const Duration(days: 1)));
                  bool typeMatch = true;
                  if (_transactionType == 'Uang Masuk') {
                    typeMatch = trx.amount > 0;
                  } else if (_transactionType == 'Uang Keluar') {
                    typeMatch = trx.amount < 0;
                  }
                  return isAfterStartDate && isBeforeEndDate && typeMatch;
                }).toList();

                if (filteredList.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada transaksi pada periode ini."));
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final trx = filteredList[index];
                    bool showHeader = true;
                    if (index > 0) {
                      final prevTrx = filteredList[index - 1];
                      if (DateFormat('dd MMM yyyy')
                          .format(trx.timestamp.toDate()) ==
                          DateFormat('dd MMM yyyy')
                              .format(prevTrx.timestamp.toDate())) {
                        showHeader = false;
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showHeader)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 16, bottom: 8),
                            child: Text(
                              DateFormat('dd MMMM yyyy', 'id_ID')
                                  .format(trx.timestamp.toDate()),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TransactionDetailPage(transaction: trx),
                              ),
                            );
                          },
                          child: TransactionCard(transaction: trx),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}