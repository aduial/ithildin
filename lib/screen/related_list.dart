import 'package:flutter/material.dart';

import '../config/theme.dart';

class RelatedListItem extends StatefulWidget {
  const RelatedListItem({
    Key? key,
    required this.entryId,
    this.formFrom,
    this.glossFrom,
    this.relation,
    this.formTo,
    this.glossTo,
  }) : super(key: key);

  final int entryId;
  final String? formFrom;
  final String? glossFrom;
  final String? relation;
  final String? formTo;
  final String? glossTo;

  @override
  State<RelatedListItem> createState() => _RelatedListItemState();
}

class _RelatedListItemState extends State<RelatedListItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: DividerColour),
        ),
        // color: MiddleGreen,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.formFrom??' ',
              style: Theme.of(context)
                  .textTheme.bodyText2!
                  .copyWith(fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: BluerGrey),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.glossFrom??' ',
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
            flex: 1,
            child: Text(
              widget.relation??' ',
              style: Theme.of(context)
                  .textTheme.bodyText2!
                  .copyWith(fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: BluerGrey),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.formTo??' ',
              style: Theme.of(context)
                  .textTheme.bodyText2!
                  .copyWith(fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: BluerGrey),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.glossTo??' ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: MiddleGreen),
            ),
          ),
        ],
      ),
    );
  }
}
