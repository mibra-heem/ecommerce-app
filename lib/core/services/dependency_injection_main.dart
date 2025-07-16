part of 'dependency_injection.dart';

final sl = GetIt.instance;

/// Injectiing Dependencies

Future<void> init() async {
  await dotenv.load();
  await _initApiClient();
  await _initLocalStorage();
  await _initTheme();
  await _initHome();
}

// Setup ApiClient
Future<void> _initApiClient() async {
  sl.registerLazySingleton(() => const ApiService(baseUrl: ApiConst.baseUrl));
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
    ..registerFactory(
      () => HomeProvider(
        getBanners: sl(),
        getCategories: sl(),
        getProducts: sl(),
      ),
    )
    ..registerLazySingleton(() => GetBanners(sl()))
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(sl()),
    )
    ..registerLazySingleton<HomeRemoteDataSrc>(
      () => HomeRemoteDataSrcImpl(sl()),
    );
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
