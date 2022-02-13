const String simplexiconTable = 'simplexicon';

class SimplexiconFields {
  static final List<String> values = [
    /// Add all fields
    id,
    mark,
    form,
    formLangId,
    formLangAbbr,
    gloss,
    glossLangId,
    cat,
    stem,
    entryClassId,
    entryClass,
    entryTypeId,
    entryType
  ];

  static const String id = 'id';
  static const String mark = 'mark';
  static const String form = 'form';
  static const String formLangId = 'form_lang_id';
  static const String formLangAbbr = 'form_lang_abbr';
  static const String gloss = 'gloss';
  static const String glossLangId = 'gloss_lang_id';
  static const String cat = 'cat';
  static const String stem = 'stem';
  static const String entryClassId = 'entry_class_id';
  static const String entryClass = 'entry_class';
  static const String entryTypeId = 'entry_type_id';
  static const String entryType = 'entry_type';
}

class Simplexicon {
  final int id;
  final String? mark;
  final String form;
  final int formLangId;
  final String formLangAbbr;
  final String gloss;
  final int glossLangId;
  final String? cat;
  final String? stem;
  final int entryClassId;
  final String entryClass;
  final int entryTypeId;
  final String entryType;

  const Simplexicon({
    required this.id,
    this.mark,
    required this.form,
    required this.formLangId,
    required this.formLangAbbr,
    required this.gloss,
    required this.glossLangId,
    this.cat,
    this.stem,
    required this.entryClassId,
    required this.entryClass,
    required this.entryTypeId,
    required this.entryType
  });

  Simplexicon copy({
    int? id,
    String? mark,
    String? form,
    int? formLangId,
    String?  formLangAbbr,
    String?  gloss,
    int?  glossLangId,
    String?  cat,
    String?  stem,
    int? entryClassId,
    String?  entryClass,
    int? entryTypeId,
    String?  entryType,
  }) =>
      Simplexicon(
        id: id ?? this.id,
        mark: mark ?? this.mark,
        form: form ?? this.form,
        formLangId: formLangId ?? this.formLangId,
        formLangAbbr: formLangAbbr ?? this.formLangAbbr,
        gloss: gloss ?? this.gloss,
        glossLangId: glossLangId ?? this.glossLangId,
        cat: cat ?? this.cat,
        stem: stem ?? this.stem,
        entryClassId: entryClassId ?? this.entryClassId,
        entryClass: entryClass ?? this.entryClass,
        entryTypeId: entryTypeId ?? this.entryTypeId,
        entryType: entryType ?? this.entryType,
      );

  static Simplexicon fromJson(Map<String, Object?> json) => Simplexicon(
        id: json[SimplexiconFields.id] as int,
        mark: json[SimplexiconFields.mark] as String?,
        form: json[SimplexiconFields.form] as String,
        formLangId: json[SimplexiconFields.formLangId] as int,
        formLangAbbr: json[SimplexiconFields.formLangAbbr] as String,
        gloss: json[SimplexiconFields.gloss] as String,
        glossLangId: json[SimplexiconFields.glossLangId] as int,
        cat: json[SimplexiconFields.cat] as String?,
        stem: json[SimplexiconFields.stem] as String?,
        entryClassId: json[SimplexiconFields.entryClassId] as int,
        entryClass: json[SimplexiconFields.entryClass] as String,
        entryTypeId: json[SimplexiconFields.entryTypeId] as int,
        entryType: json[SimplexiconFields.entryType] as String,
      );

  Map<String, Object?> toJson() => {
        SimplexiconFields.id: id,
        SimplexiconFields.mark: mark,
        SimplexiconFields.form: form,
        SimplexiconFields.formLangId: formLangId,
        SimplexiconFields.gloss: gloss,
        SimplexiconFields.glossLangId: glossLangId,
        SimplexiconFields.formLangAbbr: formLangAbbr,
        SimplexiconFields.cat: cat,
        SimplexiconFields.stem: stem,
        SimplexiconFields.entryClassId: entryClassId,
        SimplexiconFields.entryClass: entryClass,
        SimplexiconFields.entryTypeId: entryTypeId,
        SimplexiconFields.entryType: entryType,
      };


  /// avoids having to supply custom itemAsString and compareFn in calling widget
  String simplexiconAsString() {
    return '#$id $form';
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool? simplexiconFilterByName(String filter) {
    return form.toString().contains(filter);
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool isEqual(Simplexicon? simplex) {
    return id == simplex?.id;
  }

  @override
  String toString() => form;
}
