// Impor semua halaman fitur
import 'package:brimo_clone/presentation/pages/briva_page.dart';
import 'package:brimo_clone/presentation/pages/cicilan_page.dart';
import 'package:brimo_clone/presentation/pages/dana_page.dart';
import 'package:brimo_clone/presentation/pages/donasi_page.dart';
import 'package:brimo_clone/presentation/pages/event_page.dart';
import 'package:brimo_clone/presentation/pages/gopay_page.dart';
import 'package:brimo_clone/presentation/pages/investasi_page.dart';
import 'package:brimo_clone/presentation/pages/kartu_kredit_page.dart';
import 'package:brimo_clone/presentation/pages/lifestyle_page.dart';
import 'package:brimo_clone/presentation/pages/movie_main_page.dart';
import 'package:brimo_clone/presentation/pages/notifikasi_page.dart';
import 'package:brimo_clone/presentation/pages/ovo_page.dart';
import 'package:brimo_clone/presentation/pages/paket_data_page.dart';
import 'package:brimo_clone/presentation/pages/pdam_page.dart';
import 'package:brimo_clone/presentation/pages/pln_page.dart';
import 'package:brimo_clone/presentation/pages/pulsa_data_page.dart';
import 'package:brimo_clone/presentation/pages/pusat_bantuan_page.dart';
import 'package:brimo_clone/presentation/pages/semua_rekening_page.dart';
import 'package:brimo_clone/presentation/pages/shopeepay_page.dart';
import 'package:brimo_clone/presentation/pages/tabungan_page.dart';
import 'package:brimo_clone/presentation/pages/tiket_kai_page.dart';
import 'package:brimo_clone/presentation/pages/transfer_page.dart';
import 'package:brimo_clone/presentation/pages/voucher_page.dart';

