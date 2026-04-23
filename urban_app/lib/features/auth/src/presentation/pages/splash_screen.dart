import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// Экран загрузки Urban с Lottie анимацией (обрезанной до 1.5 сек).
class UrbanSplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const UrbanSplashScreen({super.key, required this.onComplete});

  @override
  State<UrbanSplashScreen> createState() => _UrbanSplashScreenState();
}

class _UrbanSplashScreenState extends State<UrbanSplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/start_ss.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            
            // 1. Убираем нативный сплэш, так как Flutter-анимация готова к показу
            FlutterNativeSplash.remove();

            // 2. Запускаем анимацию
            _controller.forward();

            // 3. Ровно через 1.5 секунды завершаем сплэш
            _timer = Timer(const Duration(milliseconds: 1500), () {
              widget.onComplete();
            });
          },
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
