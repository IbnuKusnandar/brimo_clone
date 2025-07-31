import 'package:flutter/material.dart';

class ChatDokterPage extends StatefulWidget {
  final String doctorName;
  const ChatDokterPage({super.key, required this.doctorName});

  @override
  State<ChatDokterPage> createState() => _ChatDokterPageState();
}

class _ChatDokterPageState extends State<ChatDokterPage> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<Map<String, String>> _messages;

  // --- LOGIKA BARU UNTUK CHATBOT BERBEDA ---
  int _botResponseStep = 0;

  // Peta respons untuk setiap dokter
  final Map<String, List<String>> _doctorResponses = {
    'Dr. Budi Santoso': [ // Dokter Umum
      'Baik, saya akan coba analisis keluhan Anda.',
      'Sudah berapa lama gejala ini Anda rasakan?',
      'Terima kasih informasinya. Saya sarankan Anda untuk memperbanyak istirahat dan minum air putih. Jika tidak membaik dalam 3 hari, harap kunjungi dokter terdekat.',
    ],
    'Dr. Siti Aminah': [ // Dokter Anak
      'Tentu, saya akan bantu. Bisa ceritakan keluhan yang dialami oleh si kecil?',
      'Apakah ada demam atau batuk yang menyertai?',
      'Baik, Bunda. Untuk sementara, pastikan si kecil cukup istirahat dan cairan. Saya akan resepkan vitamin penambah daya tahan tubuh.',
    ],
    'Dr. Agus Wijaya': [ // Penyakit Dalam
      'Baik, saya akan periksa keluhan Anda.',
      'Apakah Anda memiliki riwayat penyakit tertentu sebelumnya, seperti diabetes atau hipertensi?',
      'Mengerti. Berdasarkan gejala Anda, saya sarankan untuk melakukan pemeriksaan lebih lanjut di laboratorium. Saya akan berikan surat pengantarnya.',
    ],
    // Default response jika dokter tidak ada di daftar
    'default': [
      'Baik, saya akan periksa keluhan Anda.',
      'Bisa ceritakan lebih detail?',
      'Terima kasih atas informasinya. Harap jaga kesehatan Anda.',
    ]
  };

  @override
  void initState() {
    super.initState();
    // Pesan pembuka yang berbeda untuk setiap dokter
    String openingMessage = 'Selamat datang! Saya ${widget.doctorName}, ada yang bisa saya bantu?';
    _messages = [
      {'sender': 'doctor', 'text': openingMessage},
    ];
  }


  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': _messageController.text});
        _messageController.clear();
      });
      _triggerBotResponse();
    }
  }

  void _triggerBotResponse() {
    // Dapatkan rangkaian respons yang sesuai dengan dokter
    final responses = _doctorResponses[widget.doctorName] ?? _doctorResponses['default']!;

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted && _botResponseStep < responses.length) {
        setState(() {
          _messages.add({'sender': 'doctor', 'text': responses[_botResponseStep]});
          _botResponseStep++;
        });
        _scrollToBottom();
      } else if (mounted) {
        setState(() {
          _messages.add({'sender': 'doctor', 'text': 'Terima kasih telah berkonsultasi. Semoga lekas sembuh!'});
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctorName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Theme.of(context).primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}