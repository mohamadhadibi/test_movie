import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_movie/features/movie/data/models/route_arguments.dart';
import 'package:test_movie/features/movie/presentation/pages/favorites/movie_favorites_page.dart';
import 'package:test_movie/features/movie/presentation/pages/info/movie_info_page.dart';
import 'package:test_movie/features/movie/presentation/pages/list/movie_list_page.dart';
import 'package:test_movie/injection_container.dart';

import 'resources/routs.dart';
import 'application_cubit.dart';
import 'resources/app_colors.dart';
import 'resources/theme_dark.dart';
import 'resources/theme_light.dart';
import '/generated/i18n.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _Application();
}

class _Application extends State<Application> {
  final ApplicationCubit _cubit = get<ApplicationCubit>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return BlocProvider(
      create: (context) => _cubit..getApplicationUiData(),
      child: BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale('en'),
            title: 'Test Movie',
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(null),
            darkTheme: getDarkTheme(null),
            themeMode: state.themeMode,
            //scrollBehavior: CustomScrollBehavior(),
            home: const MovieListPage(),
            onGenerateRoute: (RouteSettings settings) {
              final arguments = settings.arguments;
              switch (settings.name) {
                case routeMovieList:
                  return MaterialPageRoute(
                    builder: (BuildContext context) => const MovieListPage(),
                  );
                case routeFavorites:
                  return MaterialPageRoute(
                    builder: (BuildContext context) => const MovieFavoritesPage(),
                  );
                case routeMovieInfo:
                  if (arguments is MovieInfoPageArguments) {
                    return MaterialPageRoute(
                      builder: (BuildContext context) => MovieInfoPage(
                        params: arguments,
                      ),
                    );
                  } else {
                    return _getDefault(context);
                  }
                default:
                  return _getDefault(context);
              }
            },
            onUnknownRoute: (RouteSettings settings) {
              return _getDefault(context);
            },
          );
        },
      ),
    );
  }

  MaterialPageRoute _getDefault(BuildContext context) {
    return MaterialPageRoute(
      builder: (BuildContext context) => const MovieListPage(),
    );
  }
}
