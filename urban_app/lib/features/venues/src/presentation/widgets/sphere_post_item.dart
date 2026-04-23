import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';
import 'package:urban_app/core/ui/urban_theme.dart';

/// Виджет элемента поста на сфере.
/// Поддерживает текст, изображения и видео.
class SpherePostItem extends StatefulWidget {
  final EntertainmentVenue venue;
  final double scale;
  final VoidCallback onTap;

  const SpherePostItem({
    super.key,
    required this.venue,
    required this.scale,
    required this.onTap,
  });

  @override
  State<SpherePostItem> createState() => _SpherePostItemState();
}

class _SpherePostItemState extends State<SpherePostItem> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Инициализируем видео, если оно есть (заглушка для примера, 
    // в реальности проверяем URL или тип контента)
    if (widget.venue.name.contains('Video') || widget.venue.id.hashCode % 3 == 0) {
      _initVideo();
    }
  }

  void _initVideo() {
    // Временно используем тестовое видео для демонстрации
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
        setState(() => _isVideoInitialized = true);
        _videoController!.setLooping(true);
        _videoController!.setVolume(0); // Без звука в превью
      });
  }

  @override
  void didUpdateWidget(SpherePostItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Управление видео по масштабу (видимости)
    if (_videoController != null && _isVideoInitialized) {
      if (widget.scale < 0.25 && _videoController!.value.isPlaying) {
        _videoController!.pause();
      } else if (widget.scale >= 0.25 && !_videoController!.value.isPlaying) {
        _videoController!.play();
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: RepaintBoundary(
        child: Container(
          width: 200,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: UrbanTheme.primaryColor.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Фон (Изображение или Видео)
              _buildMediaBackground(),
              
              // Градиент для текста
              _buildTextOverlay(context),
              
              // Категория (Badge)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: UrbanTheme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.venue.category.label.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaBackground() {
    if (_videoController != null && _isVideoInitialized && widget.scale > 0.3) {
      return VideoPlayer(_videoController!);
    }
    
    return CachedNetworkImage(
      imageUrl: widget.venue.imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.grey[900]),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildTextOverlay(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.5),
            Colors.black.withValues(alpha: 0.9),
          ],
          stops: const [0.5, 0.7, 1.0],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.venue.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: UrbanTheme.warningColor, size: 12),
              const SizedBox(width: 4),
              Text(
                widget.venue.rating.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const Spacer(),
              Text(
                '${(widget.venue.rating * 100).toInt()} views',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
