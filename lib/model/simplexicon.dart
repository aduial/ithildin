const String simplexiconTable = 'simplexicon';

class SimplexiconFields {
  static final List<String> values = [
    /// Add all fields
    entryId,
    mark,
    form,
    formLangId,
    formLangAbbr,
    gloss,
    glossLangId,
    cat,
    stem,
    entrytypeId
  ];

  static const String entryId = 'entry_id';
  static const String mark = 'mark';
  static const String form = 'form';
  static const String formLangId = 'form_lang_id';
  static const String formLangAbbr = 'form_lang_abbr';
  static const String gloss = 'gloss';
  static const String glossLangId = 'gloss_lang_id';
  static const String cat = 'cat';
  static const String stem = 'stem';
  static const String entrytypeId = 'entrytype_id';
}

class Simplexicon {
  final int entryId;
  final String mark;
  final String form;
  final int formLangId;
  final String formLangAbbr;
  final String gloss;
  final int glossLangId;
  final String cat;
  final String stem;
  final int entrytypeId;

  const Simplexicon({
    required this.entryId,
    required this.mark,
    required this.form,
    required this.formLangId,
    required this.formLangAbbr,
    required this.gloss,
    required this.glossLangId,
    required this.cat,
    required this.stem,
    required this.entrytypeId,
  });

  Simplexicon copy({
    int? entryId,
    String? mark,
    String? form,
    int? formLangId,
    String? formLangAbbr,
    String? gloss,
    int? glossLangId,
    String? cat,
    String? stem,
    int? entrytypeId,
  }) =>
      Simplexicon(
        entryId: entryId ?? this.entryId,
        mark: mark ?? this.mark,
        form: form ?? this.form,
        formLangId: formLangId ?? this.formLangId,
        formLangAbbr: formLangAbbr ?? this.formLangAbbr,
        gloss: gloss ?? this.gloss,
        glossLangId: glossLangId ?? this.glossLangId,
        cat: cat ?? this.cat,
        stem: stem ?? this.stem,
        entrytypeId: entrytypeId ?? this.entrytypeId,
      );

  static Simplexicon fromJson(Map<String, Object?> json) => Simplexicon(
        entryId: json[SimplexiconFields.entryId] as int,
        mark: json[SimplexiconFields.mark] as String,
        form: json[SimplexiconFields.form] as String,
        formLangId: json[SimplexiconFields.formLangId] as int,
        formLangAbbr: json[SimplexiconFields.formLangAbbr] as String,
        gloss: json[SimplexiconFields.gloss] as String,
        glossLangId: json[SimplexiconFields.glossLangId] as int,
        cat: json[SimplexiconFields.cat] as String,
        stem: json[SimplexiconFields.stem] as String,
        entrytypeId: json[SimplexiconFields.entrytypeId] as int,
      );

  Map<String, Object?> toJson() => {
        SimplexiconFields.entryId: entryId,
        SimplexiconFields.mark: mark,
        SimplexiconFields.form: form,
        SimplexiconFields.formLangId: formLangId,
        SimplexiconFields.formLangAbbr: formLangAbbr,
        SimplexiconFields.gloss: gloss,
        SimplexiconFields.glossLangId: glossLangId,
        SimplexiconFields.cat: cat,
        SimplexiconFields.stem: stem,
        SimplexiconFields.entrytypeId: entrytypeId,
      };




  /// avoids having to supply custom itemAsString and compareFn in calling widget
  String simplexiconAsString() {
    return '#$entryId $form';
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool? simplexiconFilterByName(String filter) {
    return form.toString().contains(filter);
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool isEqual(Simplexicon? simplex) {
    return entryId == simplex?.entryId;
  }

  @override
  String toString() => form;
}
