part of 'dependency_injection.dart';

final sl = GetIt.instance;

/// Injectiing Dependencies
Future<void> init() async {
  await dotenv.load();
  await _initApiClient();
  await _initLocalStorage();
  await _initTheme();
  await _initHome();
  await _initCart();
  await _initAddress();
  await _initPayment();
}

// Setup ApiClient
Future<void> _initApiClient() async {
  sl.registerLazySingleton(() => ApiService(baseUrl: ApiConfig.baseUrl));
}

// Inject Local Storage instance
Future<void> _initLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );
}

/// Feature --> Home
Future<void> _initHome() async {
  sl
    ..registerLazySingleton<HomeRemoteDataSrc>(
      () => HomeRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(sl()),
    )
    ..registerLazySingleton(() => GetBanners(sl()))
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerFactory(
      () => HomeBloc(
        getBanners: sl(),
        getCategories: sl(),
        getProducts: sl(),
      ),
    );
}

/// Feature --> Cart
Future<void> _initCart() async {
  sl.registerLazySingleton<CartProvider>(CartProvider.new);
}

/// Feature --> Address
Future<void> _initAddress() async {
  sl.registerLazySingleton<AddressProvider>(AddressProvider.new);
}

/// Feature --> Payment
Future<void> _initPayment() async {
  sl.registerLazySingleton<PaymentProvider>(PaymentProvider.new);
}

/// Feature --> Theme
Future<void> _initTheme() async {
  sl
    ..registerFactory(
      () => ThemeProvider(cacheThemeMode: sl(), loadThemeMode: sl()),
    )
    ..registerLazySingleton(() => CacheThemeMode(sl()))
    ..registerLazySingleton(() => LoadThemeMode(sl()))
    ..registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl()))
    ..registerLazySingleton<ThemeLocalDataSrc>(
      () => ThemeLocalDataSrcImpl(
        prefs: sl(),
      ),
    );
}
