import 'package:flutter_test/flutter_test.dart';
import 'package:urban_app/main.dart';
import 'package:urban_app/core/di/injection.dart';
import 'package:urban_app/features/venues/venues.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:urban_app/features/venues/src/domain/use_cases/get_venues_use_case.dart';

class MockGetVenuesUseCase extends Mock implements GetVenuesUseCase {}

void main() {
  setUpAll(() {
    final mockUseCase = MockGetVenuesUseCase();
    when(() => mockUseCase.call()).thenAnswer((_) async => []);
    getIt.registerSingleton<GetVenuesUseCase>(mockUseCase);
  });

  testWidgets('Smoke test: Render MainApp', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => VenueBloc(getVenuesUseCase: getIt<GetVenuesUseCase>()),
        child: const MainApp(),
      ),
    );

    expect(find.byType(MainApp), findsOneWidget);
  });
}
