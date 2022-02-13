const String lexiconHeaderView = 'lexicon_header';

class LexiconHeaderFields {
  static final List<String> values = [
    /// Add all fields
    entryId, language, form, type, gloss, cat
  ];

  static const String entryId = 'entry_id';
  static const String language = 'language';
  static const String form = 'form';
  static const String type = 'type';
  static const String gloss = 'gloss';
  static const String cat = 'cat';
}

class LexiconHeader {

  final int entryId;
  final String? language;
  final String? form;
  final String? type;
  final String? gloss;
  final String? cat;


  const LexiconHeader({
    required this.entryId,
    this.language,
    this.form,
    this.type,
    this.gloss,
    this.cat,
  });

  LexiconHeader copy({
    int? entryId,
    String? language,
    String? form,
    String? type,
    String? gloss,
    String? cat,
  }) {
    return LexiconHeader(
      entryId: entryId ?? this.entryId,
      language: language ?? this.language,
      form: form ?? this.form,
      type: type ?? this.type,
      gloss: gloss ?? this.gloss,
      cat: cat ?? this.cat,
    );
  }


  static LexiconHeader fromJson(Map<String, Object?> json) => LexiconHeader(
    entryId: json[LexiconHeaderFields.entryId] as int,
    language: json[LexiconHeaderFields.language] as String?,
    form: json[LexiconHeaderFields.form] as String?,
    type: json[LexiconHeaderFields.type] as String?,
    gloss: json[LexiconHeaderFields.gloss] as String?,
    cat: json[LexiconHeaderFields.cat] as String?,
  );

  Map<String, Object?> toJson() => {
    LexiconHeaderFields.entryId: entryId,
    LexiconHeaderFields.language: language,
    LexiconHeaderFields.form: form,
    LexiconHeaderFields.type: type,
    LexiconHeaderFields.gloss: gloss,
    LexiconHeaderFields.cat: cat,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconHeader &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          language == other.language &&
          form == other.form &&
          type == other.type &&
          gloss == other.gloss &&
          cat == other.cat);

  @override
  int get hashCode =>
      entryId.hashCode ^
      language.hashCode ^
      form.hashCode ^
      type.hashCode ^
      gloss.hashCode ^
      cat.hashCode;

  @override
  String toString() {
    return 'LexiconHeader{' +
        ' entryId: $entryId,' +
        ' language: $language,' +
        ' form: $form,' +
        ' type: $type,' +
        ' gloss: $gloss,' +
        ' cat: $cat,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'language': this.language,
      'form': this.form,
      'type': this.type,
      'gloss': this.gloss,
      'cat': this.cat,
    };
  }

  factory LexiconHeader.fromMap(Map<String, dynamic> map) {
    return LexiconHeader(
      entryId: map['entryId'] as int,
      language: map['language'] as String,
      form: map['form'] as String,
      type: map['type'] as String,
      gloss: map['gloss'] as String,
      cat: map['cat'] as String,
    );
  }
}