import 'package:flutter/material.dart';

class AccountSelectionSheet extends StatelessWidget {
  final List<Map<String, String>> accounts;
  final Function(Map<String, String>) onAccountSelected;

  const AccountSelectionSheet({
    super.key,
    required this.accounts,
    required this.onAccountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Pilih Rekening", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: accounts.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final account = accounts[index];
              return ListTile(
                title: Text(account['name']!),
                subtitle: Text("No. Rek: ${account['number']!}"),
                onTap: () {
                  onAccountSelected(account);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}