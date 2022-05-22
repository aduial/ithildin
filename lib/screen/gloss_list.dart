import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

class GlossListItem extends StatefulWidget {
  const GlossListItem({
    Key? key,
    required this.entryId,
    required this.gloss,
    required this.sources,
  }) : super(key: key);

  final int entryId;
  final String gloss;
  final String sources;

  @override
  State<GlossListItem> createState() => _GlossListItemState();
}

class _GlossListItemState extends State<GlossListItem> {
  String htmlData = "";
  void initState() {
    htmlData += CSSGreenItalic + '"' + widget.gloss + '"' + CloseSpan +  "&nbsp;&nbsp;";
    htmlData += cssText +  widget.sources + CloseSpan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Html(data: htmlData),
          ),
        ],
      ),
    );
  }
}
