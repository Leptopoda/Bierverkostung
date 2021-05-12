// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:bierverkostung/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:bierverkostung/shared/constants.dart';
import 'package:bierverkostung/shared/master_details_scaffold.dart';

import 'package:bierverkostung/screens/settings/user_settings.dart';
import 'package:bierverkostung/screens/settings/about_us_settings.dart';
import 'package:bierverkostung/screens/settings/group_management.dart';
import 'package:bierverkostung/screens/settings/import_data_settings.dart';
import 'package:bierverkostung/screens/settings/notification_settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return MasterDetailContainer(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      master: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text(
              'Log Out',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext _) =>
                  (AuthService().getUser()!.isAnonymous)
                      ? const LogOutAnonAlert()
                      : const LogOutAlert(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group_add_outlined),
            title: const Text(
              'Group Management',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () =>
                _onTap(context, const GroupScreen(), 'Group Management'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () =>
                _onTap(context, const NotificationSettings(), 'Notifications'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.import_export_outlined),
            title: const Text(
              'Import Data',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () =>
                _onTap(context, const ImportDataSettings(), 'Import Data'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              'About this App',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => aboutUsDialog(context),
          ),
        ],
      ),
      detail: child,
    );
  }

  void _onTap(BuildContext context, Widget detail, String title) {
    if (isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: detail,
          ),
        ),
      );
    } else {
      setState(() {
        child = detail;
      });
    }
  }
}
