import 'package:brimo_clone/presentation/pages/pdam_region_page.dart';
import 'package:flutter/material.dart';

class PdamPage extends StatelessWidget {
  final String userId;
  const PdamPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Halaman ini sekarang hanya bertugas sebagai jembatan
    // ke halaman pemilihan wilayah PDAM.
    return PdamRegionPage(userId: userId);
  }
}