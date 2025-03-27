import 'package:get_it/get_it.dart';
import 'source/remote/api_client.dart';
import 'source/remote/dio/dio_api_client.dart';
import 'modules/dashboard/dashboard_provider.dart';
import 'modules/home/home_provider.dart';

final getIt = GetIt.instance;

void getItSetup() {
  /// ------------- Register a lazy singleton for Dio API Client. -------------

  getIt.registerLazySingleton<ApiClient>(() => DioApiClient());

  /// ------------- Register a factory for Providers. -------------

  getIt.registerFactory<DashboardProvider>(() => DashboardProvider());

  getIt.registerFactory<HomeProvider>(() => HomeProvider(getIt()));
}
