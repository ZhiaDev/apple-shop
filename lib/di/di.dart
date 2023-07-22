import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/datasource/authentication_datasource.dart';
import '/data/datasource/category_datasource.dart';
import '/data/repository/authentication_repository.dart';
import '/data/repository/category_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  // components
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/'),
    ),
  );

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // DataSource
  locator.registerFactory<IAuthenticationDataSource>(
    () => AuthenticationRemote(),
  );
  locator.registerFactory<ICategoryDataSource>(
    () => CategoryRemoteDataSource(),
  );

  // Repositories
  locator.registerFactory<IAuthenticationRepositiry>(
    () => AuthenticationRepository(),
  );
  locator.registerFactory<ICategoryRepository>(
    () => CategoryRepository(),
  );
}