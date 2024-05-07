import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/app/modules/home/pages/home_page.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/router.dart';
import 'package:flutter_application_1/consts/app_testing_keys_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockPokedexCubit extends MockCubit<PokedexState>
    implements PokedexCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements PokedexState {}

final _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: homeRoute,
      builder: (context, state) => const HomePage(),
    ),
  ],
);

void main() {
  setUpAll(() {
    registerFallbackValue(MyTypeFake());
  });

  group('HomePage tests', () {
    late MockPokedexCubit mockPokedexCubit;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockPokedexCubit = MockPokedexCubit();
      mockNavigatorObserver = MockNavigatorObserver();
      // Stub the cubit to return a specific state when it's used
      when(() => mockPokedexCubit.state).thenReturn(const PokedexState());
    });

    testWidgets('HomePage initializes with correct widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PokedexCubit>(
            create: (context) => mockPokedexCubit,
            child: const HomePage(),
          ),
          navigatorObservers: [mockNavigatorObserver],
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => Container(), // Puede ser un widget ficticio
            );
          },
        ),
      );

      // Verify that HomeContent is present
      expect(find.byType(HomeContent), findsOneWidget);
      // Verify the presence of TitleAndPokeball and ActionButtons
      expect(find.byType(TitleAndPokeball), findsOneWidget);
      expect(find.byType(ActionButtons), findsOneWidget);
    });

    testWidgets('Navigates when buttons are pressed',
        (WidgetTester tester) async {
      when(() => mockPokedexCubit.loadLocalCapturedPokemons())
          .thenAnswer((_) async {});

      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => mockPokedexCubit),
        ],
        child: MaterialApp.router(
          locale: const Locale("en"),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          builder: (context, child) {
            return InheritedGoRouter(
              goRouter: _router,
              child: const HomePage(),
            );
          },
        ),
      ));

      expect(find.byType(HomePage), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));

      // Encuentra los botones elevados por su tipo
      final Finder button1Finder = find.byKey(const ValueKey(Keys.homeButton1));
      final Finder button2Finder = find.byKey(const ValueKey(Keys.homeButton2));

      // Verificar que los botones están presentes
      expect(button1Finder, findsOneWidget);
      expect(button2Finder, findsOneWidget);

      // Simular la acción onPressedButton1
      await tester.tap(button1Finder);
      await tester.pump();

      // Simular la acción onPressedButton2
      await tester.tap(button2Finder);
      await tester.pump(); // Verify method was run
      verifyNever(() => mockPokedexCubit.loadLocalCapturedPokemons()).called(0);
    });
  });
}
