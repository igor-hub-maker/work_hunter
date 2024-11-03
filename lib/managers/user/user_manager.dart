import 'package:work_hunter/models/user.dart';

abstract class UserManager {
  Future<User?> getUserByUId(String uId);

  Future<void> createUser(User user);

  Future<void> editUser(User user);
}
