import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../config/colours.dart';
import '../config/config.dart';
import '../model/lexicon_header.dart';

class HeaderCard extends StatelessWidget {
  LexiconHeader header;
  String entryForm;
  String? createdBy;

  HeaderCard(this.header, this.entryForm, this.createdBy, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double toScale = (MediaQuery.of(context).size.width / refWidth) *
        (MediaQuery.of(context).size.height / refHeight);
    double widthScale = (MediaQuery.of(context).size.width / refWidth);
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                16 * toScale, 24 * toScale, 16 * toScale, 4 * toScale),
            child: Text(entryForm,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: MountainBlue, fontSize: 25 * toScale)),
          ),
          (createdBy?.isEmpty ?? true)
              ? Container(height: 0, width: 0)
              : Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      16 * toScale, 4 * toScale, 16 * toScale, 4 * toScale),
                  child: Text('created by: ' + (createdBy ?? ''),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: BlueGrey,
                          fontSize: 15 * toScale,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic)),
                ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  16 * toScale, 8 * toScale, 16 * toScale, 10 * toScale),
              child: AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: header.language!.toUpperCase() + '.  ',
                      style: const TextStyle(
                          color: ThemeTextColour2, fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: (header.type ?? '') + '  ',
                      style: const TextStyle(
                          color: MountainBlue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: header.gloss != null && header.gloss!.isNotEmpty
                          ? ' "' + (header.gloss ?? '') + '"'
                          : '',
                      style: const TextStyle(
                          color: MiddleGreen, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 20 * toScale),
                minFontSize: 12,
                stepGranularity: 2,
                maxLines: 2,
              )),
        ]);
  }
}
