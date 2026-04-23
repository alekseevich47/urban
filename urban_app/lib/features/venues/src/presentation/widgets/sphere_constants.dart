import 'package:flutter/material.dart';

/// Константы для настройки 2.5D сферы
class SphereConstants {
  static const double kMinPostScale = 0.65; // Минимальный размер
  static const double kMaxPostScale = 1.35; // Максимальный размер
  static const double kSensitivity = 0.004; // Чувствительность вращения
  static const double kInertiaFriction = 0.96; // Замедление инерции
  static const double kAutoDriftSpeed = 0.001; // Скорость автоматического дрейфа
  
  static double getRadius(BuildContext context) => MediaQuery.sizeOf(context).width * 1.9;
  static double getFocal(double radius) => radius * 0.85;
}

/// Состояние вращения сферы
class SphereRotation {
  final double yaw;   // Вращение вокруг оси Y (горизонтально)
  final double pitch; // Вращение вокруг оси X (вертикально)

  const SphereRotation(this.yaw, this.pitch);

  SphereRotation operator +(SphereRotation other) => 
      SphereRotation(yaw + other.yaw, pitch + other.pitch);

  SphereRotation operator *(double factor) => 
      SphereRotation(yaw * factor, pitch * pitch * factor);
}
