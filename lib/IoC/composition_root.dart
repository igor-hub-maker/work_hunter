import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/auth/auth_manager_impl.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/managers/job/job_manager_impl.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/managers/user/user_manager_impl.dart';
import 'package:work_hunter/services/shared_prefs/shared_prefs_service.dart';
import 'package:work_hunter/services/shared_prefs/shared_prefs_service_impl.dart';

class CompositionRoot {
  static final injector = Injector.appInstance;

  static void initialize() {
    registerServices();
    registerManagers();
    registerProviders();
  }

  static void registerServices() {
    injector.registerDependency<SharedPrefsService>(() => SharedPrefsServiceImpl());
  }

  static void registerManagers() {
    injector.registerDependency<JobManager>(() => JobManagerImpl());
    injector.registerDependency<AuthManager>(() => AuthManagerImpl());
    injector.registerDependency<UserManager>(() => UserManagerImpl());
  }

  static void registerProviders() {}
}
