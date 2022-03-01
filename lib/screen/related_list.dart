import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/colours.dart';

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

  String htmlData = "";

  void initState() {
    if (widget.formFrom != null){
      htmlData += "<b>" + CSSTextTheme + (widget.formFrom?? "") + EndSpan + "</b>&nbsp";
    }
    if (widget.glossFrom != null){
      htmlData += CSSGreen + (widget.glossFrom?? "") + EndSpan + "&nbsp";
    }
    if (widget.relation != null){
      htmlData += CSSBlueGrey + (widget.relation?? "") + EndSpan + "&nbsp";
    }
    if (widget.formTo != null){
      htmlData += "<i><b>" + CSSBlueGrey + (widget.formTo?? "") + EndSpan + "</b></i>&nbsp";
    }
    if (widget.glossTo != null){
      htmlData += "<b>" + CSSGreen + (widget.glossTo?? "") + EndSpan + "</b>&nbsp";
    }

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
              fit: FlexFit.tight,
              flex: 1,
              child: Html(data: htmlData),




        // child: RichText(
        //         text: TextSpan(
        //           text: widget.formFrom ?? '',
        //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //               fontWeight: FontWeight.w800,
        //               fontSize: 12,
        //               color: BluerGrey),
        //           children: <TextSpan>[
        //             TextSpan(
        //               text: widget.glossFrom ?? '',
        //               style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                   fontWeight: FontWeight.w400,
        //                   fontSize: 12,
        //                   color: MiddleGreen),
        //             ),
        //             TextSpan(
        //               text: widget.relation ?? '',
        //               style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                   fontWeight: FontWeight.w300,
        //                   fontSize: 12,
        //                   color: BluerGrey),
        //             ),
        //             TextSpan(
        //               text: widget.formTo ?? '',
        //               style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                   fontWeight: FontWeight.w600,
        //                   fontStyle: FontStyle.italic,
        //                   fontSize: 12,
        //                   color: BluerGrey),
        //             ),
        //             TextSpan(
        //               text: widget.glossTo ?? ' ',
        //               style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                   fontWeight: FontWeight.w600,
        //                   fontStyle: FontStyle.normal,
        //                   fontSize: 12,
        //                   color: MiddleGreen),
        //             ),
        //           ],
        //         ),
        //       )

          ),
        ],
      ),
    );
  }
}
