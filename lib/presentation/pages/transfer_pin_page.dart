import 'dart:math';
import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:brimo_clone/presentation/pages/transaction_failed_page.dart';
import 'package:brimo_clone/presentation/pages/transaction_success_page.dart';
import 'package:flutter/material.dart';

class TransferPinPage extends StatefulWidget {
  final String userId;
  final String description;
  final int amount;

  const TransferPinPage({
    super.key,
    required this.userId,
    required this.description,
    required this.amount,
  });

  @override
  State<TransferPinPage> createState() => _TransferPinPageState();
}

class _TransferPinPageState extends State<TransferPinPage> {
  final FirestoreService _firestoreService = FirestoreService();
  String _pin = "";
  bool _isLoading = false;

  void _onNumberPress(String number) {
    if (_pin.length >= 6 || _isLoading) return;
    setState(() {
      _pin += number;
    });

    if (_pin.length == 6) {
      _processTransaction();
    }
  }

  String _generateVoucherCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        12, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<void> _processTransaction() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Panggil service untuk memproses transaksi
      await _firestoreService.addTransaction(
        widget.userId,
        widget.description,
        widget.amount,
      );

      String? voucherCode;
      if (widget.description.toLowerCase().contains('voucher')) {
        voucherCode = _generateVoucherCode();
      }

      // Jika berhasil, navigasi ke halaman sukses
      if(mounted){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionSuccessPage(
              message: "Anda telah berhasil melakukan ${widget.description}",
              amount: widget.amount,
              voucherCode: voucherCode,
            ),
          ),
              (route) => route.isFirst,
        );
      }

    } catch (e) {
      // Jika gagal, navigasi ke halaman animasi gagal
      if(mounted){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionFailedPage(
              message: e.toString().replaceAll("Exception: ", ""),
            ),
          ),
        );
      }

      // Reset PIN dan loading state setelah kembali dari halaman gagal
      setState(() {
        _pin = "";
        _isLoading = false;
      });
    }
  }

  void _onBackspacePress() {
    setState(() {
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masukkan PIN"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                const Text("Masukkan 6 digit PIN Anda", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < _pin.length ? Theme.of(context).primaryColor : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ],
            ),
          const Spacer(),
          if (!_isLoading) _buildNumpad(),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index < 9) {
          return _buildNumpadButton((index + 1).toString());
        } else if (index == 10) {
          return _buildNumpadButton('0');
        } else if (index == 11) {
          return IconButton(
            icon: const Icon(Icons.backspace_outlined),
            onPressed: _onBackspacePress,
            iconSize: 32,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNumpadButton(String number) {
    return TextButton(
      onPressed: () => _onNumberPress(number),
      child: Text(
        number,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}