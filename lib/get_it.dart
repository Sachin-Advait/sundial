import 'package:get_it/get_it.dart';
import 'modules/login/login_provider.dart';
import 'modules/splash/splash_provider.dart';
import 'modules/dashboard/dashboard_provider.dart';

final getIt = GetIt.instance;

void getItSetup() {
  /// ------------- Register a lazy singleton for Dio API Client. -------------

  // getIt.registerLazySingleton<ApiClient>(() => DioApiClient());

  /// ------------- Register a factory for Providers. -------------

  getIt.registerFactory<SplashProvider>(() => SplashProvider());

  getIt.registerFactory<LoginProvider>(() => LoginProvider());

  getIt.registerFactory<DashboardProvider>(() => DashboardProvider());
}
