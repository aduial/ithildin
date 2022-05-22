import 'package:flutter/material.dart';

import '../config/colours.dart';

class NoteListItem extends StatefulWidget {
  const NoteListItem({
    Key? key,
    required this.entryId,
    required this.docId,
    required this.doc,
    required this.docTypeId,
    required this.docType,
  }) : super(key: key);

  final int entryId;
  final int docId;
  final String doc;
  final int docTypeId;
  final String docType;

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: LightBlueGrey),
        ),
        // color: MiddleGreen,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              widget.doc,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: BlueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
