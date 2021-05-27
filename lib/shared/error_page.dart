// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;
import 'package:flutter/material.dart';
import 'package:bierverkostung/gen/assets.gen.dart';

class SomethingWentWrong extends StatelessWidget {
  final String error;
  const SomethingWentWrong({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    developer.log(
      'generic error',
      name: 'leptopoda.bierverkostung.SomethingWentWrong',
      error: jsonEncode(error.toString()),
    );
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Assets.error.image(),
              ),
              const SizedBox(height: 35),
              Text(
                'Die Einhörner versuchen dieses Problem schnellstens zu beheben. Um ihnen zu helfen gebe folgenden error weiter: $error',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
