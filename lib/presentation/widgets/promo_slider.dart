import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  // Controller untuk PageView
  final _pageController = PageController();
  Timer? _timer;

  // Pastikan Anda memiliki gambar-gambar ini di folder assets/images/
  final List<String> imgList = [
    'assets/images/promo1.png',
    'assets/images/promo2.png',
    'assets/images/promo3.png',
    'assets/images/promo4.png',
    'assets/images/promo5.png',
  ];

  @override
  void initState() {
    super.initState();
    // Atur timer untuk auto-play
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == imgList.length - 1) {
        _pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      } else {
        _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer saat widget dihancurkan
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Carousel Slider menggunakan PageView
        SizedBox(
          height: 180, // Beri tinggi yang tetap untuk slider
          child: PageView.builder(
            controller: _pageController,
            itemCount: imgList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(imgList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // 2. Indikator Titik (Dots)
        SmoothPageIndicator(
          controller: _pageController,
          count: imgList.length,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Theme.of(context).primaryColor,
            dotColor: Colors.grey.shade300,
          ),
          onDotClicked: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ],
    );
  }
}