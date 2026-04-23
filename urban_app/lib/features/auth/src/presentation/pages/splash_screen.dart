import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:urban_app/core/ui/urban_theme.dart';

class UrbanSplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const UrbanSplashScreen({super.key, required this.onComplete});

  @override
  State<UrbanSplashScreen> createState() => _UrbanSplashScreenState();
}

class _UrbanSplashScreenState extends State<UrbanSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Переход на главный экран через 4 секунды (или после загрузки данных)
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED), // Цвет бумаги из изображения
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              // 1. ФОНОВОЕ ИЗОБРАЖЕНИЕ (Оригинал)
              // ВНИМАНИЕ: Предполагается, что вы добавили это изображение в assets
              Opacity(
                opacity: 1.0,
                child: Image.network(
                  'https://storage.googleapis.com/flutter-studio-user-uploads-production/73292415-373b-483d-9d7a-18e3845a7df4.png',
                  fit: BoxFit.contain,
                ),
              ),

              // 2. СЛОЙ АНИМАЦИИ (Custom Painter)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _UrbanSplashPainter(
                        progress: _controller.value,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UrbanSplashPainter extends CustomPainter {
  final double progress;
  _UrbanSplashPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Координаты букв (нормализованные 0..1 для адаптивности под 16:9)
    // Эти значения подобраны под предоставленное изображение
    
    // --- БУКВА "U" (Колесо обозрения) ---
    _drawFerrisWheel(canvas, size, const Offset(0.165, 0.55), 0.08);

    // --- БУКВА "R" (Машины) ---
    _drawTraffic(canvas, size, const Offset(0.34, 0.52));

    // --- БУКВА "B" (Дерево) ---
    _drawSwayingTree(canvas, size, const Offset(0.495, 0.45));

    // --- БУКВА "A" (Геолокация) ---
    _drawPulsingPin(canvas, size, const Offset(0.665, 0.45));

    // --- БУКВА "N" (Свет в окнах) ---
    _drawBlinkingLights(canvas, size, const Offset(0.88, 0.45));
  }

  void _drawFerrisWheel(Canvas canvas, Size size, Offset centerRel, double radiusRel) {
    final center = Offset(size.width * centerRel.dx, size.height * centerRel.dy);
    final radius = size.width * radiusRel;
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1) // Очень бледный набросок поверх
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(progress * 2 * math.pi); // Вращение

    // Рисуем спицы (легкие штрихи)
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * math.pi / 180;
      canvas.drawLine(
        Offset.zero,
        Offset(math.cos(angle) * radius, math.sin(angle) * radius),
        paint,
      );
      // Кабинки (маленькие кружочки)
      canvas.drawCircle(Offset(math.cos(angle) * radius, math.sin(angle) * radius), 2, paint);
    }
    canvas.restore();
  }

  void _drawTraffic(Canvas canvas, Size size, Offset centerRel) {
    final start = Offset(size.width * 0.34, size.height * 0.48);
    final end = Offset(size.width * 0.34, size.height * 0.72);
    final carPaint = Paint()..color = Colors.black.withValues(alpha: 0.2);

    for (int i = 0; i < 3; i++) {
      double t = (progress * 2 + i / 3) % 1.0;
      // Движение по перспективе (вниз и чуть в стороны)
      double y = start.dy + (end.dy - start.dy) * t;
      double xOffset = (t - 0.5) * 20; // Небольшое отклонение
      
      canvas.drawRect(
        Rect.fromCenter(center: Offset(start.dx + xOffset, y), width: 6 * t, height: 4 * t),
        carPaint,
      );
    }
  }

  void _drawSwayingTree(Canvas canvas, Size size, Offset centerRel) {
    // Эффект колыхания кроны через легкое смещение
    final center = Offset(size.width * centerRel.dx, size.height * centerRel.dy);
    final sway = math.sin(progress * 4 * math.pi) * 2.0;
    
    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(center.translate(sway, -5), 35, paint);
  }

  void _drawPulsingPin(Canvas canvas, Size size, Offset centerRel) {
    final center = Offset(size.width * centerRel.dx, size.height * centerRel.dy);
    // Пульсация: вверх-вниз + масштаб
    final bounce = math.sin(progress * 6 * math.pi) * 5.0;
    
    final paint = Paint()
      ..color = UrbanTheme.primaryColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center.translate(0, -bounce), 8, paint);
  }

  void _drawBlinkingLights(Canvas canvas, Size size, Offset centerRel) {
    final startX = size.width * 0.85;
    final startY = size.height * 0.32;
    final lightPaint = Paint()..color = const Color(0xFFFFEB3B).withValues(alpha: 0.6);

    final math.Random random = math.Random(42); // Детерминированный рандом для стабильности

    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 2; col++) {
        // Рандомное мигание каждого окна
        if (math.sin(progress * 10 * math.pi + random.nextDouble() * 10) > 0.5) {
          canvas.drawRect(
            Rect.fromLTWH(startX + col * 12, startY + row * 18, 8, 10),
            lightPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _UrbanSplashPainter oldDelegate) => true;
}
