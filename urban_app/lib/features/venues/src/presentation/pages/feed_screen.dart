import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_bloc.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_event.dart';
import 'package:urban_app/features/venues/src/presentation/bloc/venue_state.dart';
import 'package:urban_app/features/venues/src/presentation/widgets/interactive_sphere_view.dart';

/// Экран ленты заведений.
/// Поддерживает два режима отображения: 3D сфера и классический список.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _isSphereMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      body: BlocBuilder<VenueBloc, VenueState>(
        builder: (context, state) {
          if (state is VenueLoading) {
            return const Center(
              child: CircularProgressIndicator(color: UrbanTheme.primaryColor),
            );
          }

          if (state is VenueError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<VenueBloc>().add(const FetchVenuesEvent()),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          if (state is VenueLoaded) {
            final venues = state.filteredVenues;

            if (venues.isEmpty) {
              return const Center(
                child: Text('Ничего не найдено', style: TextStyle(color: Colors.white)),
              );
            }

            return Stack(
              children: [
                // ОСНОВНОЙ КОНТЕНТ (СФЕРА ИЛИ СПИСОК)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _isSphereMode
                      ? InteractiveSphereView(venues: venues)
                      : _buildListView(context, venues),
                ),

                // ПЛАВАЮЩИЙ APPBAR (ПРОЗРАЧНЫЙ)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Urban Sphere', style: UrbanTheme.headingMedium),
                            Text(
                              _isSphereMode ? '3D EXPLORE BETA' : 'CLASSIC LIST',
                              style: UrbanTheme.bodySmall.copyWith(
                                color: UrbanTheme.primaryColor,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildCircleButton(
                              _isSphereMode ? Icons.view_list : Icons.public,
                              () => setState(() => _isSphereMode = !_isSphereMode),
                            ),
                            const SizedBox(width: 12),
                            _buildCircleButton(
                              Icons.refresh,
                              () => context.read<VenueBloc>().add(const FetchVenuesEvent()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: UrbanTheme.surfaceColor.withOpacity(0.7),
          shape: BoxShape.circle,
          border: Border.all(color: UrbanTheme.primaryColor.withOpacity(0.5)),
        ),
        child: Icon(icon, color: UrbanTheme.primaryColor, size: 20),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<EntertainmentVenue> venues) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VenueBloc>().add(const FetchVenuesEvent());
      },
      color: UrbanTheme.primaryColor,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 16),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return _buildFeedItem(venue);
        },
      ),
    );
  }

  Widget _buildFeedItem(EntertainmentVenue venue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: UrbanTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: UrbanTheme.primaryColor.withOpacity(0.2),
              child: Icon(venue.category.icon, color: UrbanTheme.primaryColor, size: 20),
            ),
            title: Text(venue.name, style: UrbanTheme.headingSmall),
            subtitle: Text('${venue.subCategory} • ${venue.tags.price}', style: UrbanTheme.bodySmall),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(venue.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue.description, style: UrbanTheme.bodyMedium, maxLines: 2),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStat(Icons.star, venue.rating.toString()),
                    const SizedBox(width: 16),
                    _buildStat(Icons.timer_outlined, venue.tags.time.first),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Подробнее', style: TextStyle(color: UrbanTheme.primaryColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: UrbanTheme.textMuted),
        const SizedBox(width: 4),
        Text(label, style: UrbanTheme.bodySmall),
      ],
    );
  }
}
