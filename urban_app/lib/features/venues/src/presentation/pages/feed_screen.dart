import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_bloc.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_event.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_state.dart';
// import 'package:urban_app/features/venues/src/presentation/widgets/interactive_sphere_view.dart'; // Временно отключено

/// Экран ленты заведений.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // final bool _isSphereMode = false; // Режим сферы временно отключен

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.getBackgroundColor(context),
      body: BlocBuilder<VenueBloc, VenueState>(
        builder: (context, state) {
          if (state is VenueLoading) {
            return const Center(
              child: CircularProgressIndicator(color: UrbanTheme.primaryColor),
            );
          }

          if (state is VenueLoaded) {
            final venues = state.filteredVenues;

            return Stack(
              children: [
                // Режим сферы временно удален из Stack для оптимизации
                
                // КЛАССИЧЕСКИЙ СПИСОК
                _buildListView(context, venues),

                // ПЛАВАЮЩИЙ ИНТЕРФЕЙС
                _buildOverlayHeader(context),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOverlayHeader(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 20, right: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              UrbanTheme.getBackgroundColor(context),
              UrbanTheme.getBackgroundColor(context).withValues(alpha: 0.0),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Urban Feed', style: UrbanTheme.headingMedium(context)),
                Text(
                  'LATEST PLACES',
                  style: UrbanTheme.bodySmall(context).copyWith(
                    color: UrbanTheme.primaryColor,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Кнопка сферы убрана
                _buildCircleButton(
                  context,
                  Icons.refresh,
                  () => context.read<VenueBloc>().add(const FetchVenuesEvent()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45, height: 45,
        decoration: BoxDecoration(
          color: UrbanTheme.getSurfaceColor(context).withValues(alpha: 0.7),
          shape: BoxShape.circle,
          border: Border.all(color: UrbanTheme.primaryColor.withValues(alpha: 0.5)),
        ),
        child: Icon(icon, color: UrbanTheme.primaryColor, size: 20),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<EntertainmentVenue> venues) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 120, left: 16, right: 16, bottom: 100),
      itemCount: venues.length,
      itemBuilder: (context, index) => _buildFeedItem(context, venues[index]),
    );
  }

  Widget _buildFeedItem(BuildContext context, EntertainmentVenue venue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: UrbanTheme.cardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(venue.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(venue.name, style: UrbanTheme.headingSmall(context)),
                    const Spacer(),
                    const Icon(Icons.star, color: UrbanTheme.warningColor, size: 16),
                    const SizedBox(width: 4),
                    Text(venue.rating.toString(), style: UrbanTheme.bodyMedium(context)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(venue.description, style: UrbanTheme.bodySmall(context), maxLines: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
