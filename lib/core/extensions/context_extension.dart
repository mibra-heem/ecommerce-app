import 'package:ecommerce_app/src/profile/features/theme/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext{
  ThemeData get theme => Theme.of(this);
  ColorScheme get color => theme.colorScheme;
  TextTheme get text => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  // UserProvider get userProvider => read<UserProvider>();
  // LocalUser? get currentUser => userProvider.user;

  ThemeProvider get themeProvider => read<ThemeProvider>();
  ThemeMode get themeMode => watch<ThemeProvider>().themeMode;
  bool get isDarkMode => themeMode == ThemeMode.dark;


}
