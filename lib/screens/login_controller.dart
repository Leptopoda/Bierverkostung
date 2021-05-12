// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:bierverkostung/screens/home.dart';
import 'package:bierverkostung/screens/login/login.dart';

class LoginController extends StatelessWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: maybe use authservice.getUser != null
    final User? _user = Provider.of<User?>(context);
    final bool _loggedIn = _user != null;

    if (_loggedIn) {
      return const MyHome();
    } else {
      return const Login();
    }
  }
}
