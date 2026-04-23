import 'dart:math';
import 'package:flutter/material.dart';
import 'sphere_constants.dart';

/// Делегат для расчета 2.5D проекции постов на сфере.
/// Выполняет позиционирование и расчет масштаба.
class SphereProjectionDelegate extends MultiChildLayoutDelegate {
  final List<String> ids;
  final SphereRotation rotation;
  final Size viewportSize;
  final Map<String, double> popularity; // Нормализованная популярность [0..1]

  SphereProjectionDelegate({
    required this.ids,
    required this.rotation,
    required this.viewportSize,
    required this.popularity,
  });

  @override
  void performLayout(Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = SphereConstants.getRadius(null as dynamic ?? Size(size.width, size.height)); // Упрощенно
    final actualRadius = size.width * 1.9;
    final focal = actualRadius * 0.85;

    // Распределяем посты равномерно по сфере (используя алгоритм Фибоначчи для сфер)
    final double phiStep = pi * (3 - sqrt(5)); // Золотой угол

    for (int i = 0; i < ids.idCount; i++) {
       // Этот метод вызывается в цикле, но расчеты координат вынесем в основной виджет
       // для оптимизации Z-сортировки. Здесь только layout.
    }
  }

  // Вспомогательный метод для расчета экранных координат
  static SphereProjectionResult project({
    required double theta0, // Начальный угол долготы
    required double phi0,   // Начальный угол широты
    required double yaw,    // Текущий поворот по Y
    required double pitch,  // Текущий поворот по X
    required double R,      // Радиус
    required double focal,  // Фокусное расстояние
    required double popFactor, // Популярность [0..1]
  }) {
    final theta = theta0 + yaw;
    final phi = phi0 + pitch;

    // Сферические координаты в декартовы
    final x = R * sin(phi) * sin(theta);
    final y = R * cos(phi);
    final z = R * sin(phi) * cos(theta);

    // Перспективная проекция
    final scaleBase = focal / (focal + z);
    
    // Логарифмическая нормализация размера (популярность)
    // scale = scaleBase * (min + (max-min) * log(1+pop)/log(2))
    final double popScale = SphereConstants.kMinPostScale + 
        (SphereConstants.kMaxPostScale - SphereConstants.kMinPostScale) * 
        (log(1 + popFactor) / log(2));
        
    final finalScale = scaleBase * popScale;

    return SphereProjectionResult(
      screenX: x * scaleBase,
      screenY: y * scaleBase,
      scale: finalScale,
      z: z,
      isVisible: scaleBase > 0.2,
    );
  }

  @override
  bool shouldRelayout(covariant SphereProjectionDelegate oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.ids != ids;
  }
}

class SphereProjectionResult {
  final double screenX;
  final double screenY;
  final double scale;
  final double z;
  final bool isVisible;

  SphereProjectionResult({
    required this.screenX,
    required this.screenY,
    required this.scale,
    required this.z,
    required this.isVisible,
  });
}

extension on List {
  int get idCount => length;
}
