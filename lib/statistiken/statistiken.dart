// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/database.dart';

class Statistiken extends StatefulWidget {
  @override
  State<Statistiken> createState() => _StatistikenState();
}

class _StatistikenState extends State<Statistiken> {
  List<Map> _consumed = [];

  @override
  void initState() => update();

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _consumed.length * 2,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          return _buildRow(_consumed[index].toString());
        });
  }

  void update() {
    SQLiteDbProvider.db
        .getAllKonsum()
        .then((value) => setState(() => _consumed = value));
  }

  Widget _buildRow(String consum) {
    return ListTile(
      title: Text(
        consum,
        style: _biggerFont,
      ),
    );
  }
}

class StatistikenFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => new StatistikenAlert(),
      ),
      child: Icon(Icons.add),
    );
  }
}

enum _bier { klein, gross }
final _biggerFont = TextStyle(fontSize: 18.0);

class StatistikenAlert extends StatefulWidget {
  @override
  State<StatistikenAlert> createState() => _StatistikenAlertState();
}

class _StatistikenAlertState extends State<StatistikenAlert> {
  _bier? _character = _bier.gross;
  static int _menge = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Noch ein Bier"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RadioListTile<_bier>(
              title: const Text('Klein (0.3)'),
              value: _bier.klein,
              groupValue: _character,
              //TODO: use tehme
              activeColor: Colors.yellow,
              onChanged: (_bier? value) => setState(() => _character = value),
            ),
            RadioListTile<_bier>(
              title: const Text('Groß (0.5)'),
              value: _bier.gross,
              groupValue: _character,
              activeColor: Colors.yellow,
              onChanged: (_bier? value) => setState(() => _character = value),
            ),
            Slider(
              value: _menge.toDouble(),
              min: 1,
              max: 5,
              onChanged: (double value) =>
                  setState(() => _menge = value.round()),
              divisions: 4,
              label: "$_menge",
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: Text('Submit'),
            onPressed: () {
              switch (_character) {
                case _bier.klein:
                  SQLiteDbProvider.db.insertKonsum(0.33);
                  break;
                case _bier.gross:
                  SQLiteDbProvider.db.insertKonsum(0.5);
                  break;
              }

              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
