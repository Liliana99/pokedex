import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/pages/home_page.dart';
import 'package:flutter_application_1/consts/app_testing_keys_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/modules/pokedex/pages/pokedex_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../home/pages/home_page_test.dart';

// Crear un mock de PokedexCubit y PokedexState

class MockPokedexCubit extends MockCubit<PokedexState>
    implements PokedexCubit {}

class MockPokedexState extends Fake implements PokedexState {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockPokedexState());
  });

  group('PokedexPage Tests', () {
    late MockPokedexCubit mockPokedexCubit;

    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockPokedexCubit = MockPokedexCubit();
      mockNavigatorObserver = MockNavigatorObserver();
      // Stub the cubit to return a specific state when it's used
      when(() => mockPokedexCubit.state).thenReturn(const PokedexState(
        isLoading: false,
        isFiltered: false,
        pokemons: [],
      ));
    });
    testWidgets('PokedexPage builds correctly with initial state',
        (WidgetTester tester) async {
      // Proporcionar el mock cubit al widget bajo prueba
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<PokedexCubit>(
          create: (_) => mockPokedexCubit,
          child: const PokedexPage(),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ));

      // Verificar que el widget principal se construye
      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(PokedexPage), findsOneWidget);
    });

    testWidgets('Scroll interaction calls showAppBar and hideAppBar',
        (WidgetTester tester) async {
      when(mockPokedexCubit.hideAppBar).thenAnswer((_) async {});
      when(() => mockPokedexCubit.showAppBarWithStatus(any())).thenReturn(null);

      // Mocking further interaction
      final ScrollController scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PokedexCubit>(
            create: (_) => mockPokedexCubit,
            child: PokedexContent(mockPokedexCubit, scrollController),
          ),
        ),
      );

      // Verificar que el widget principal se construye
      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(PokedexContent), findsOneWidget);

      //Find scroll widget principal
      final Finder scrollWidget = find.byKey(const Key(Keys.scrollWidget));
      expect(scrollWidget, findsOneWidget);

      // Simular scroll hacia abajo
      await tester.fling(scrollWidget, const Offset(0, -300),
          1000); // Simula un scroll hacia arriba
      await tester.pumpAndSettle();

      // Simular scroll hacia arriba
      await tester.fling(scrollWidget, const Offset(0, 300),
          1000); // Simula un scroll hacia arriba
      await tester.pumpAndSettle();

      // Verificar que los métodos del Cubit se llamen como se espera durante el scroll
      verifyNever(mockPokedexCubit.hideAppBar).called((0));
      verifyNever(() => mockPokedexCubit.showAppBarWithStatus(any()))
          .called((0));
    });
  });
}
