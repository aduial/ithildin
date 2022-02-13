const String lexiconGlossView = 'lexicon_glosses';

class LexiconGlossFields {
  static final List<String> values = [
    /// Add all fields
    entryId, gloss, reference
  ];

  static const String entryId = 'entry_id';
  static const String gloss = 'gloss';
  static const String reference = 'reference';
}

class LexiconGloss {

  final int entryId;
  final String gloss;
  final String reference;


  const LexiconGloss({
    required this.entryId,
    required this.gloss,
    required this.reference,
  });

  LexiconGloss copy({
    int? entryId,
    String? gloss,
    String? reference,
  }) {
    return LexiconGloss(
      entryId: entryId ?? this.entryId,
      gloss: gloss ?? this.gloss,
      reference: reference ?? this.reference,
    );
  }


  static LexiconGloss fromJson(Map<String, Object?> json) => LexiconGloss(
    entryId: json[LexiconGlossFields.entryId] as int,
    gloss: json[LexiconGlossFields.gloss] as String,
    reference: json[LexiconGlossFields.reference] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconGlossFields.entryId: entryId,
    LexiconGlossFields.gloss: gloss,
    LexiconGlossFields.reference: reference,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconGloss &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          gloss == other.gloss &&
          reference == other.reference);

  @override
  int get hashCode =>
      entryId.hashCode ^
      gloss.hashCode ^
      reference.hashCode;

  @override
  String toString() {
    return 'LexiconGloss{' +
        ' entryId: $entryId,' +
        ' gloss: $gloss,' +
        ' reference: $reference,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'gloss': this.gloss,
      'reference': this.reference,
    };
  }

  factory LexiconGloss.fromMap(Map<String, dynamic> map) {
    return LexiconGloss(
      entryId: map['entryId'] as int,
      gloss: map['gloss'] as String,
      reference: map['reference'] as String,
    );
  }
}