const String lexiconVariationView = 'lexicon_variations';

class LexiconVariationFields {
  static final List<String> values = [
    /// Add all fields
    entryId, mark, lform, typeId, varsource
  ];

  static const String entryId = 'entry_id';
  static const String mark = 'mark';
  static const String lform = 'lform';
  static const String typeId = 'type_id';
  static const String varsource = 'varsource';
}

class LexiconVariation {

  final int entryId;
  final String mark;
  final String lform;
  final int typeId;
  final String varsource;


  const LexiconVariation({
    required this.entryId,
    required this.mark,
    required this.lform,
    required this.typeId,
    required this.varsource,
  });

  LexiconVariation copy({
    int? entryId,
    String? mark,
    String? lform,
    int? typeId,
    String? varsource,
  }) {
    return LexiconVariation(
      entryId: entryId ?? this.entryId,
      mark: mark ?? this.mark,
      lform: lform ?? this.lform,
      typeId: typeId ?? this.typeId,
      varsource: varsource ?? this.varsource,
    );
  }

  static LexiconVariation fromJson(Map<String, Object?> json) => LexiconVariation(
    entryId: json[LexiconVariationFields.entryId] as int,
    mark: json[LexiconVariationFields.mark] as String,
    lform: json[LexiconVariationFields.lform] as String,
    typeId: json[LexiconVariationFields.typeId] as int,
    varsource: json[LexiconVariationFields.varsource] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconVariationFields.entryId: entryId,
    LexiconVariationFields.mark: mark,
    LexiconVariationFields.lform: lform,
    LexiconVariationFields.typeId: typeId,
    LexiconVariationFields.varsource: varsource,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconVariation &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          mark == other.mark &&
          lform == other.lform &&
          typeId == other.typeId &&
          varsource == other.varsource);

  @override
  int get hashCode =>
      entryId.hashCode ^
      mark.hashCode ^
      lform.hashCode ^
      typeId.hashCode ^
      varsource.hashCode;

  @override
  String toString() {
    return 'lexiconVariation{' +
        ' entryId: $entryId,' +
        ' mark: $mark,' +
        ' lform: $lform,' +
        ' typeId: $typeId,' +
        ' varsource: $varsource,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'mark': this.mark,
      'lform': this.lform,
      'typeId': this.typeId,
      'varsource': this.varsource,
    };
  }

  factory LexiconVariation.fromMap(Map<String, dynamic> map) {
    return LexiconVariation(
      entryId: map['entryId'] as int,
      mark: map['mark'] as String,
      lform: map['lform'] as String,
      typeId: map['typeId'] as int,
      varsource: map['varsource'] as String,
    );
  }
}