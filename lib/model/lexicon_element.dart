const String lexiconElementView = 'lexicon_elements';

class LexiconElementFields {
  static final List<String> values = [
    /// Add all fields
    entryId, language, form, gloss, sources, inflections, elementId
  ];

  static const String entryId = 'entry_id';
  static const String language = 'language';
  static const String form = 'form';
  static const String gloss = 'gloss';
  static const String inflections = 'inflections';
  static const String sources = 'sources';
  static const String elementId = 'element_id';
}

class LexiconElement {

  final int entryId;
  final String language;
  final String form;
  final String? gloss;
  final String? inflections;
  final String? sources;
  final int elementId;


  const LexiconElement({
    required this.entryId,
    required this.language,
    required this.form,
    this.gloss,
    this.inflections,
    this.sources,
    required this.elementId,
  });

  LexiconElement copy({
    int? entryId,
    String? language,
    String? form,
    String? gloss,
    String? inflections,
    String? sources,
    int? elementId,
  }) {
    return LexiconElement(
      entryId: entryId ?? this.entryId,
      language: language ?? this.language,
      form: form ?? this.form,
      gloss: gloss ?? this.gloss,
      inflections: inflections ?? this.inflections,
      sources: sources ?? this.sources,
      elementId: elementId ?? this.elementId,
    );
  }


  static LexiconElement fromJson(Map<String, Object?> json) => LexiconElement(
    entryId: json[LexiconElementFields.entryId] as int,
    language: json[LexiconElementFields.language] as String,
    form: json[LexiconElementFields.form] as String,
    gloss: json[LexiconElementFields.gloss] as String?,
    inflections: json[LexiconElementFields.inflections] as String?,
    sources: json[LexiconElementFields.sources] as String?,
    elementId: json[LexiconElementFields.elementId] as int,
  );

  Map<String, Object?> toJson() => {
    LexiconElementFields.entryId: entryId,
    LexiconElementFields.language: language,
    LexiconElementFields.form: form,
    LexiconElementFields.gloss: gloss,
    LexiconElementFields.inflections: inflections,
    LexiconElementFields.sources: sources,
    LexiconElementFields.elementId: elementId,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconElement &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          language == other.language &&
          form == other.form &&
          gloss == other.gloss &&
          inflections == other.inflections &&
          sources == other.sources &&
          elementId == other.elementId
      );

  @override
  int get hashCode =>
      entryId.hashCode ^
      language.hashCode ^
      form.hashCode ^
      gloss.hashCode ^
      inflections.hashCode ^
      sources.hashCode ^
      elementId.hashCode ;

  @override
  String toString() {
    return 'LexiconElement{' +
        ' entryId: $entryId,' +
        ' language: $language,' +
        ' form: $form,' +
        ' gloss: $gloss,' +
        ' inflections: $inflections,' +
        ' sources: $sources,' +
        ' elementId: $elementId,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'language': this.language,
      'form': this.form,
      'gloss': this.gloss,
      'inflections': this.inflections,
      'sources': this.sources,
      'elementId': this.elementId,
    };
  }

  factory LexiconElement.fromMap(Map<String, dynamic> map) {
    return LexiconElement(
      entryId: map['entryId'] as int,
      language: map['language'] as String,
      form: map['form'] as String,
      gloss: map['gloss'] as String,
      inflections: map['inflections'] as String,
      sources: map['sources'] as String,
      elementId: map['elementId'] as int,
    );
  }
}