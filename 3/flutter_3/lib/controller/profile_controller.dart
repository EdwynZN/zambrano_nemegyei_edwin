import 'package:flutter/material.dart';
import 'package:flutter_3/model/user_profile.dart';

class UserProfileNotifier extends ChangeNotifier {
  UserProfile _profile;

  UserProfileNotifier(this._profile);

  UserProfile get profile => _profile;

  void updateProfile({
    required final String name,
    required final DateTime birthday,
    required final String email,
    required final String password,
    final int? phone,
    final String? instagram,
  }) {
    _profile = UserProfile(
      name: name,
      birthday: birthday,
      email: email,
      password: password,
      phone: phone,
      instagram: instagram,
    );
    notifyListeners();
  }
}
