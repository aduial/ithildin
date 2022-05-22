const String lexiconSeeView = 'lexicon_see';

class LexiconSeeFields {
  static final List<String> values = [
    /// Add all fields
    entryId, language, form, see, seeId
  ];

  static const String entryId = 'entry_id';
  static const String language = 'language';
  static const String form = 'form';
  static const String see = 'see';
  static const String seeId = 'see_id';
}

class LexiconSee {

  final int entryId;
  final String language;
  final String form;
  final String see;
  final int seeId;


  const LexiconSee({
    required this.entryId,
    required this.language,
    required this.form,
    required this.see,
    required this.seeId,
  });

  LexiconSee copy({
    int? entryId,
    String? language,
    String? form,
    String? see,
    int? seeId,
  }) {
    return LexiconSee(
      entryId: entryId ?? this.entryId,
      language: language ?? this.language,
      form: form ?? this.form,
      see: see ?? this.see,
      seeId: seeId ?? this.seeId,
    );
  }

  static LexiconSee fromJson(Map<String, Object?> json) => LexiconSee(
    entryId: json[LexiconSeeFields.entryId] as int,
    language: json[LexiconSeeFields.language] as String,
    form: json[LexiconSeeFields.form] as String,
    see: json[LexiconSeeFields.see] as String,
    seeId: json[LexiconSeeFields.seeId] as int,
  );

  Map<String, Object?> toJson() => {
    LexiconSeeFields.entryId: entryId,
    LexiconSeeFields.language: language,
    LexiconSeeFields.form: form,
    LexiconSeeFields.see: see,
    LexiconSeeFields.seeId: seeId,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconSee &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          language == other.language &&
          form == other.form &&
          see == other.see&&
          seeId == other.seeId);

  @override
  int get hashCode =>
      entryId.hashCode ^
      language.hashCode ^
      form.hashCode ^
      see.hashCode ^
      seeId.hashCode;

  @override
  String toString() {
    return 'lexiconSee{' +
        ' entryId: $entryId,' +
        ' language: $language,' +
        ' form: $form,' +
        ' see: $see,' +
        ' seeId: $seeId,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'language': language,
      'form': form,
      'see': see,
      'seeId': seeId,
    };
  }

  factory LexiconSee.fromMap(Map<String, dynamic> map) {
    return LexiconSee(
      entryId: map['entryId'] as int,
      language: map['language'] as String,
      form: map['form'] as String,
      see: map['see'] as String,
      seeId: map['seeId'] as int,
    );
  }
}