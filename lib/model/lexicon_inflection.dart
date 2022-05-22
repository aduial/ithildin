const String lexiconInflectionView = 'lexicon_inflections';

class LexiconInflectionFields {
  static final List<String> values = [
    /// Add all fields
    entryId, mark, form, inflections, gloss, references
  ];

  static const String entryId = 'entry_id';
  static const String mark = 'mark';
  static const String form = 'form';
  static const String inflections = 'inflections';
  static const String gloss = 'gloss';
  static const String references = 'references';
}

class LexiconInflection {

  final int entryId;
  final String mark;
  final String form;
  final String inflections;
  final String? gloss;
  final String? references;


  const LexiconInflection({
    required this.entryId,
    required this.mark,
    required this.form,
    required this.inflections,
    this.gloss,
    this.references,
  });

  LexiconInflection copy({
    int? entryId,
    String? mark,
    String? form,
    String? inflections,
    String? gloss,
    String? references,
  }) {
    return LexiconInflection(
      entryId: entryId ?? this.entryId,
      mark: mark ?? this.mark,
      form: form ?? this.form,
      inflections: inflections ?? this.inflections,
      gloss: gloss ?? this.gloss,
      references: references ?? this.references,
    );
  }

  static LexiconInflection fromJson(Map<String, Object?> json) => LexiconInflection(
    entryId: json[LexiconInflectionFields.entryId] as int,
    mark: json[LexiconInflectionFields.mark] as String,
    form: json[LexiconInflectionFields.form] as String,
    inflections: json[LexiconInflectionFields.inflections] as String,
    gloss: json[LexiconInflectionFields.gloss] as String?,
    references: json[LexiconInflectionFields.references] as String?,
  );

  Map<String, Object?> toJson() => {
    LexiconInflectionFields.entryId: entryId,
    LexiconInflectionFields.mark: mark,
    LexiconInflectionFields.form: form,
    LexiconInflectionFields.inflections: inflections,
    LexiconInflectionFields.gloss: gloss,
    LexiconInflectionFields.references: references,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconInflection &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          mark == other.mark &&
          form == other.form &&
          inflections == other.inflections &&
          gloss == other.gloss &&
          references == other.references);

  @override
  int get hashCode =>
      entryId.hashCode ^
      mark.hashCode ^
      form.hashCode ^
      inflections.hashCode ^
      gloss.hashCode ^
      references.hashCode;

  @override
  String toString() {
    return 'LexiconInflection{ '
        'entryId: $entryId, '
        'mark: $mark, '
        'form: $form, '
        'inflections: $inflections, '
        'gloss: $gloss, '
        'references: $references}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'mark': mark,
      'form': form,
      'inflections': inflections,
      'gloss': gloss,
      'references': references
    };
  }

  factory LexiconInflection.fromMap(Map<String, dynamic> map) {
    return LexiconInflection(
      entryId: map['entryId'] as int,
      mark: map['mark'] as String,
      form: map['form'] as String,
      inflections: map['inflections'] as String,
      gloss: map['gloss'] as String,
      references: map['references'] as String,
    );
  }
}