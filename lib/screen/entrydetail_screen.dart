import 'package:flutter/material.dart';

class EntryDetailScreen extends StatelessWidget {

  EntryDetailScreen(this.entryId, {Key? key}) : super(key: key);
  int? entryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Detail page for Entry# ' + entryId.toString()),
      ),
    );
  }
}