import 'package:get_it/get_it.dart';
import 'core/helper_function/api.dart';
import 'features/auth/data/datasources/remote.dart';
import 'features/auth/data/repositories/user_repo_impl.dart';
import 'features/auth/domain/repositories/user_repo.dart';
import 'features/auth/domain/usecases/user_usecases.dart';
import 'features/excuse/data/datasources/remote.dart';
import 'features/excuse/data/repositories/excuse_repo_impl.dart';
import 'features/excuse/domain/repositories/excuse_repo.dart';
import 'features/excuse/domain/usecases/excuse_usecases.dart';
import 'features/history/data/datasources/remote.dart';
import 'features/history/data/repositories/history_repo_impl.dart';
import 'features/history/domain/repositories/history_repo.dart';
import 'features/history/domain/usecases/history_usecases.dart';
import 'features/notification/data/data_sources/remote.dart';
import 'features/notification/data/repositories/notification_repo_impl.dart';
import 'features/notification/domain/repositories/notification_repo.dart';
import 'features/notification/domain/use_cases/notification_usecaese.dart';
import 'features/settings/data/datasources/remote.dart';
import 'features/settings/data/repositories/settings_repo_impl.dart';
import 'features/settings/domain/repositories/settings_repo.dart';
import 'features/settings/domain/usecases/settings_usecases.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Existing
  sl.registerSingleton<ApiHandel>(ApiHandel.getInstance);

  sl.registerSingleton<SettingsRemoteDataSource>(SettingsRemoteDataSource(sl.get()));
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl(sl.get()));
  sl.registerSingleton<SettingsUseCases>(SettingsUseCases(sl.get()));

  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource(sl.get()));
  sl.registerSingleton<UserRepo>(UserRepoImpl(authRemoteDatasource: sl.get()));
  sl.registerSingleton<UserUseCases>(UserUseCases(sl.get()));

  sl.registerSingleton<NotificationRemoteDataSource>(NotificationRemoteDataSource(sl.get()),);
  sl.registerSingleton<NotificationRepo>(NotificationRepoImpl(sl.get()));
  sl.registerSingleton<NotificationUseCases>(NotificationUseCases(sl.get()));

  sl.registerSingleton<HistoryRemoteDataSource>(HistoryRemoteDataSource(sl.get()),);
  sl.registerSingleton<HistoryRepo>(HistoryRepoImpl(sl.get()));
  sl.registerSingleton<HistoryUsecases>(HistoryUsecases(sl.get()));

  sl.registerSingleton<ExcuseRemoteDataSource>(ExcuseRemoteDataSource(sl.get()),);
  sl.registerSingleton<ExcuseRepo>(ExcuseRepoImpl(sl.get()));
  sl.registerSingleton<ExcuseUsecases>(ExcuseUsecases(sl.get()));

}