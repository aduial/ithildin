const String lexiconCognateView = 'lexicon_cognates';

class LexiconCognateFields {
  static final List<String> values = [
    /// Add all fields
    entryId, language, form, gloss, sources, cognateId
  ];

  static const String entryId = 'entry_id';
  static const String language = 'language';
  static const String form = 'form';
  static const String gloss = 'gloss';
  static const String sources = 'sources';
  static const String cognateId = 'cognate_id';
}

class LexiconCognate {

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String sources;
  final int cognateId;


  const LexiconCognate({
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    required this.sources,
    required this.cognateId,
  });

  LexiconCognate copy({
    int? entryId,
    String? language,
    String? form,
    String? gloss,
    String? sources,
    int? cognateId,
  }) {
    return LexiconCognate(
      entryId: entryId ?? this.entryId,
      language: language ?? this.language,
      form: form ?? this.form,
      gloss: gloss ?? this.gloss,
      sources: sources ?? this.sources,
      cognateId: cognateId ?? this.cognateId,
    );
  }

  static LexiconCognate fromJson(Map<String, Object?> json) => LexiconCognate(
    entryId: json[LexiconCognateFields.entryId] as int,
    language: json[LexiconCognateFields.language] as String,
    form: json[LexiconCognateFields.form] as String,
    gloss: json[LexiconCognateFields.gloss] as String?,
    sources: json[LexiconCognateFields.sources] as String,
    cognateId: json[LexiconCognateFields.cognateId] as int,
  );

  Map<String, Object?> toJson() => {
    LexiconCognateFields.entryId: entryId,
    LexiconCognateFields.language: language,
    LexiconCognateFields.form: form,
    LexiconCognateFields.gloss: gloss,
    LexiconCognateFields.sources: sources,
    LexiconCognateFields.cognateId: cognateId,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconCognate &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          language == other.language &&
          form == other.form &&
          gloss == other.gloss &&
          sources == other.sources&&
          cognateId == other.cognateId);

  @override
  int get hashCode =>
      entryId.hashCode ^
      language.hashCode ^
      form.hashCode ^
      gloss.hashCode ^
      sources.hashCode ^
      cognateId.hashCode;

  @override
  String toString() {
    return 'LexiconCognate{' +
        ' entryId: $entryId,' +
        ' language: $language,' +
        ' form: $form,' +
        ' gloss: $gloss,' +
        ' sources: $sources,' +
        ' cognateId: $cognateId,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'language': language,
      'form': form,
      'gloss': gloss,
      'sources': sources,
      'cognateId': cognateId,
    };
  }

  factory LexiconCognate.fromMap(Map<String, dynamic> map) {
    return LexiconCognate(
      entryId: map['entryId'] as int,
      language: map['language'] as String,
      form: map['form'] as String,
      gloss: map['gloss'] as String,
      sources: map['sources'] as String,
      cognateId: map['cognateId'] as int,
    );
  }
}