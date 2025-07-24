import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/services/dependency_injection.dart';
import 'package:ecommerce_app/src/address/domain/entities/address.dart';
import 'package:ecommerce_app/src/address/presentation/screens/address_screen.dart';
import 'package:ecommerce_app/src/address/presentation/screens/adress_form_screen.dart';
import 'package:ecommerce_app/src/cart/presentation/screen/cart_screen.dart';
import 'package:ecommerce_app/src/checkout/presentation/checkout_screen.dart';
import 'package:ecommerce_app/src/dashboard/presentation/view/dashboard.dart';
import 'package:ecommerce_app/src/favourite/presentation/screens/favourite_screen.dart';
import 'package:ecommerce_app/src/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/home/presentation/views/home_view.dart';
import 'package:ecommerce_app/src/order/presentation/screens/order_screen.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:ecommerce_app/src/payment/presentation/screens/payment_screen.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_app/src/product/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      path: RoutePath.favourite,
      name: RouteName.favourite,
      builder: (context, state) {
        return const FavouriteScreen();
      },
    ),
    GoRoute(
      path: RoutePath.cart,
      name: RouteName.cart,
      builder: (context, state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      path: RoutePath.checkout,
      name: RouteName.checkout,
      builder: (context, state) => ChangeNotifierProvider.value(
        value: sl<PaymentProvider>(),
        child: const CheckoutScreen(),
      ),
    ),
    GoRoute(
      path: RoutePath.address,
      name: RouteName.address,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: RoutePath.addressCreate,
      name: RouteName.addressCreate,
      builder: (context, state) => const AddressFormScreen(),
    ),
    GoRoute(
      path: RoutePath.addressEdit,
      name: RouteName.addressEdit,
      builder: (context, state) {
        final address = state.extra! as Address;
        return AddressFormScreen(existingAddress: address);
      },
    ),
    GoRoute(
      path: RoutePath.confirmOrder,
      name: RouteName.confirmOrder,
      builder: (context, state) {
        return ChangeNotifierProvider.value(
          value: sl<PaymentProvider>(),
          child: const OrderSuccessScreen(orderId: '4389321',),
        );
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
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.cartView,
              name: RouteName.cartView,
              builder: (context, state) {
                return const CartScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.message,
              name: RouteName.message,
              builder: (context, state) {
                return const Placeholder();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
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
