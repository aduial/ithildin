const String lexiconRelatedView = 'lexicon_related';

class LexiconRelatedFields {
  static final List<String> values = [
    /// Add all fields
    entryId, languageFrom, formFrom, glossFrom, relation, languageTo, formTo, glossTo, refSources, relatedId
  ];

  static const String entryId = 'entry_id';
  static const String languageFrom = 'language_from';
  static const String formFrom = 'form_from';
  static const String glossFrom = 'gloss_from';
  static const String relation = 'relation';
  static const String languageTo = 'language_to';
  static const String formTo = 'form_to';
  static const String glossTo = 'gloss_to';
  static const String refSources = 'ref_sources';
  static const String relatedId = 'related_id';
}

class LexiconRelated {

  final int entryId;
  final String languageFrom;
  final String formFrom;
  final String glossFrom;
  final String relation;
  final String languageTo;
  final String formTo;
  final String glossTo;
  final String refSources;
  final int? relatedId;


  const LexiconRelated({
    required this.entryId,
    required this.languageFrom,
    required this.formFrom,
    required this.glossFrom,
    required this.relation,
    required this.languageTo,
    required this.formTo,
    required this.glossTo,
    required this.refSources,
    this.relatedId,
  });

  LexiconRelated copy({
    int? entryId,
    String? languageFrom,
    String? formFrom,
    String? glossFrom,
    String? relation,
    String? languageTo,
    String? formTo,
    String? glossTo,
    String? refSources,
    int? relatedId,
  }) {
    return LexiconRelated(
      entryId: entryId ?? this.entryId,
      languageFrom: languageFrom ?? this.languageFrom,
      formFrom: formFrom ?? this.formFrom,
      glossFrom: glossFrom ?? this.glossFrom,
      relation: relation ?? this.relation,
      languageTo: languageTo ?? this.languageTo,
      formTo: formTo ?? this.formTo,
      glossTo: glossTo ?? this.glossTo,
      refSources: refSources ?? this.refSources,
      relatedId: relatedId ?? this.relatedId,
    );
  }


  static LexiconRelated fromJson(Map<String, Object?> json) => LexiconRelated(
    entryId: json[LexiconRelatedFields.entryId] as int,
    languageFrom: json[LexiconRelatedFields.languageFrom] as String,
    formFrom: json[LexiconRelatedFields.formFrom] as String,
    glossFrom: json[LexiconRelatedFields.glossFrom] as String,
    relation: json[LexiconRelatedFields.relation] as String,
    languageTo: json[LexiconRelatedFields.languageTo] as String,
    formTo: json[LexiconRelatedFields.formTo] as String,
    glossTo: json[LexiconRelatedFields.glossTo] as String,
    refSources: json[LexiconRelatedFields.refSources] as String,
    relatedId: json[LexiconRelatedFields.relatedId] as int?,
  );

  Map<String, Object?> toJson() => {
    LexiconRelatedFields.entryId: entryId,
    LexiconRelatedFields.languageFrom: languageFrom,
    LexiconRelatedFields.formFrom: formFrom,
    LexiconRelatedFields.glossFrom: glossFrom,
    LexiconRelatedFields.relation: relation,
    LexiconRelatedFields.languageTo: languageTo,
    LexiconRelatedFields.formTo: formTo,
    LexiconRelatedFields.glossTo: glossTo,
    LexiconRelatedFields.refSources: refSources,
    LexiconRelatedFields.relatedId: relatedId,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconRelated &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          languageFrom == other.languageFrom &&
          formFrom == other.formFrom &&
          glossFrom == other.glossFrom &&
          relation == other.relation &&
          languageTo == other.languageTo &&
          formTo == other.formTo &&
          glossTo == other.glossTo &&
          refSources == other.refSources &&
          relatedId == other.relatedId
      );

  @override
  int get hashCode =>
      entryId.hashCode ^
      languageFrom.hashCode ^
      formFrom.hashCode ^
      glossFrom.hashCode ^
      relation.hashCode ^
      languageTo.hashCode ^
      formTo.hashCode ^
      glossTo.hashCode ^
      refSources.hashCode ^
      relatedId.hashCode ;

  @override
  String toString() {
    return 'LexiconRelated{' +
        ' entryId: $entryId,' +
        ' languageFrom: $languageFrom,' +
        ' formFrom: $formFrom,' +
        ' glossFrom: $glossFrom,' +
        ' relation: $relation,' +
        ' languageTo: $languageTo,' +
        ' formTo: $formTo,' +
        ' glossTo: $glossTo,' +
        ' refSources: $refSources,' +
        ' relatedId: $relatedId,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'languageFrom': this.languageFrom,
      'formFrom': this.formFrom,
      'glossFrom': this.glossFrom,
      'relation': this.relation,
      'languageTo': this.languageTo,
      'formTo': this.formTo,
      'glossTo': this.glossTo,
      'refSources': this.refSources,
      'relatedId': this.relatedId,
    };
  }

  factory LexiconRelated.fromMap(Map<String, dynamic> map) {
    return LexiconRelated(
      entryId: map['entryId'] as int,
      languageFrom: map['languageFrom'] as String,
      formFrom: map['formFrom'] as String,
      glossFrom: map['glossFrom'] as String,
      relation: map['relation'] as String,
      languageTo: map['languageTo'] as String,
      formTo: map['formTo'] as String,
      glossTo: map['glossTo'] as String,
      refSources: map['refSources'] as String,
      relatedId: map['relatedId'] as int,
    );
  }
}