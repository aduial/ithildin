const String lexiconVariationView = 'lexicon_variations';

class LexiconVariationFields {
  static final List<String> values = [
    /// Add all fields
    entryId, mark, form, sources
  ];

  static const String entryId = 'entry_id';
  static const String mark = 'mark';
  static const String form = 'form';
  static const String sources = 'sources';
}

class LexiconVariation {

  final int entryId;
  final String mark;
  final String form;
  final String sources;


  const LexiconVariation({
    required this.entryId,
    required this.mark,
    required this.form,
    required this.sources,
  });

  LexiconVariation copy({
    int? entryId,
    String? mark,
    String? form,
    String? sources,
  }) {
    return LexiconVariation(
      entryId: entryId ?? this.entryId,
      mark: mark ?? this.mark,
      form: form ?? this.form,
      sources: sources ?? this.sources,
    );
  }

  static LexiconVariation fromJson(Map<String, Object?> json) => LexiconVariation(
    entryId: json[LexiconVariationFields.entryId] as int,
    mark: json[LexiconVariationFields.mark] as String,
    form: json[LexiconVariationFields.form] as String,
    sources: json[LexiconVariationFields.sources] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconVariationFields.entryId: entryId,
    LexiconVariationFields.mark: mark,
    LexiconVariationFields.form: form,
    LexiconVariationFields.sources: sources,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconVariation &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          mark == other.mark &&
          form == other.form &&
          sources == other.sources);

  @override
  int get hashCode =>
      entryId.hashCode ^
      mark.hashCode ^
      form.hashCode ^
      sources.hashCode;

  @override
  String toString() {
    return 'lexiconVariation{' +
        ' entryId: $entryId,' +
        ' mark: $mark,' +
        ' form: $form,' +
        ' sources: $sources,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'mark': this.mark,
      'form': this.form,
      'sources': this.sources,
    };
  }

  factory LexiconVariation.fromMap(Map<String, dynamic> map) {
    return LexiconVariation(
      entryId: map['entryId'] as int,
      mark: map['mark'] as String,
      form: map['form'] as String,
      sources: map['sources'] as String,
    );
  }
}