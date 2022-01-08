import 'package:flutter/material.dart';

class SLexListItem extends StatelessWidget {
  const SLexListItem({
    Key? key,
    required this.formLangAbbr,
    required this.mark,
    required this.form,
    required this.gloss,
  }) : super(key: key);

  final String formLangAbbr;
  final String mark;
  final String form;
  final String gloss;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              formLangAbbr,
              style: const TextStyle(
                color: Colors.limeAccent,
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              mark,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              form,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w900,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Text(
              gloss,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
