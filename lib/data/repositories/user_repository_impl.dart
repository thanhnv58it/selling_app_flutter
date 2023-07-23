import 'dart:convert';

import 'package:selling_app/data/model/app_user.dart';
import 'package:selling_app/data/repositories/abstract/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:selling_app/config/server_addresses.dart';
import 'utils.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    var route = HttpClient().createUri(ServerAddresses.loginPath);
    var data = <String, String>{
      'username': email,
      'password': password,
    };

    var response = await http.post(route, body: data);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw jsonResponse['message'];
    }
    return AppUser.fromJson(jsonResponse);
  }
}
