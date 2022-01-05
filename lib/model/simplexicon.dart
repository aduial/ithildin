final String tableLanguages = 'simplexicon';

class SimplexiconFields {
  static final List<String> values = [
    /// Add all fields
    entryId,
    mark,
    form,
    languageId,
    languageName,
    gloss,
    cat,
    stem,
    entrytypeId
  ];

  static const String entryId = 'entry_id';
  static const String mark = 'mark';
  static const String form = 'form';
  static const String languageId = 'language_id';
  static const String languageName = 'languagename';
  static const String gloss = 'gloss';
  static const String cat = 'cat';
  static const String stem = 'stem';
  static const String entrytypeId = 'entrytype_id';
}

class Simplexicon {
  final int entryId;
  final String mark;
  final String form;
  final int languageId;
  final String languageName;
  final String gloss;
  final String? cat;
  final String? stem;
  final int entrytypeId;

  const Simplexicon({
    required this.entryId,
    required this.mark,
    required this.form,
    required this.languageId,
    required this.languageName,
    required this.gloss,
    this.cat,
    this.stem,
    required this.entrytypeId,
  });

  Simplexicon copy({
    int? entryId,
    String? mark,
    String? form,
    int? languageId,
    String? languageName,
    String? gloss,
    String? cat,
    String? stem,
    int? entrytypeId,
  }) =>
      Simplexicon(
        entryId: entryId ?? this.entryId,
        mark: mark ?? this.mark,
        form: form ?? this.form,
        languageId: languageId ?? this.languageId,
        languageName: languageName ?? this.languageName,
        gloss: gloss ?? this.gloss,
        cat: cat ?? this.cat,
        stem: stem ?? this.stem,
        entrytypeId: entrytypeId ?? this.entrytypeId,
      );

  static Simplexicon fromJson(Map<String, Object?> json) => Simplexicon(
        entryId: json[SimplexiconFields.entryId] as int,
        mark: json[SimplexiconFields.mark] as String,
        form: json[SimplexiconFields.form] as String,
        languageId: json[SimplexiconFields.languageId] as int,
        languageName: json[SimplexiconFields.languageName] as String,
        gloss: json[SimplexiconFields.gloss] as String,
        cat: json[SimplexiconFields.cat] as String?,
        stem: json[SimplexiconFields.stem] as String?,
        entrytypeId: json[SimplexiconFields.entrytypeId] as int,
      );

  Map<String, Object?> toJson() => {
        SimplexiconFields.entryId: entryId,
        SimplexiconFields.mark: mark,
        SimplexiconFields.form: form,
        SimplexiconFields.languageId: languageId,
        SimplexiconFields.languageName: languageName,
        SimplexiconFields.gloss: gloss,
        SimplexiconFields.cat: cat,
        SimplexiconFields.stem: stem,
        SimplexiconFields.entrytypeId: entrytypeId,
      };
}
