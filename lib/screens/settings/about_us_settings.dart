// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

@Deprecated(
    'We do not need this class anymore. It will be removed in a future cleanup')
class AboutUsSettings extends StatelessWidget {
  const AboutUsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: const Center(
        child: Text('coming'),
      ),
    );
  }
}

Future<void> aboutUsDialog(BuildContext context) async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  showAboutDialog(
    context: context,
    applicationIcon: Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/icon/icon.svg',
      ),
    ),
    applicationName: packageInfo.appName,
    applicationVersion: packageInfo.version,
    applicationLegalese: '©2021 Leptopoda',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: 'This is an open source app made with love in my free time. '
              'You can help the development, report issues or audit the code at '
              'https://gitlab.rimikis.de/Leptopoda/bierverkostung',
        ),
      ),
    ],
  );
}
