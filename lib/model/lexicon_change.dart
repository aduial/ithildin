const String lexiconChangeView = 'lexicon_changes';

class LexiconChangeFields {
  static final List<String> values = [
    /// Add all fields
    entryId, markFrom, formFrom, formTo, sources, idTo
  ];

  static const String entryId = 'entry_id';
  static const String markFrom = 'mark_from';
  static const String formFrom = 'form_from';
  static const String markTo = 'mark_to';
  static const String formTo = 'form_to';
  static const String sources = 'sources';
  static const String idTo = 'id_to';
}

class LexiconChange {

  final int entryId;
  final String markFrom;
  final String formFrom;
  final String markTo;
  final String formTo;
  final String sources;
  final int idTo;


  const LexiconChange({
    required this.entryId,
    required this.markFrom,
    required this.formFrom,
    required this.markTo,
    required this.formTo,
    required this.sources,
    required this.idTo,
  });

  LexiconChange copy({
    int? entryId,
    String? markFrom,
    String? formFrom,
    String? markTo,
    String? formTo,
    String? sources,
    int? idTo,
  }) {
    return LexiconChange(
      entryId: entryId ?? this.entryId,
      markFrom: markFrom ?? this.markFrom,
      formFrom: formFrom ?? this.formFrom,
      markTo: markTo ?? this.markTo,
      formTo: formTo ?? this.formTo,
      sources: sources ?? this.sources,
      idTo: idTo ?? this.idTo,
    );
  }

  static LexiconChange fromJson(Map<String, Object?> json) => LexiconChange(
    entryId: json[LexiconChangeFields.entryId] as int,
    markFrom: json[LexiconChangeFields.markFrom] as String,
    formFrom: json[LexiconChangeFields.formFrom] as String,
    markTo: json[LexiconChangeFields.markTo] as String,
    formTo: json[LexiconChangeFields.formTo] as String,
    sources: json[LexiconChangeFields.sources] as String,
    idTo: json[LexiconChangeFields.idTo] as int,
  );

  Map<String, Object?> toJson() => {
    LexiconChangeFields.entryId: entryId,
    LexiconChangeFields.markFrom: markFrom,
    LexiconChangeFields.formFrom: formFrom,
    LexiconChangeFields.markTo: markTo,
    LexiconChangeFields.formTo: formTo,
    LexiconChangeFields.sources: sources,
    LexiconChangeFields.idTo: idTo,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconChange &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          markFrom == other.markFrom &&
          formFrom == other.formFrom &&
          markTo == other.markTo &&
          formTo == other.formTo &&
          sources == other.sources &&
          idTo == other.idTo);

  @override
  int get hashCode =>
      entryId.hashCode ^
      markFrom.hashCode ^
      formFrom.hashCode ^
      markTo.hashCode ^
      formTo.hashCode ^
      sources.hashCode ^
      idTo.hashCode;

  @override
  String toString() {
    return 'lexiconChange{' +
        ' entryId: $entryId,' +
        ' markFrom: $markFrom,' +
        ' formFrom: $formFrom,' +
        ' markTo: $markTo,' +
        ' formTo: $formTo,' +
        ' sources: $sources,' +
        ' idTo: $idTo,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'markFrom': markFrom,
      'formFrom': formFrom,
      'markTo': markTo,
      'formTo': formTo,
      'sources': sources,
      'idTo': idTo,
    };
  }

  factory LexiconChange.fromMap(Map<String, dynamic> map) {
    return LexiconChange(
      entryId: map['entryId'] as int,
      markFrom: map['markFrom'] as String,
      formFrom: map['formFrom'] as String,
      markTo: map['markTo'] as String,
      formTo: map['formTo'] as String,
      sources: map['sources'] as String,
      idTo: map['idTo'] as int,
    );
  }
}