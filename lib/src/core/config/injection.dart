/// This file manages the dependency injection.
// ignore_for_file: cascade_invocations

library dependency_injection;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:teach_savvy/src/core/api/network_adapter.dart';
import 'package:teach_savvy/src/core/data/secure_storage_helper.dart';
import 'package:teach_savvy/src/core/data/storage_abstracts.dart';
import 'package:teach_savvy/src/core/routes/pages.dart';
import 'package:teach_savvy/src/core/services/connectivity.dart';
import 'package:teach_savvy/src/features/login/data/implements/implements.dart';
import 'package:teach_savvy/src/features/login/data/sources/sources.dart';
import 'package:teach_savvy/src/features/login/domain/repositories/login_repository.dart';
import 'package:teach_savvy/src/features/login/domain/usecases/login_user.dart';
import 'package:teach_savvy/src/features/login/presentation/cubit/login_cubit.dart';

// Global instance of GetIt for dependency injection
final getIt = GetIt.instance;

/// Initializes all required dependencies.
Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register core dependencies
  getIt
    ..registerSingleton<AppRouter>(AppRouter()) // Navigation router
    ..registerSingleton<HttpAdapter>(HttpAdapter()) // Network adapter
    ..registerSingleton<ConnectivityService>(
      ConnectivityService(),
    ) // Connection checker
    ..registerSingleton<IKeyValueDataSource>(
      await KeyValueDataSource.create(),
    ) // Key-Value data source
    ..registerSingleton<IKeyValueSecureDataSource>(
      await KeyValueSecureDataSource.create(),
    ) // Secure data source
    ..registerSingleton<SecureStorageHelper>(
      SecureStorageHelper(
        keyValueSecureDataSource: getIt(),
      ), // Secure storage helper
    )
    // Register repositories
    ..registerLazySingleton<ILoginRepository>(
      () => LoginRepositoryImp(
        remoteDataSource: getIt(),
      ), // Implementation of the login repository
    )
    // Register data sources
    ..registerLazySingleton<ILoginRemoteDataSource>(
      () => LoginRemoteDataSource(
        httpAdapter: getIt(),
      ), // Remote data source for login
    )

    // Register use cases
    ..registerLazySingleton<ULoginUser>(
      () => ULoginUser(
        loginRepository: getIt(),
      ), // Use case for logging in a user
    )

    // Register BLoCs
    ..registerFactory<LoginCubitImpl>(
      () => LoginCubitImpl(getIt()), // BLoC for managing login state
    );
}

/// Access method for retrieving dependencies.
T get<T extends Object>() {
  return getIt<T>();
}
