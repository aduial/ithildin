const String lexiconCombineView = 'lexicon_combine';

class LexiconCombineFields {
  static final List<String> values = [
    /// Add all fields
    entryId, formFrom, langFrom, idTo,  formTo, langTo
  ];

  static const String entryId = 'entry_id';
  static const String formFrom = 'form_from';
  static const String langFrom = 'lang_from';
  static const String idTo = 'id_to';
  static const String formTo = 'form_to';
  static const String langTo = 'lang_to';
}

class LexiconCombine {

  final int entryId;
  final String formFrom;
  final String langFrom;
  final int idTo;
  final String formTo;
  final String langTo;


  const LexiconCombine({
    required this.entryId,
    required this.formFrom,
    required this.langFrom,
    required this.idTo,
    required this.formTo,
    required this.langTo,
  });

  LexiconCombine copy({
    int? entryId,
    String? formFrom,
    String? langFrom,
    int? idTo,
    String? formTo,
    String? langTo,
  }) {
    return LexiconCombine(
      entryId: entryId ?? this.entryId,
      formFrom: formFrom ?? this.formFrom,
      langFrom: langFrom ?? this.langFrom,
      idTo: idTo ?? this.idTo,
      formTo: formTo ?? this.formTo,
      langTo: langTo ?? this.langTo,
    );
  }


  static LexiconCombine fromJson(Map<String, Object?> json) => LexiconCombine(
    entryId: json[LexiconCombineFields.entryId] as int,
    formFrom: json[LexiconCombineFields.formFrom] as String,
    langFrom: json[LexiconCombineFields.langFrom] as String,
    idTo: json[LexiconCombineFields.idTo] as int,
    formTo: json[LexiconCombineFields.formTo] as String,
    langTo: json[LexiconCombineFields.langTo] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconCombineFields.entryId: entryId,
    LexiconCombineFields.formFrom: formFrom,
    LexiconCombineFields.langFrom: langFrom,
    LexiconCombineFields.idTo: idTo,
    LexiconCombineFields.formTo: formTo,
    LexiconCombineFields.langTo: langTo,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconCombine &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          formFrom == other.formFrom &&
          langFrom == other.langFrom &&
          idTo == other.idTo &&
          formTo == other.formTo &&
          langTo == other.langTo
      );

  @override
  int get hashCode =>
      entryId.hashCode ^
      formFrom.hashCode ^
      langFrom.hashCode ^
      idTo.hashCode ^
      formTo.hashCode ^
      langTo.hashCode;

  @override
  String toString() {
    return 'LexiconCombine{' +
        ' entryId: $entryId,' +
        ' formFrom: $formFrom,' +
        ' langFrom: $langFrom,' +
        ' idTo: $idTo,' +
        ' formTo: $formTo,' +
        ' langTo: $langTo,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'formFrom': this.formFrom,
      'langFrom': this.langFrom,
      'idTo': this.idTo,
      'formTo': this.formTo,
      'langTo': this.langTo,
    };
  }

  factory LexiconCombine.fromMap(Map<String, dynamic> map) {
    return LexiconCombine(
      entryId: map['entryId'] as int,
      formFrom: map['formFrom'] as String,
      langFrom: map['langFrom'] as String,
      idTo: map['idTo'] as int,
      formTo: map['formTo'] as String,
      langTo: map['langTo'] as String,
    );
  }
}