const String lexiconGlossView = 'lexicon_glosses';

class LexiconGlossFields {
  static final List<String> values = [
    /// Add all fields
    entryId, gloss, sources
  ];

  static const String entryId = 'entry_id';
  static const String gloss = 'gloss';
  static const String sources = 'sources';
}

class LexiconGloss {

  final int entryId;
  final String gloss;
  final String sources;


  const LexiconGloss({
    required this.entryId,
    required this.gloss,
    required this.sources,
  });

  LexiconGloss copy({
    int? entryId,
    String? gloss,
    String? sources,
  }) {
    return LexiconGloss(
      entryId: entryId ?? this.entryId,
      gloss: gloss ?? this.gloss,
      sources: sources ?? this.sources,
    );
  }


  static LexiconGloss fromJson(Map<String, Object?> json) => LexiconGloss(
    entryId: json[LexiconGlossFields.entryId] as int,
    gloss: json[LexiconGlossFields.gloss] as String,
    sources: json[LexiconGlossFields.sources] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconGlossFields.entryId: entryId,
    LexiconGlossFields.gloss: gloss,
    LexiconGlossFields.sources: sources,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconGloss &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          gloss == other.gloss &&
          sources == other.sources);

  @override
  int get hashCode =>
      entryId.hashCode ^
      gloss.hashCode ^
      sources.hashCode;

  @override
  String toString() {
    return 'LexiconGloss{' +
        ' entryId: $entryId,' +
        ' gloss: $gloss,' +
        ' sources: $sources,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'gloss': this.gloss,
      'sources': this.sources,
    };
  }

  factory LexiconGloss.fromMap(Map<String, dynamic> map) {
    return LexiconGloss(
      entryId: map['entryId'] as int,
      gloss: map['gloss'] as String,
      sources: map['sources'] as String,
    );
  }
}