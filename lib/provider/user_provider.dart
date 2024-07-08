
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier{
  User? _user;
  final AuthMethod _authMethod = AuthMethod();


  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetail();
    _user = user;
    notifyListeners();
  }
}