const String lexiconRelatedView = 'lexicon_related';

class LexiconRelatedFields {
  static final List<String> values = [
    /// Add all fields
    entryId, formFrom, glossFrom, relation, formTo, glossTo
  ];

  static const String entryId = 'entry_id';
  static const String formFrom = 'form_from';
  static const String glossFrom = 'gloss_from';
  static const String relation = 'relatiom';
  static const String formTo = 'form_to';
  static const String glossTo = 'gloss_to';
}

class LexiconRelated {

  final int entryId;
  final String? formFrom;
  final String? glossFrom;
  final String? relation;
  final String? formTo;
  final String? glossTo;


  const LexiconRelated({
    required this.entryId,
    this.formFrom,
    this.glossFrom,
    this.relation,
    this.formTo,
    this.glossTo,
  });

  LexiconRelated copy({
    int? entryId,
    String? formFrom,
    String? glossFrom,
    String? relation,
    String? formTo,
    String? glossTo,
  }) {
    return LexiconRelated(
      entryId: entryId ?? this.entryId,
      formFrom: formFrom ?? this.formFrom,
      glossFrom: glossFrom ?? this.glossFrom,
      relation: relation ?? this.relation,
      formTo: formTo ?? this.formTo,
      glossTo: glossTo ?? this.glossTo,
    );
  }


  static LexiconRelated fromJson(Map<String, Object?> json) => LexiconRelated(
    entryId: json[LexiconRelatedFields.entryId] as int,
    formFrom: json[LexiconRelatedFields.formFrom] as String?,
    glossFrom: json[LexiconRelatedFields.glossFrom] as String?,
    relation: json[LexiconRelatedFields.relation] as String?,
    formTo: json[LexiconRelatedFields.formTo] as String?,
    glossTo: json[LexiconRelatedFields.glossTo] as String?,
  );

  Map<String, Object?> toJson() => {
    LexiconRelatedFields.entryId: entryId,
    LexiconRelatedFields.formFrom: formFrom,
    LexiconRelatedFields.glossFrom: glossFrom,
    LexiconRelatedFields.relation: relation,
    LexiconRelatedFields.formTo: formTo,
    LexiconRelatedFields.glossTo: glossTo,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconRelated &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          formFrom == other.formFrom &&
          glossFrom == other.glossFrom &&
          relation == other.relation &&
          formTo == other.formTo &&
          glossTo == other.glossTo);

  @override
  int get hashCode =>
      entryId.hashCode ^
      formFrom.hashCode ^
      glossFrom.hashCode ^
      relation.hashCode ^
      formTo.hashCode ^
      glossTo.hashCode;

  @override
  String toString() {
    return 'LexiconRelated{' +
        ' entryId: $entryId,' +
        ' formFrom: $formFrom,' +
        ' glossFrom: $glossFrom,' +
        ' relation: $relation,' +
        ' formTo: $formTo,' +
        ' glossTo: $glossTo,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'formFrom': this.formFrom,
      'glossFrom': this.glossFrom,
      'relation': this.relation,
      'formTo': this.formTo,
      'glossTo': this.glossTo,
    };
  }

  factory LexiconRelated.fromMap(Map<String, dynamic> map) {
    return LexiconRelated(
      entryId: map['entryId'] as int,
      formFrom: map['formFrom'] as String,
      glossFrom: map['glossFrom'] as String,
      relation: map['relation'] as String,
      glossTo: map['glossTo'] as String,
      formTo: map['formTo'] as String,
    );
  }
}