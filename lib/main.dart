import 'package:ecommerce_app/core/app/themes/app_theme.dart';
import 'package:ecommerce_app/core/services/dependency_injection.dart';
import 'package:ecommerce_app/core/services/go_router.dart';
import 'package:ecommerce_app/core/utils/dimensions.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/favourite/presentation/provider/favourite_provider.dart';
import 'package:ecommerce_app/src/profile/features/theme/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AddressProvider>()),
        ChangeNotifierProvider(create: (_) => sl<FavouriteProvider>()),
        ChangeNotifierProvider(
          create: (_) => sl<ThemeProvider>(),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
