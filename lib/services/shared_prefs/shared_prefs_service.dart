abstract class SharedPrefsService {
  Future<bool> getIsFirstLaunch();
  Future<void> settIsFirstLaunch(bool value);
}