// Impor service dan widget lain
import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:brimo_clone/presentation/widgets/promo_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isBalanceVisible = false;

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) {
      return 'Selamat Pagi';
    } else if (hour >= 11 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    }
    return 'Selamat Malam';
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _navigateToFromSheet(Widget page) {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _showAllMenus() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
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
                  const Text("Semua Fitur",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      controller: scrollController,
                      crossAxisCount: 4,
                      padding: const EdgeInsets.all(16),
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 16,
                      children: _buildAllMenuItems(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildAllMenuItems() {
    return [
      _menuItem(Icons.swap_horiz, "Transfer",
              () => _navigateToFromSheet(TransferPage(userId: widget.userId))),
      _menuItem(Icons.receipt, "BRIVA",
              () => _navigateToFromSheet(BrivaPage(userId: widget.userId))),
      _menuItem(Icons.phone_iphone, "Pulsa",
              () => _navigateToFromSheet(PulsaDataPage(userId: widget.userId))),
      _menuItem(Icons.electric_bolt, "PLN",
              () => _navigateToFromSheet(PlnPage(userId: widget.userId))),
      _menuItem(Icons.wifi, "Paket Data",
              () => _navigateToFromSheet(PaketDataPage(userId: widget.userId))),
      _menuItem(Icons.water_drop, "PDAM",
              () => _navigateToFromSheet(PdamPage(userId: widget.userId))),
      _menuItem(Icons.movie, "Bioskop",
              () => _navigateToFromSheet(MovieMainPage(userId: widget.userId))),
      _menuItem(
          Icons.train, "Tiket KAI", () => _navigateToFromSheet(TiketKaiPage(userId: widget.userId))),
      _menuItem(
          Icons.local_mall, "Voucher", () => _navigateToFromSheet(VoucherPage(userId: widget.userId))),
      _menuItem(Icons.event, "Event", () => _navigateToFromSheet(EventPage(userId: widget.userId))),
      _menuItem(Icons.payment, "GoPay",
              () => _navigateToFromSheet(GopayPage(userId: widget.userId))),
      _menuItem(Icons.paid, "OVO",
              () => _navigateToFromSheet(OvoPage(userId: widget.userId))),
      _menuItem(Icons.add_card, "DANA",
              () => _navigateToFromSheet(DanaPage(userId: widget.userId))),
      _menuItem(Icons.shopping_cart, "ShopeePay",
              () => _navigateToFromSheet(ShopeepayPage(userId: widget.userId))),
      _menuItem(
          Icons.savings, "Tabungan", () => _navigateToFromSheet(TabunganPage(userId: widget.userId))),
      _menuItem(
          Icons.credit_score, "Cicilan", () => _navigateToFromSheet(CicilanPage(userId: widget.userId))),
      _menuItem(Icons.card_giftcard, "Kartu Kredit",
              () => _navigateToFromSheet(KartuKreditPage(userId: widget.userId))),
      _menuItem(Icons.real_estate_agent, "Investasi",
              () => _navigateToFromSheet(const InvestasiPage())),
      _menuItem(Icons.volunteer_activism, "Donasi",
              () => _navigateToFromSheet(DonasiPage(userId: widget.userId))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestoreService.getUserStream(widget.userId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(getGreeting(),
                  style: const TextStyle(color: Colors.black));
            }
            final userName =
                (snapshot.data!.data() as Map<String, dynamic>)['name'] ??
                    'Pengguna';
            return Text("${getGreeting()}, $userName",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold));
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                _navigateTo(const NotifikasiPage());
              },
              icon: const Icon(Icons.notifications_none, color: Colors.black)),
          IconButton(
              onPressed: () {
                _navigateTo(const PusatBantuanPage());
              },
              icon: const Icon(Icons.help_outline, color: Colors.black)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSaldoCard(currencyFormatter),
            const SizedBox(height: 16),
            const PromoSlider(),
            const SizedBox(height: 16),
            _buildMainMenu(),
            const SizedBox(height: 16),
            _buildSection(
                title: "Isi Ulang & Tagihan",
                icon: Icons.add_card,
                color: Colors.blue,
                items: [
                  _menuItem(Icons.phone_iphone, "Pulsa",
                          () => _navigateTo(PulsaDataPage(userId: widget.userId))),
                  _menuItem(Icons.wifi, "Paket Data",
                          () => _navigateTo(PaketDataPage(userId: widget.userId))),
                  _menuItem(Icons.electric_bolt, "PLN",
                          () => _navigateTo(PlnPage(userId: widget.userId))),
                  _menuItem(Icons.water_drop, "PDAM",
                          () => _navigateTo(PdamPage(userId: widget.userId))),
                ]),
            const SizedBox(height: 16),
            _buildSection(
                title: "Gaya Hidup",
                icon: Icons.shopping_bag,
                color: Colors.pink,
                items: [
                  _menuItem(Icons.movie, "Bioskop",
                          () => _navigateTo(MovieMainPage(userId: widget.userId))),
                  _menuItem(Icons.train, "Tiket KAI",
                          () => _navigateTo(TiketKaiPage(userId: widget.userId))),
                  _menuItem(Icons.local_mall, "Voucher",
                          () => _navigateTo(VoucherPage(userId: widget.userId))),
                  _menuItem(
                      Icons.event, "Event", () => _navigateTo(EventPage(userId: widget.userId))),
                ]),
            const SizedBox(height: 16),
            _buildSection(
                title: "Dompet Digital",
                icon: Icons.account_balance_wallet,
                color: Colors.purple,
                items: [
                  _menuItem(Icons.payment, "GoPay",
                          () => _navigateTo(GopayPage(userId: widget.userId))),
                  _menuItem(Icons.paid, "OVO",
                          () => _navigateTo(OvoPage(userId: widget.userId))),
                  _menuItem(Icons.add_card, "DANA",
                          () => _navigateTo(DanaPage(userId: widget.userId))),
                  _menuItem(Icons.shopping_cart, "ShopeePay",
                          () => _navigateTo(ShopeepayPage(userId: widget.userId))),
                ]),
            const SizedBox(height: 16),
            _buildSection(
                title: "Keuangan",
                icon: Icons.bar_chart,
                color: Colors.orange,
                items: [
                  _menuItem(Icons.savings, "Tabungan",
                          () => _navigateTo(TabunganPage(userId: widget.userId))),
                  _menuItem(Icons.credit_score, "Cicilan",
                          () => _navigateTo(CicilanPage(userId: widget.userId))),
                  _menuItem(Icons.card_giftcard, "Kartu Kredit",
                          () => _navigateTo(KartuKreditPage(userId: widget.userId))),
                  _menuItem(Icons.volunteer_activism, "Donasi",
                          () => _navigateTo(DonasiPage(userId: widget.userId))),
                ]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _menuItem(Icons.swap_horiz, "Transfer",
                    () => _navigateTo(TransferPage(userId: widget.userId))),
            _menuItem(Icons.receipt, "BRIVA",
                    () => _navigateTo(BrivaPage(userId: widget.userId))),
            _menuItem(Icons.shopping_bag, "Lifestyle",
                    () => _navigateTo(LifestylePage(userId: widget.userId))),
            _menuItem(Icons.more_horiz, "Lainnya", _showAllMenus),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: const Color(0xFF00529B), size: 30),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSaldoCard(NumberFormat currencyFormatter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF00529B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Saldo Rekening Utama",
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            StreamBuilder<DocumentSnapshot>(
              stream: _firestoreService.getUserStream(widget.userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const CircularProgressIndicator(color: Colors.white);
                final balance =
                    (snapshot.data!.data() as Map<String, dynamic>)['balance'] ??
                        0;
                return Row(
                  children: [
                    Text(
                      _isBalanceVisible
                          ? currencyFormatter.format(balance)
                          : 'Rp ••••••••',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () =>
                          setState(() => _isBalanceVisible = !_isBalanceVisible),
                      child: Icon(
                          _isBalanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SemuaRekeningPage(userId: widget.userId)));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Semua Rekeningmu", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title,
        required IconData icon,
        required Color color,
        required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            )
          ],
        ),
      ),
    );
  }
}