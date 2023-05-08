import 'package:dishv3/dish/presentation/pages/home.page.dart';
import 'package:dishv3/dish/presentation/pages/list.page.dart';
import 'package:dishv3/dish/presentation/pages/recipe.page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, routeState) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/recipe',
      builder: (context, routeState) {
        return const RecipePage();
      },
    ),
    GoRoute(
      path: '/list',
      builder: (context, routeState) {
        return const ListPage();
      },
    ),
  ],
);
