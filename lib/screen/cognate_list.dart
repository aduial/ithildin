import 'package:flutter/material.dart';

import '../config/theme.dart';

class CognateListItem extends StatefulWidget {
  const CognateListItem({
    Key? key,
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    required this.sources,
  }) : super(key: key);

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String sources;

  @override
  State<CognateListItem> createState() => _CognateListItemState();
}

class _CognateListItemState extends State<CognateListItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 1.0,
              color: DividerColour
          ),
        ),
        // color: MiddleGreen,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.language,

              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: MiddleGreen),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Text(
              widget.form,
              style: Theme.of(context)
                  .textTheme.bodyText2!
                  .copyWith(fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: BluerGrey),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child: Text(
              widget.gloss??' ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: MiddleGreen),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Text(
              widget.sources,
              style: Theme.of(context)
                  .textTheme.bodyText2!
                  .copyWith(fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: BluerGrey),
            ),
          ),
        ],
      ),
    );
  }
}
