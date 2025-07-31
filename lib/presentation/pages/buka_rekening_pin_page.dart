import 'dart:math';
import 'package:brimo_clone/presentation/pages/buka_rekening_success_page.dart';
import 'package:flutter/material.dart';

class BukaRekeningPinPage extends StatefulWidget {
  final String userId;
  final String productName;
  const BukaRekeningPinPage({super.key, required this.userId, required this.productName});

  @override
  State<BukaRekeningPinPage> createState() => _BukaRekeningPinPageState();
}

class _BukaRekeningPinPageState extends State<BukaRekeningPinPage> {
  String _pin = "";

  void _onNumberPress(String number) {
    if (_pin.length >= 6) return;
    setState(() {
      _pin += number;
    });

    if (_pin.length == 6) {
      // Simulasi proses berhasil
      final random = Random();
      final newAccountNumber = (1000000000 + random.nextInt(9000000000)).toString();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BukaRekeningSuccessPage(
            productName: widget.productName,
            newAccountNumber: newAccountNumber,
            userId: widget.userId,
          ),
        ),
            (route) => false,
      );
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
        title: const Text("Buat PIN Rekening"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Buat 6 digit PIN Anda", style: TextStyle(fontSize: 18)),
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
          const Spacer(),
          _buildNumpad(),
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