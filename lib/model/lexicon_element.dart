const String lexiconElementView = 'lexicon_elements';

class LexiconElementFields {
  static final List<String> values = [
    /// Add all fields
    entryId, formFrom, glossFrom, inflection, idTo,  formTo, glossTo
  ];

  static const String entryId = 'entry_id';
  static const String formFrom = 'form_from';
  static const String glossFrom = 'gloss_from';
  static const String inflection = 'inflection';
  static const String idTo = 'id_to';
  static const String formTo = 'form_to';
  static const String glossTo = 'gloss_to';
}

class LexiconElement {

  final int entryId;
  final String formFrom;
  final String? glossFrom;
  final String inflection;
  final int idTo;
  final String formTo;
  final String? glossTo;


  const LexiconElement({
    required this.entryId,
    required this.formFrom,
    this.glossFrom,
    required this.inflection,
    required this.idTo,
    required this.formTo,
    this.glossTo,
  });

  LexiconElement copy({
    int? entryId,
    String? formFrom,
    String? glossFrom,
    String? inflection,
    int? idTo,
    String? formTo,
    String? glossTo,
  }) {
    return LexiconElement(
      entryId: entryId ?? this.entryId,
      formFrom: formFrom ?? this.formFrom,
      glossFrom: glossFrom ?? this.glossFrom,
      inflection: inflection ?? this.inflection,
      idTo: idTo ?? this.idTo,
      formTo: formTo ?? this.formTo,
      glossTo: glossTo ?? this.glossTo,
    );
  }


  static LexiconElement fromJson(Map<String, Object?> json) => LexiconElement(
    entryId: json[LexiconElementFields.entryId] as int,
    formFrom: json[LexiconElementFields.formFrom] as String,
    glossFrom: json[LexiconElementFields.glossFrom] as String?,
    inflection: json[LexiconElementFields.inflection] as String,
    idTo: json[LexiconElementFields.idTo] as int,
    formTo: json[LexiconElementFields.formTo] as String,
    glossTo: json[LexiconElementFields.glossTo] as String?,
  );

  Map<String, Object?> toJson() => {
    LexiconElementFields.entryId: entryId,
    LexiconElementFields.formFrom: formFrom,
    LexiconElementFields.glossFrom: glossFrom,
    LexiconElementFields.inflection: inflection,
    LexiconElementFields.idTo: idTo,
    LexiconElementFields.formTo: formTo,
    LexiconElementFields.glossTo: glossTo,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconElement &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          formFrom == other.formFrom &&
          glossFrom == other.glossFrom &&
          inflection == other.inflection &&
          idTo == other.idTo &&
          formTo == other.formTo &&
          glossTo == other.glossTo
      );

  @override
  int get hashCode =>
      entryId.hashCode ^
      formFrom.hashCode ^
      glossFrom.hashCode ^
      inflection.hashCode ^
      idTo.hashCode ^
      formTo.hashCode ^
      glossTo.hashCode;

  @override
  String toString() {
    return 'LexiconElement{' +
        ' entryId: $entryId,' +
        ' formFrom: $formFrom,' +
        ' glossFrom: $glossFrom,' +
        ' inflection: $inflection,' +
        ' idTo: $idTo,' +
        ' formTo: $formTo,' +
        ' glossTo: $glossTo,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'formFrom': this.formFrom,
      'glossFrom': this.glossFrom,
      'inflection': this.inflection,
      'idTo': this.idTo,
      'formTo': this.formTo,
      'glossTo': this.glossTo,
    };
  }

  factory LexiconElement.fromMap(Map<String, dynamic> map) {
    return LexiconElement(
      entryId: map['entryId'] as int,
      formFrom: map['formFrom'] as String,
      glossFrom: map['glossFrom'] as String,
      inflection: map['inflection'] as String,
      idTo: map['idTo'] as int,
      formTo: map['formTo'] as String,
      glossTo: map['glossTo'] as String,
    );
  }
}