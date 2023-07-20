import 'package:selling_app/data/model/app_user.dart';

abstract class UserRepository {
  /// Sign in with [email] and [password] and return
  /// user data as [AppUser]
  Future<AppUser> signIn({
    required String email,
    required String password,
  });
}
