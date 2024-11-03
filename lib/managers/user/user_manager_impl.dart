import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/models/user.dart';

class UserManagerImpl implements UserManager {
  final usersStore = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshots, _) => User.fromJsonm(snapshots.data()!),
        toFirestore: (User employerUser, _) => employerUser.toJson(),
      );

  @override
  Future<void> createUser(User user) {
    return usersStore.add(user);
  }

  @override
  Future<User?> getUserByUId(String uId) async {
    final users = await usersStore.where("uId", isEqualTo: uId).get();
    if (users.docs.isEmpty) {
      return null;
    }

    return users.docs.first.data();
  }

  @override
  Future<void> editUser(User user) async {
    final snapshot = await usersStore.where("uId", isEqualTo: user.uId).get();
    return usersStore.doc(snapshot.docs.first.id).update(user.toJson());
  }
}
