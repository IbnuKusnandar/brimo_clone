import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class QrisScannerPage extends StatefulWidget {
  const QrisScannerPage({super.key});

  @override
  State<QrisScannerPage> createState() => _QrisScannerPageState();
}

class _QrisScannerPageState extends State<QrisScannerPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 1. Minta Izin Kamera
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) Navigator.pop(context);
        return;
      }
    }

    // 2. Dapatkan daftar kamera yang tersedia
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      if (mounted) Navigator.pop(context);
      return;
    }
    final firstCamera = cameras.first;

    // 3. Inisialisasi controller kamera
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bayar dengan QRIS"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika kamera siap, tampilkan preview
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CameraPreview(_controller!),
                ),
                _buildScannerOverlay(),
              ],
            );
          } else {
            // Jika belum siap, tampilkan loading
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Arahkan kamera ke kode QR",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}