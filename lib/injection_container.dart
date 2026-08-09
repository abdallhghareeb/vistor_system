import 'package:get_it/get_it.dart';
import 'core/helper_function/api.dart';
import 'features/auth/data/datasources/remote.dart';
import 'features/auth/data/repositories/user_repo_impl.dart';
import 'features/auth/domain/repositories/user_repo.dart';
import 'features/auth/domain/usecases/user_usecases.dart';
import 'features/notification/data/data_sources/remote.dart';
import 'features/notification/data/repositories/notification_repo_impl.dart';
import 'features/notification/domain/repositories/notification_repo.dart';
import 'features/notification/domain/use_cases/notification_usecaese.dart';
import 'features/settings/data/datasources/remote.dart';
import 'features/settings/data/repositories/settings_repo_impl.dart';
import 'features/settings/domain/repositories/settings_repo.dart';
import 'features/settings/domain/usecases/settings_usecases.dart';
import 'features/scan/data/data_sources/remote.dart';
import 'features/scan/data/repositories/scan_repo_impl.dart';
import 'features/scan/domain/repositories/scan_repo.dart';
import 'features/scan/domain/usecases/scan_usecases.dart';
import 'features/visitors/data/data_sources/remote.dart';
import 'features/visitors/data/repositories/visitors_repo_impl.dart';
import 'features/visitors/domain/repositories/visitors_repo.dart';
import 'features/visitors/domain/usecases/visitors_usecases.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Existing
  sl.registerSingleton<ApiHandel>(ApiHandel.getInstance);

  sl.registerSingleton<SettingsRemoteDataSource>(
    SettingsRemoteDataSource(sl.get()),
  );
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl(sl.get()));
  sl.registerSingleton<SettingsUseCases>(SettingsUseCases(sl.get()));

  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource(sl.get()));
  sl.registerSingleton<UserRepo>(UserRepoImpl(authRemoteDatasource: sl.get()));
  sl.registerSingleton<UserUseCases>(UserUseCases(sl.get()));

  sl.registerSingleton<NotificationRemoteDataSource>(
    NotificationRemoteDataSource(sl.get()),
  );
  sl.registerSingleton<NotificationRepo>(NotificationRepoImpl(sl.get()));
  sl.registerSingleton<NotificationUseCases>(NotificationUseCases(sl.get()));

  sl.registerSingleton<ScanRemoteDataSource>(ScanRemoteDataSource(sl.get()));
  sl.registerSingleton<ScanRepo>(ScanRepoImpl(sl.get()));
  sl.registerSingleton<ScanUseCases>(ScanUseCases(sl.get()));

  sl.registerSingleton<VisitorsRemoteDataSource>(
    VisitorsRemoteDataSource(sl.get()),
  );
  sl.registerSingleton<VisitorsRepo>(VisitorsRepoImpl(sl.get()));
  sl.registerSingleton<VisitorsUseCases>(VisitorsUseCases(sl.get()));
}
