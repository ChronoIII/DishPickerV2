import 'package:go_router/go_router.dart';

import '../../dish/presentation/pages/index.page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, routeState) {
        return const IndexPage();
      },
    ),
    // GoRoute(
    //   path: '/',
    //   builder: (context, routeState) {
    //     return const HomePage();
    //   },
    // ),
    // GoRoute(
    //   path: '/recipe',
    //   builder: (context, routeState) {
    //     return const RecipePage();
    //   },
    // ),
    // GoRoute(
    //   path: '/list',
    //   builder: (context, routeState) {
    //     return const ListPage();
    //   },
    // ),
  ],
);
