import 'package:flutter/material.dart';

import '../config/theme.dart';

class GlossListItem extends StatefulWidget {
  const GlossListItem({
    Key? key,
    required this.entryId,
    required this.gloss,
    required this.reference,
  }) : super(key: key);

  final int entryId;
  final String gloss;
  final String reference;

  @override
  State<GlossListItem> createState() => _GlossListItemState();
}

class _GlossListItemState extends State<GlossListItem> {
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 5.0),

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
            flex: 3,
            child: Text(
              widget.gloss,

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
              widget.reference,
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
