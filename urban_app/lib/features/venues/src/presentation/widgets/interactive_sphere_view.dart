import 'package:flutter/material.dart';

/// ВРЕМЕННО ОТКЛЮЧЕНО: Модуль интерактивной сферы.
/// Код закомментирован для будущей доработки.
class InteractiveSphereView extends StatelessWidget {
  final List<dynamic> venues;
  final bool isActive;

  const InteractiveSphereView({
    super.key,
    required this.venues,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/*
// ВЕСЬ ПРЕДЫДУЩИЙ КОД ЗАКОММЕНТИРОВАН НИЖЕ ДЛЯ СОХРАНЕНИЯ ЛОГИКИ

import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';

... (весь старый код здесь)
*/
