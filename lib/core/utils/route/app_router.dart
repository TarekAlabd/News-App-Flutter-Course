import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/home/views/pages/article_details_page.dart';
import 'package:news_app/features/home/views/pages/home_page.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';
import 'package:news_app/features/search/views/pages/search_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return CupertinoPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case AppRoutes.search:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SearchCubit(),
            child: const SearchPage(),
          ),
          settings: settings,
        );
      case AppRoutes.articleDetails:
        final article = settings.arguments as Article;
        return CupertinoPageRoute(
          builder: (_) => ArticleDetailsPage(
            article: article,
          ),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
