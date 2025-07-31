import 'dart:typed_data';
import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class EStatementViewPage extends StatelessWidget {
  final String userId;
  final int month;
  final int year;

  const EStatementViewPage({
    super.key,
    required this.userId,
    required this.month,
    required this.year,
  });

  Future<List<TransactionModel>> _fetchTransactions() async {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0, 23, 59, 59);

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .where('timestamp', isGreaterThanOrEqualTo: firstDay)
        .where('timestamp', isLessThanOrEqualTo: lastDay)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => TransactionModel.fromFirestore(doc)).toList();
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String userName, String userEmail) async {
    final transactions = await _fetchTransactions();
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final monthName = DateFormat('MMMM', 'id_ID').format(DateTime(year, month));

    pdf.addPage(
      pw.MultiPage(
          pageFormat: format,
          header: (context) {
            return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('BRImo e-Statement', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
                pw.Text('Periode: $monthName $year'),
              ],
            );
          },
          build: (context) => [
            pw.Divider(height: 20, borderStyle: pw.BorderStyle.dashed),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: 'Laporan Rekening untuk:'),
            pw.Text(userName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
            pw.Text('Email: $userEmail'),
            pw.SizedBox(height: 30),
            pw.Table.fromTextArray(
              headers: ['Tanggal', 'Deskripsi', 'Jumlah'],
              cellAlignment: pw.Alignment.centerLeft,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey),
              data: transactions.map((trx) {
                final date = DateFormat('dd-MM-yyyy HH:mm').format(trx.timestamp.toDate());
                final amount = currencyFormatter.format(trx.amount);
                return [date, trx.description, amount];
              }).toList(),
            ),
            if (transactions.isEmpty)
              pw.Center(child: pw.Padding(padding: const pw.EdgeInsets.all(20), child: pw.Text('Tidak ada transaksi pada periode ini.')))
          ],
          footer: (context) {
            return pw.Column(children: [
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text('Dokumen ini dibuat secara otomatis oleh sistem BRImo Clone.', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey)),
            ]);
          }
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-Statement - $month/$year'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnapshot.hasData) {
            return const Center(child: Text('Gagal memuat data pengguna.'));
          }
          final userData = userSnapshot.data!.data() as Map<String, dynamic>;
          final userName = userData['name'] ?? 'Pengguna';
          final userEmail = userData['email'] ?? '-';

          return PdfPreview(
            build: (format) => _generatePdf(format, userName, userEmail),
          );
        },
      ),
    );
  }
}