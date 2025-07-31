import 'package:flutter/material.dart';

class InvestasiPage extends StatelessWidget {
  const InvestasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Investasi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.real_estate_agent, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Halaman Investasi",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}