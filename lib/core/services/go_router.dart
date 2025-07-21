import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/services/dependency_injection.dart';
import 'package:ecommerce_app/src/cart/presentation/screen/cart_screen.dart';
import 'package:ecommerce_app/src/dashboard/presentation/view/dashboard.dart';
import 'package:ecommerce_app/src/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/home/presentation/views/home_view.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_app/src/product/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RoutePath.initial,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RoutePath.initial,
      name: RouteName.initial,
      redirect: (context, state) {
        if (state.fullPath == RoutePath.home) return null;
        return RoutePath.home;
      },
    ),
    GoRoute(
      path: RoutePath.product,
      name: RouteName.product,
      builder: (context, state) {
        final product = state.extra! as Product;
        return ProductDetailScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: RoutePath.cart,
      name: RouteName.cart,
      builder: (context, state) {
        return const CartScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return Dashboard(shell: shell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.home,
              name: RouteName.home,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => sl<HomeBloc>(),
                  child: const HomeView(),
                );
              },
            ),
            GoRoute(
              path: RoutePath.address,
              name: RouteName.address,
              builder: (context, state) {
                return const Placeholder();
              },
            ),
            GoRoute(
              path: RoutePath.profile,
              name: RouteName.profile,
              builder: (context, state) {
                return const Placeholder();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
