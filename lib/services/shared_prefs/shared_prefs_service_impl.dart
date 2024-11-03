import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hunter/services/shared_prefs/shared_prefs_service.dart';

class SharedPrefsServiceImpl implements SharedPrefsService {
  @override
  Future<bool> getIsFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isFirstLaunch') ?? true;
  }

  @override
  Future<void> settIsFirstLaunch(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isFirstLaunch', value);
  }
}
