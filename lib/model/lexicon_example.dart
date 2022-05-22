const String lexiconExampleView = 'lexicon_examples';

class LexiconExampleFields {
  static final List<String> values = [
    /// Add all fields
    entryId, form, source
  ];

  static const String entryId = 'entry_id';
  static const String form = 'form';
  static const String source = 'source';
}

class LexiconExample {

  final int entryId;
  final String form;
  final String source;


  const LexiconExample({
    required this.entryId,
    required this.form,
    required this.source,
  });

  LexiconExample copy({
    int? entryId,
    String? form,
    String? source,
  }) {
    return LexiconExample(
      entryId: entryId ?? this.entryId,
      form: form ?? this.form,
      source: source ?? this.source,
    );
  }


  static LexiconExample fromJson(Map<String, Object?> json) => LexiconExample(
    entryId: json[LexiconExampleFields.entryId] as int,
    form: json[LexiconExampleFields.form] as String,
    source: json[LexiconExampleFields.source] as String,
  );

  Map<String, Object?> toJson() => {
    LexiconExampleFields.entryId: entryId,
    LexiconExampleFields.form: form,
    LexiconExampleFields.source: source,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LexiconExample &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          form == other.form &&
          source == other.source);

  @override
  int get hashCode =>
      entryId.hashCode ^
      form.hashCode ^
      source.hashCode;

  @override
  String toString() {
    return 'lexiconExample{ '
        'entryId: $entryId, '
        'form: $form, '
        'source: $source,}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'form': form,
      'source': source,
    };
  }

  factory LexiconExample.fromMap(Map<String, dynamic> map) {
    return LexiconExample(
      entryId: map['entryId'] as int,
      form: map['form'] as String,
      source: map['source'] as String,
    );
  }
}